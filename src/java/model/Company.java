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

/**
 *
 * @author Алексей
 */
@Entity
@Table(name = "COMPANYS", schema="COMPANY")
public class Company implements Serializable {
    @Id
    @Column(name="ID")
    @SequenceGenerator ( name = "my_seq" , sequenceName = "COMP_SEQ" ) 
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="my_seq")
    private long id;    
    @Column(name="NAME")
    private String name;
    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "COMPANY_ID")
    private Set<Department> departments = new LinkedHashSet();

    public Company() {
    }

    public Company(String name) {
        this.name = name;       
    }

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
        hash = 29 * hash + Objects.hashCode(this.departments);
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
