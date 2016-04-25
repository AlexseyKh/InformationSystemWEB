/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.Set;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Alexey
 */
@XmlRootElement
public class Departments {
    @XmlElement(name="department")
    Set<Department> departments;
    
    public Departments() {
    }
    
    public Departments(Collection<? extends Department> departments) {
        this.departments = new LinkedHashSet<>(departments);
    }
}
