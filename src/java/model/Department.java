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
import javax.xml.bind.annotation.XmlTransient;
import org.hibernate.annotations.LazyToOne;
import org.hibernate.annotations.LazyToOneOption;

/**
 *
 * @author Алексей
 */
@Entity
@Table(name="DEPARTMENT", schema="COMPANY")
public class Department implements Serializable {

    @Id
    @Column(name="ID")  
    @XmlAttribute
    private long id;
    @Column(name="NAME")
    @XmlAttribute
    private String name;    
    @OneToOne()    
    @JoinColumn(name = "DIRECTOR_ID", referencedColumnName = "ID")
    private Employee director;
    @OneToMany(cascade = CascadeType.ALL)@LazyToOne(LazyToOneOption.NO_PROXY)    
    @JoinColumn(name = "DEPARTMENT_ID")
    @XmlElement(name="employee")
    private Set<Employee> employees = new LinkedHashSet(); 
    @ManyToOne()
    @JoinColumn(name="COMPANY_ID")
    @XmlTransient
    Company company;
    

    public Department() {
    }

    public Department(String name) {
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

    public Employee getDirector() {
        return director;
    }

    public void setDirector(Employee director) {
        this.director = director;
    }

    public Set<Employee> getEmployees() {
        return employees;
    }

    public void setEmployees(LinkedHashSet<Employee> employees) {
        this.employees = employees;
    }
    @XmlTransient
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }    
    @XmlTransient
    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {       
        this.company = company;        
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 41 * hash + Objects.hashCode(this.name);
        hash = 41 * hash + Objects.hashCode(this.director);
        hash = 41 * hash + Objects.hashCode(this.employees);
        //hash = 41 * hash + Objects.hashCode(this.company);
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
        final Department other = (Department) obj;
        if (!Objects.equals(this.name, other.name)) {
            return false;
        }
        if (!Objects.equals(this.director, other.director)) {
            return false;
        }
        if (!Objects.equals(this.employees, other.employees)) {
            return false;
        }
        if (!Objects.equals(this.company, other.company)) {
            return false;
        }
        return true;
    }
    
    
    
}
