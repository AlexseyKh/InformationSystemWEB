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
import javax.ejb.EJB;
import javax.ejb.Stateless;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import model.Company;
import model.Companies;
import model.Department;
import model.Departments;
import model.Employee;
import model.Employers;

/**
 *
 * @author Alexey
 */
@Stateless
public class ControllerDAOImpl implements ControllerDAO{    
    @EJB
    private  EmployeeDAO employeeDAO;
    @EJB
    private  DepartmentDAO departmentDAO;
    @EJB
    private  CompanyDAO companyDAO;  
    
    public  EmployeeDAO getEmployeeDAO() {
        return employeeDAO;
    }

    public  DepartmentDAO getDepartmentDAO() {
        return departmentDAO;
    }

    public  CompanyDAO getCompanyDAO() {
        return companyDAO;
    }
    
    public void saveCompany(OutputStream out, List<Company> company) throws JAXBException {    
            Companies companies = new Companies(company);    
            OutputStream os = null;
            JAXBContext jc = JAXBContext.newInstance(Companies.class);
            Marshaller m = jc.createMarshaller();            
            m.marshal(companies, out);
               
    }
    
    public void saveDepartment(OutputStream out, List<Department> Department) throws JAXBException {        
            Departments departments = new Departments(Department);    
            JAXBContext jc = JAXBContext.newInstance(Departments.class);
            Marshaller m = jc.createMarshaller();            
            m.marshal(departments, out);
    }
        
    public void saveEmployee(OutputStream out, List<Employee> employee) throws JAXBException {            
            Employers employers = new Employers(employee);    
            JAXBContext jc = JAXBContext.newInstance(Employers.class);
            Marshaller m = jc.createMarshaller();
            m.marshal(employers, out);
    }  
    
    public Companies loadCompany(InputStream in) throws FileNotFoundException, JAXBException {
            JAXBContext jc = JAXBContext.newInstance(Companies.class);
            Unmarshaller um = jc.createUnmarshaller();           
            return (Companies) um.unmarshal(in);
    }
    
    public Departments loadDepartments(InputStream in) throws FileNotFoundException, JAXBException {
            JAXBContext jc = JAXBContext.newInstance(Companies.class);
            Unmarshaller um = jc.createUnmarshaller();           
            return (Departments) um.unmarshal(in);      
    }
    
    public Employers loadEmployers(InputStream in) throws FileNotFoundException, JAXBException { 
        JAXBContext jc = JAXBContext.newInstance(Companies.class);
        Unmarshaller um = jc.createUnmarshaller();           
        return (Employers) um.unmarshal(in);        
    }
}

