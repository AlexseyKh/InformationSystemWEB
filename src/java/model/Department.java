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
import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Алексей
 */
@Entity
@Table(name="DEPARTMENT", schema="COMPANY")
public class Department implements Serializable {
    @XmlElement
    @Id
    @Column(name="ID")
    @SequenceGenerator ( name = "my_seq" , sequenceName = "COMP_SEQ" ) 
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="my_seq")
    private long id;
    @Column(name="NAME")
    private String name;    
    @OneToOne(cascade = CascadeType.ALL)    
    @JoinColumn(name = "DIRECTOR_ID", referencedColumnName = "ID")
    private Employee director;
    @XmlElement
    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "DEPARTMENT_ID")
    private Set<Employee> employees = new LinkedHashSet(); 
    @ManyToOne()
    @JoinColumn(name="COMPANY_ID")
    Company company;
    

    public Department() {
    }

    public Department(String name) {
        this.name = name;        
    }

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

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }    

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        if(this.company != company){
        if(this.company != null) this.company.getDepartments().remove(this);
        company.getDepartments().add(this);
        this.company = company;
        }
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 41 * hash + Objects.hashCode(this.name);
        hash = 41 * hash + Objects.hashCode(this.director);
        hash = 41 * hash + Objects.hashCode(this.employees);
        hash = 41 * hash + Objects.hashCode(this.company);
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
