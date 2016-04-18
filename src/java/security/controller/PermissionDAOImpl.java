/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package security.controller;

import security.model.Permission;
import security.model.Role;
import controller.HibernateUtil;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author Игорь
 */
public class PermissionDAOImpl implements PermissionDAO{

    @Override
    public void addPermission(Permission permission) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.save(permission);
        t.commit();
        s.close();
    }

    @Override
    public void updatePermission(Permission permission) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.update(permission);
        t.commit();
        s.close();
    }

    @Override
    public void deletePermission(Permission permission) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        s.delete(permission);
        t.commit();
        s.close();
    }

    @Override
    public Permission getPermissionById(long id) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Permission p = (Permission) s.byId(Permission.class).load(id);;
        t.commit();
        s.close();
        return p;
    }

    @Override
    public List<Permission> getPermissionByName(String name) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Permission where lower(NAME) like lower(:name)").setString("name", name);
        List<Permission> list = query.list();
        t.commit();
        s.close();
        return list;
    }

    @Override
    public List<Permission> getPermissionByRole(Role role) {
        Session s = SecurityHibernateUtil.getSessionFactory().openSession();
        Transaction t = s.beginTransaction();
        Query query = s.createQuery("from Permission p join p.roles p where p.id = :role_id").setLong(":role_id", role.getId());
        List<Permission> list = query.list();
        t.commit();
        s.close();
        return list;
    }
    
}
