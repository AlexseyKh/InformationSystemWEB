/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package security.controller;

import security.model.Role;
import security.model.User;
import controller.HibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Игорь
 */
public class RoleDAOImpl implements RoleDAO{

    @Override
    public void addRole(Role role) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.save(role);
        t.commit();
        s.close();
    }

    @Override
    public void updateRole(Role role) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.update(role);
        t.commit();
        s.close();
    }

    @Override
    public void deleteRole(Role role) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.delete(role);
        t.commit();
        s.close();
    }

    @Override
    public Role getRoleById(long id) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Role role = (Role) s.byId(Role.class).load(id);;
        t.commit();
        s.close();
        return role;
    }

    @Override
    public List<Role> getRoleByName(String name) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Role where lower(NAME) like lower(:name)").setString("name", name);
        List<Role> list = query.list();
        t.commit();
        s.close();
        return list;
    }

    @Override
    public List<Role> getRolesByUser(User user) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("select r from Role r join r.users u where u.id = :user_id").setLong("user_id", user.getId());
        List<Role> list = query.list();
        t.commit();
        s.close();
        return list;
    }
    
    @Override
    public List<Role> getAllRoles() {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        List<Role> list = s.createCriteria(Role.class).list();
        t.commit();
        s.close();
        return list;
    }
}
