/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 *
 * @author Alexey
 */
public class HibernateUtil {
  private static final SessionFactory sessionFactory;
    static {
      try {
        sessionFactory = new Configuration().configure().buildSessionFactory();
      } catch (Throwable ex) {        
        throw new ExceptionInInitializerError(ex);
      }
    }
    /**
     * Получение фабрики сессий
     * @return фабрика сессий
     */
    public static SessionFactory getSessionFactory() {
      return sessionFactory;
    }
}
