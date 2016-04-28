/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import javax.ejb.Remote;
import javax.xml.bind.JAXBException;
import model.Companies;
import model.Company;
import model.Department;
import model.Departments;
import model.Employee;
import model.Employers;

/**
 *
 * @author Alexey
 */
@Remote
public interface ControllerDAO {    
    public  EmployeeDAO getEmployeeDAO();
    public  DepartmentDAO getDepartmentDAO();
    public  CompanyDAO getCompanyDAO();    
    public void saveCompany(OutputStream out, List<Company> company) throws JAXBException;    
    public void saveDepartment(OutputStream out, List<Department> Department) throws JAXBException ;        
    public void saveEmployee(OutputStream out, List<Employee> employee) throws JAXBException;    
    public Companies loadCompany(InputStream in) throws FileNotFoundException, JAXBException;    
    public Departments loadDepartments(InputStream in) throws FileNotFoundException, JAXBException;    
    public Employers loadEmployers(InputStream in) throws FileNotFoundException, JAXBException;
}
