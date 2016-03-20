/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.ArrayList;
import java.util.List;
import model.Company;
import model.Department;
import model.Employee;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Alexey
 */
public class EmployeeDAOImpl implements EmployeeDAO {

    @Override
    public void addEmployee(Employee emp, Department dep) {
        emp.setDepartment(dep);
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();        
        s.save(emp);
        t.commit();
        s.close();    
    }

    @Override
    public void updateEmployee(Employee emp) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.update(emp);
        t.commit();
        s.close();
    }

    @Override
    public void deleteEmployee(Employee emp) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.delete(emp);
        t.commit();
        s.close();
    }

    @Override
    public Employee getEmployeeById(long id) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Employee e = (Employee) s.byId(Employee.class).load(id);
        t.commit();
        s.close();
        return e;
    }

    @Override
    public List<Employee> getEmployeeeByDepartment(Department dep) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Employee where DEPARTMENT_ID = :DEPARTMENT_ID").setLong("DEPARTMENT_ID", dep.getId());
        List<Employee> list = query.list();
        t.commit();
        s.close();
        return list;
    }

    @Override
    public List<Employee> getlEmployeeByCompany(Company comp) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Employee e, Department d where e.department = d.id AND d.company = :COMPANY_ID").setLong("COMPANY_ID", comp.getId());
        List<Object[]> list = query.list();
        t.commit();
        s.close();
        ArrayList<Employee> emps = new ArrayList<>();
        for(Object[] obj : list) emps.add((Employee)obj[0]);
        return emps;
    }

    @Override
    public List<Employee> getEmployeeByName(String name) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Employee where FIRST_NAME = :FIRST_NAME").setString("FIRST_NAME", name);
        List<Employee> list = query.list();
        t.commit();
        s.close();
        return list;
    }

    @Override
    public List<Employee> getEmployeeByLastName(String lastName) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Employee where LAST_NAME = :LAST_NAME").setString("LAST_NAME", lastName);
        List<Employee> list = query.list();
        t.commit();
        s.close();
        return list;
    }

    @Override
    public List<Employee> getEmployeeByFunction(String function) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Employee where FUNCTION = :FUNCTION").setString("FUNCTION", function);
        List<Employee> list = query.list();
        t.commit();
        s.close();
        return list;
    }
    
}
