/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package security.controller;

/**
 *
 * @author Игорь
 */
public class SecurityControllerDAO {

    private static SecurityControllerDAO instance = null;
    private static UserDAO userDAO = null;
    private static RoleDAO roleDAO = null;
    private static PermissionDAO permissionDAO = null;

    public static synchronized SecurityControllerDAO getInstance() {
        if (instance == null) {
            instance = new SecurityControllerDAO();
        }
        return instance;
    }

    public UserDAO getUserDAO() {
        if (userDAO == null) {
            userDAO = new UserDAOImpl();
        }
        return userDAO;
    }

    public RoleDAO getRoleDAO() {
        if (roleDAO == null) {
            roleDAO = new RoleDAOImpl();
        }
        return roleDAO;
    }

    public PermissionDAO getPermissionDAO() {
        if (permissionDAO == null) {
            permissionDAO = new PermissionDAOImpl();
        }
        return permissionDAO;
    }
}
