/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.io.Serializable;
import java.util.Objects;
import javax.persistence.*;
import javax.xml.bind.annotation.XmlElement;

/**
 *
 * @author Алексей
 */
@Entity
@Table(name="EMPLOYEE", schema="COMPANY")
public class Employee implements Serializable {
    @XmlElement
    @Id
    @Column(name="ID")
    @SequenceGenerator ( name = "my_seq" , sequenceName = "COMP_SEQ" ) 
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="my_seq")
    private long id;
    @Column(name="FIRST_NAME")
    private String firstName;
    @Column(name="LAST_NAME")
    private String lastName;
    @Column(name="FUNCTION")
    private String function;
    @Column(name="SALARY")
    private int salary;
    @ManyToOne    
    @JoinColumn(name="DEPARTMENT_ID")
    Department department;
   

    public Employee() {
    }

    public Employee(String firstName, String lastName, String function, int salary) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.function = function;
        this.salary = salary;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getFunction() {
        return function;
    }

    public void setFunction(String function) {
        this.function = function;
    }

    public int getSalary() {
        return salary;
    }

    public void setSalary(int salary) {
        this.salary = salary;
    }

    public long getId() {
        return id;
    }


    public void setId(long id) {
        this.id = id;
    }

  
    
    

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 29 * hash + Objects.hashCode(this.firstName);
        hash = 29 * hash + Objects.hashCode(this.lastName);
        hash = 29 * hash + Objects.hashCode(this.function);
        hash = 29 * hash + this.salary;
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
        final Employee other = (Employee) obj;
        if (this.id != other.id) {
            return false;
        }
        if (this.salary != other.salary) {
            return false;
        }
        if (!Objects.equals(this.firstName, other.firstName)) {
            return false;
        }
        if (!Objects.equals(this.lastName, other.lastName)) {
            return false;
        }
        if (!Objects.equals(this.function, other.function)) {
            return false;
        }
        return true;
    }

    public Department getDepartment() {
        return department;
    }

    public void setDepartment(Department department) {
        this.department = department;  
    }   
    
    
}
