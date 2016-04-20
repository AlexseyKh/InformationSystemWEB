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
@Table(name="USER_SEC", schema="COMPANY")
public class User implements Serializable {

    @Id
    @Column(name="ID")  
    @XmlAttribute
    private long id;
    
    @Column(name="USERNAME")
    @XmlAttribute
    private String username; 
    
    @Column(name="PASSWORD")
    @XmlAttribute
    private String password; 
    
    @Column(name="SALT")
    @XmlAttribute
    private String salt; 
    
    @ManyToMany(fetch=FetchType.EAGER, cascade = { CascadeType.PERSIST, CascadeType.MERGE })
    @JoinTable(name ="USER_ROLE", 
    joinColumns = {@JoinColumn(name = "USER_ID") },
    inverseJoinColumns = {@JoinColumn(name = "ROLE_ID") })
    private Set<Role> roles = new LinkedHashSet();
    

    public User() {
    }

    public User(String username, String password) {
        this.id = System.currentTimeMillis();
        this.username = username;  
        this.password = password;
    }
    
    @XmlTransient
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    @XmlTransient
    public String getPassword(){
        return password;
    }
    public void setPassword(String password){
        this.password = password;
    }
    
    @XmlTransient
    public String getSalt(){
        return salt;
    }
    public void setSalt(String salt){
        this.salt = salt;
    }
    
    @XmlTransient
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }    
    
    @XmlTransient
    public Set<Role> getRole() {
        return roles;
    }

    public void setRole(LinkedHashSet<Role> roles) {       
        this.roles = roles;        
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 41 * hash + Objects.hashCode(this.username);
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
        final User other = (User) obj;
        if (!Objects.equals(this.username, other.username)) {
            return false;
        }
        if (!Objects.equals(this.password, other.password)) {
            return false;
        }
        if (!Objects.equals(this.roles, other.roles)) {
            return false;
        }
        return true;
    }
 
}
