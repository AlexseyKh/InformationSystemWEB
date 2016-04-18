/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package security.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.Objects;
import java.util.Set;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlTransient;
import org.hibernate.annotations.LazyToOne;
import org.hibernate.annotations.LazyToOneOption;


/**
 *
 * @author Игорь
 */

@Entity
@Table(name="PERMISSION_SEC", schema="COMPANY")
public class Permission implements Serializable {

    @Id
    @Column(name="ID")  
    @XmlAttribute
    private long id;
    
    @Column(name="NAME")
    @XmlAttribute
    private String name;  
    
    @ManyToMany(mappedBy = "permissions")
    private Set<Role> roles = new LinkedHashSet();
    

    public Permission() {
    }

    public Permission(String name) {
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
    public Set<Role> getRoles() {
        return roles;
    }

    public void setRoles(LinkedHashSet<Role> roles) {       
        this.roles = roles;        
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
        final Permission other = (Permission) obj;
        if (!Objects.equals(this.name, other.name)) {
            return false;
        }
        if (!Objects.equals(this.roles, other.roles)) {
            return false;
        }
        return true;
    }
 
}
