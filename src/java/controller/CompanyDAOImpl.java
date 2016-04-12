/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import java.util.Set;
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
public class CompanyDAOImpl implements CompanyDAO{

    @Override
    public void addCompany(Company comp) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.saveOrUpdate(comp);
        t.commit();
        s.close();
    }

    @Override
    public void updateCompany(Company comp) {
       Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.update(comp);
        t.commit();
        s.close();
    }

    @Override
    public void deleteCompany(Company comp) {
       Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.delete(comp);
        t.commit();
        s.close(); 
    }

    @Override
    public Company getCompanyById(long id) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Company e = (Company) s.byId(Company.class).load(id);
        t.commit();
        s.close();
        return e;
    }

    @Override
    public List<Company> getCompanyByName(String name) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Company where lower(NAME) LIKE lower(:NAME)").setString("NAME", "%"+name+"%");
        List<Company> list = query.list();
        t.commit();
        s.close();
        return list;
    }

    @Override
    public List<Company> getAllCompany() {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        List<Company> list = s.createCriteria(Company.class).list();
        t.commit();
        s.close();
        return list;
    }
    
     @Override
    public List<Company> getFullAllCompany() {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        List<Company> list = s.createCriteria(Company.class).list();
        list = ConverterUtil.unproxyList(list);
        for(Company company : list){
            List<Department> deps = s.createCriteria(Department.class).list();
            deps = ConverterUtil.unproxyList(deps);
            for(Department department : deps){
                Set<Employee> emps = department.getEmployees();  
                emps = ConverterUtil.unproxySet(emps);
            }
        }
        t.commit();
        s.close();
        return list;
    }
    
    
}
