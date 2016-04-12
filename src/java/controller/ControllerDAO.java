/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
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
import org.hibernate.Hibernate;
import org.hibernate.collection.internal.PersistentSet;
import org.hibernate.proxy.HibernateProxy;

/**
 *
 * @author Alexey
 */
public class ControllerDAO {
    private static ControllerDAO instance = null;
    private static EmployeeDAO employeeDAO = null;
    private static DepartmentDAO departmentDAO = null;
    private static CompanyDAO companyDAO = null;
    /**
     * Получения состояния контроллера
     * @return контроллер
     */
    public static synchronized ControllerDAO getInstance(){
        if(instance == null) instance = new ControllerDAO();
        return instance;
    }
    
    public  EmployeeDAO getEmployeeDAO() {
        if(employeeDAO == null) employeeDAO = new EmployeeDAOImpl();
        return employeeDAO;
    }

    public  DepartmentDAO getDepartmentDAO() {
        if(departmentDAO == null) departmentDAO = new DepartmentDAOImpl();
        return departmentDAO;
    }

    public  CompanyDAO getCompanyDAO() {
        if(companyDAO == null) companyDAO = new CompanyDAOImpl();
        return companyDAO;
    }
    
    public void saveCompany(OutputStream out, List<Company> company) {
        try {
            ControllerDAO dao = ControllerDAO.getInstance();            
            Companies companies = new Companies(company);    
            OutputStream os = null;
            JAXBContext jc = JAXBContext.newInstance(Companies.class);
            Marshaller m = jc.createMarshaller();            
            m.marshal(companies, out);
            } catch (JAXBException ex) {}    
    }
    
    public void saveDepartment(OutputStream out, List<Department> Department) {
        try {
            ControllerDAO dao = ControllerDAO.getInstance();            
            Departments departments = new Departments(Department);    
            JAXBContext jc = JAXBContext.newInstance(Departments.class);
            Marshaller m = jc.createMarshaller();            
            m.marshal(departments, out);
            } catch (JAXBException ex) {}
    }
        
    public void saveEmployee(OutputStream out, List<Employee> employee) {
        try {
            ControllerDAO dao = ControllerDAO.getInstance();            
            Employers employers = new Employers(employee);    
            JAXBContext jc = JAXBContext.newInstance(Employers.class);
            Marshaller m = jc.createMarshaller();
            m.marshal(employers, out);
            } catch (JAXBException ex) {} 
    }  
    
    public Companies loadCompany(InputStream in) throws FileNotFoundException {
        try {
            JAXBContext jc = JAXBContext.newInstance(Companies.class);
            Unmarshaller um = jc.createUnmarshaller();           
            return (Companies) um.unmarshal(in);
        } catch (JAXBException e) {
            e.printStackTrace();     
        }
        return null;
    }
    
    public Departments loadDepartments(InputStream in) throws FileNotFoundException {
        try {
            JAXBContext jc = JAXBContext.newInstance(Companies.class);
            Unmarshaller um = jc.createUnmarshaller();           
            return (Departments) um.unmarshal(in);
        } catch (JAXBException e) {
            e.printStackTrace();     
        }
        return null;
    }
    
    public Employers loadEmployers(InputStream in) throws FileNotFoundException { 
        try {
            JAXBContext jc = JAXBContext.newInstance(Companies.class);
            Unmarshaller um = jc.createUnmarshaller();           
            return (Employers) um.unmarshal(in);
        } catch (JAXBException e) {
            e.printStackTrace();     
        }
        return null;
    }
}

