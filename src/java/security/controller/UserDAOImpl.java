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
public class UserDAOImpl implements UserDAO{

    @Override
    public void addUser(User user) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.save(user);
        t.commit();
        s.close();
    }

    @Override
    public void updateUser(User user) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.update(user);
        t.commit();
        s.close();
    }

    @Override
    public void deleteUser(User user) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.delete(user);
        t.commit();
        s.close();
    }

    @Override
    public User getUserById(long id) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        User u = (User) s.byId(User.class).load(id);
        t.commit();
        s.close();
        return u;
    }
        
    @Override
    public List<User> getUserByUsername(String username) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from User where lower(USERNAME) like lower(:username)").setString("username", username);
        List<User> list = query.list();
        t.commit();
        s.close();
        return list;
    }
    
    @Override
    public List<User> getUserByRole(Role role) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("select u from User u join u.roles r where r.id = :role_id").setLong("role_id", role.getId());
        List<User> list = query.list();
        t.commit();
        s.close();
        return list;
    }

    @Override
    public List<User> getAllUsers() {
        Session s = HibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        List<User> list = s.createCriteria(User.class).list();
        t.commit();
        s.close();
        return list;
    }

    @Override
    public void addRole(User user, Role role) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction transaction = null;
        try {
            transaction = session.beginTransaction();
            User u = (User)session.get(User.class, user.getId());
            Role r = (Role)session.get(Role.class, role.getId());
            u.getRole().add(r);
            session.save(u);
            transaction.commit();
        } catch( Exception e ) {
            transaction.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }
    }

}
