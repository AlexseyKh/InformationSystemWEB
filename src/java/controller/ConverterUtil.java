/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;
import org.hibernate.Hibernate;
import org.hibernate.proxy.HibernateProxy;

/**
 *
 * @author Alexey
 */
public class ConverterUtil {
 

    public static <T> T unproxy(T entity) {
        if (entity == null) {
            return null;
        }

        Hibernate.initialize(entity);
        if (entity instanceof HibernateProxy) {
            entity = (T) ((HibernateProxy) entity).getHibernateLazyInitializer().getImplementation();
        }
        return entity;
    }

    public static <T> List<T> unproxyList(List<T> list) {
        boolean hasProxy = false;
        for (T entity : list) {
            if (entity instanceof HibernateProxy) {
                hasProxy = true;
                break;
            }
        }

        if (hasProxy) {
            LinkedList<T> result = new LinkedList<T>();
            for (T entity : list) {
                if (entity instanceof HibernateProxy) {
                    result.add(ConverterUtil.unproxy(entity));
                } else {
                    result.add(entity);
                }
            }

            list.clear();
            list.addAll(result);
        }
        return list;
    }
    
     public static <T> Set<T> unproxySet(Set<T> list) {
        boolean hasProxy = false;
        for (T entity : list) {
            if (entity instanceof HibernateProxy) {
                hasProxy = true;
                break;
            }
        }

        if (hasProxy) {
            Set<T> result = new LinkedHashSet<T>();
            for (T entity : list) {
                if (entity instanceof HibernateProxy) {
                    result.add(ConverterUtil.unproxy(entity));
                } else {
                    result.add(entity);
                }
            }

            list.clear();
            list.addAll(result);
        }
        return list;
    }
}
