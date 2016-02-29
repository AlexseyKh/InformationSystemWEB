/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.*;

/**
 *
 * @author Alexey
 */
public interface CompanyDAO {
    public void addCompany(Company comp);
    public void updateCompany(Company comp);
    public void deleteCompany(Company comp);
    public Company getCompanyById(long id);    
    public List<Company> getCompanyByName(String name);
    public List<Company> getAllCompany();
}
