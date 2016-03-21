/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import model.Company;

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
    
    public void saveData(String fileName, Company company) {
        OutputStream os = null;
        try {
            JAXBContext jc = JAXBContext.newInstance(Company.class);
            Marshaller m = jc.createMarshaller();
            os = new FileOutputStream(fileName);
            m.marshal(company, os);
        } catch (JAXBException e) {
        } catch (FileNotFoundException e) {
        } catch (IOException e) {
        } finally {
            try {
                os.close();

            } catch (IOException e) {

            } finally {

            }
        }
    }
    
    
    
}

