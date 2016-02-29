/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import model.Company;
import model.Department;
import model.Employee;

/**
 *
 * @author Alexey
 */
public interface EmployeeDAO {
    public void addEmployee(Employee emp, Department dep);
    public void updateEmployee(Employee emp);
    public void deleteEmployee(Employee emp);
    public Employee getEmployeeById(long id);
    public List<Employee> getEmployeeeByDepartment(Department dep);
    public List<Employee> getlEmployeeByCompany(Company comp);
    public List<Employee> getEmployeeByName(String name);
    public List<Employee> getEmployeeByLastName(String lastName);
    public List<Employee> getEmployeeByFunction(String function); 
}
