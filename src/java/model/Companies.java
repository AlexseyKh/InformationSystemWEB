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
@XmlRootElement(name="companys")
public class Companies {
    @XmlElement(name="company")
    Set<Company> companys;

    public Companies() {
    }
    
    
    
    public Companies(Collection<? extends Company> companys) {
        this.companys = new LinkedHashSet<>(companys);
    }
    
}
