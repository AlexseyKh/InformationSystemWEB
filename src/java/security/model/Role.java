/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package security.model;

import java.io.Serializable;
import java.util.LinkedHashSet;
import java.util.Objects;
import java.util.Set;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Игорь
 */

@Entity
@Table(name="ROLE_SEC", schema="COMPANY")
public class Role implements Serializable {

    @Id
    @Column(name="ID")  
    @XmlAttribute
    private long id;
    
    @Column(name="NAME")
    @XmlAttribute
    private String name;  
    
    @ManyToMany(mappedBy = "roles")
    private Set<User> users = new LinkedHashSet();
    
    @ManyToMany(cascade = {CascadeType.ALL})
    @JoinTable(name ="ROLE_PERMISSION", 
    joinColumns = {@JoinColumn(name = "ROLE_ID") },
    inverseJoinColumns = {@JoinColumn(name = "PERMISSION_ID") })
    private Set<Permission> permissions = new LinkedHashSet();
    

    public Role() {
    }

    public Role(String name) {
        this.id = System.currentTimeMillis();
        this.name = name;  
    }
    
    @XmlTransient
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    @XmlTransient
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }    
    
    @XmlTransient
    public Set<User> getUsers() {
        return users;
    }

    public void setUsers(LinkedHashSet<User> users) {       
        this.users = users;        
    }
    
    @XmlTransient
    public Set<Permission> getPermissions() {
        return permissions;
    }
    
    public void setPermissions(LinkedHashSet<Permission> permissions) {
        this.permissions = permissions;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 41 * hash + Objects.hashCode(this.name);
        return hash;
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final Role other = (Role) obj;
        if (!Objects.equals(this.users, other.users)) {
            return false;
        }
        if (!Objects.equals(this.name, other.name)) {
            return false;
        }
        if (!Objects.equals(this.permissions, other.permissions)) {
            return false;
        }
        return true;
    }
 
}
