/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.CompanyDAO;
import controller.ControllerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedHashSet;
import java.util.Set;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Company;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import security.controller.RoleDAO;
import security.controller.SecurityControllerDAO;
import security.controller.UserDAO;
import security.model.Role;
import security.model.User;

/**
 *
 * @author Игорь
 */
@WebServlet(name = "main", urlPatterns = {"/main"})
public class main extends HttpServlet {

    @EJB
    ControllerDAO controller;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("request").equals("save")) {
            String oldUsername = request.getParameter("oldUsername");
            String username = request.getParameter("username");
            String password = request.getParameter("pass");
            String role = request.getParameter("role");

            SecurityControllerDAO con = SecurityControllerDAO.getInstance();
            UserDAO userDAO = con.getUserDAO();
            RoleDAO roleDAO = con.getRoleDAO();

            if (username.equals(oldUsername)) {
                User user = userDAO.getUserByUsername(username).get(0);
                user.setPassword(password);
                Set<Role> roles = user.getRole();
                for (Role r : roles) {
                    if (r.getName().equals("admin")) {
                        roles.remove(r);
                        break;
                    }
                    if (r.getName().equals("user")) {
                        roles.remove(r);
                        break;
                    }
                }
                roles.add(roleDAO.getRoleByName(role).get(0));
                user.setRole(new LinkedHashSet<>(roles));
                userDAO.updateUser(user);

                response.getWriter().print("success");

            } else if (!userDAO.getUserByUsername(username).isEmpty()) {
                response.getWriter().print("error");
            } else {
                User user = userDAO.getUserByUsername(oldUsername).get(0);
                user.setUsername(username);
                user.setPassword(password);
                Set<Role> roles = user.getRole();
                for (Role r : roles) {
                    if (r.getName().equals("admin")) {
                        roles.remove(r);
                        break;
                    }
                    if (r.getName().equals("user")) {
                        roles.remove(r);
                        break;
                    }
                }
                roles.add(roleDAO.getRoleByName(role).get(0));
                user.setRole(new LinkedHashSet<>(roles));
                userDAO.updateUser(user);

                response.getWriter().print("success");
            }
        }

        if (request.getParameter("request").equals("create")) {
            String username = request.getParameter("username");
            String password = request.getParameter("pass");
            String rolename = request.getParameter("role");

            SecurityControllerDAO sec = SecurityControllerDAO.getInstance();
            UserDAO userDAO = sec.getUserDAO();
            RoleDAO roleDAO = sec.getRoleDAO();

            if (!userDAO.getUserByUsername(username).isEmpty()) {
                response.getWriter().print("error");
            } else {
                Session session = SecurityUtils.getSubject().getSession();

                User user = new User(username, password);
                userDAO.addUser(user);

                Role role = roleDAO.getRoleByName(rolename).get(0);
                userDAO.addRole(user, role);

                long compName = (long) session.getAttribute("companyID"); 
                userDAO.addRole(user, roleDAO.getRoleByName(String.valueOf(compName)).get(0));

                response.getWriter().print(user.getId());
            }
        }

    }

}
