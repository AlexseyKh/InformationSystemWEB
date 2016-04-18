/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.List;
import javax.ejb.Stateless;
import model.Company;
import model.Department;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Alexey
 */
@Stateless
public class DepartmentDAOImpl implements DepartmentDAO {

    @Override
    public void addDepartment(Department dep, Company comp) {
        dep.setCompany(comp);
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.save(dep);
        t.commit();
        s.close();
    }

    @Override
    public void updateDepartment(Department dep) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.update(dep);
        t.commit();
        s.close();
    }

    @Override
    public void deleteDepartment(Department dep) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.delete(dep);
        t.commit();
        s.close();
    }

    @Override
    public Department getDepartmentById(long id) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Department d = (Department) s.byId(Department.class).load(id);;
        t.commit();
        s.close();
        return d;
    }

    @Override
    public List<Department> getDepartmentByName(String name) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Department where lower(NAME) LIKE lower(:NAME)").setString("NAME", name);
        List<Department> list = query.list();
        t.commit();
        s.close();
        return list;
    }

    @Override
    public List<Department> getDepartmentByCompany(Company com) {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Department where COMPANY_ID = :COMPANY");
        query.setLong("COMPANY", com.getId());
        List<Department> list = query.list();
        t.commit();
        s.close();
        return list;
    }

}
