/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.LinkedHashSet;
import java.util.Objects;
import java.util.Set;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlElements;
import javax.xml.bind.annotation.XmlTransient;
import org.hibernate.annotations.LazyToOne;
import org.hibernate.annotations.LazyToOneOption;

/**
 *
 * @author Алексей
 */
@Entity
@Table(name = "COMPANYS", schema="COMPANY")
public class Company implements Serializable {
    @Id
    @Column(name="ID")  
    @XmlAttribute
    private long id;    
    @Column(name="NAME")
    @XmlAttribute
    private String name;
    @XmlElement(name="department")
    @OneToMany(cascade = CascadeType.ALL) @LazyToOne(LazyToOneOption.NO_PROXY)    
    @JoinColumn(name="COMPANY_ID")       
    private Set<Department> departments = new LinkedHashSet();

    public Company() {        
    }

    public Company(String name) {
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
    
    public Set<Department> getDepartments() {
        return departments;
    }

    public void setDepartments(LinkedHashSet<Department> departments) {
        this.departments = departments;
    }
    @XmlTransient
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 29 * hash + Objects.hashCode(this.name);
        //hash = 29 * hash + Objects.hashCode(this.departments);
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
        final Company other = (Company) obj;
        if (!Objects.equals(this.name, other.name)) {
            return false;
        }
        if (!Objects.equals(this.departments, other.departments)) {
            return false;
        }
        return true;
    }
    
    
    
}
