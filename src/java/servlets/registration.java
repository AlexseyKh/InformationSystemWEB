/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.CompanyDAO;
import controller.ControllerDAO;
import java.io.IOException;
import java.util.LinkedHashSet;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Company;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UsernamePasswordToken;
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
@WebServlet(name = "registration", urlPatterns = {"/registration"})
public class registration extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (request.getParameter("request").equals("toCompany")) {
            String username = request.getParameter("username");
            String password = request.getParameter("pass");

            SecurityControllerDAO con = SecurityControllerDAO.getInstance();
            UserDAO userDAO = con.getUserDAO();
            Session session = SecurityUtils.getSubject().getSession();
            if (!userDAO.getUserByUsername(username).isEmpty()) {
                response.getWriter().print("error");
            } else {
                session.setAttribute("username", username);
                session.setAttribute("password", password);
                response.getWriter().print("success");
            }

        }

        if (request.getParameter("request").equals("finish")) {
            String name = request.getParameter("companyName");

            ControllerDAO con = ControllerDAO.getInstance();
            CompanyDAO compDAO = con.getCompanyDAO();

            if (!compDAO.getCompanyByName(name).isEmpty()) {
                response.getWriter().print("error");
            } else {
                compDAO.addCompany(new Company(name));

                SecurityControllerDAO sec = SecurityControllerDAO.getInstance();
                UserDAO userDAO = sec.getUserDAO();
                RoleDAO roleDAO = sec.getRoleDAO();
                Session session = SecurityUtils.getSubject().getSession();
                String username = (String) session.getAttribute("username");
                String password = (String) session.getAttribute("password");
                User user = new User(username, password);
                userDAO.addUser(user);
                
                Role role = roleDAO.getRoleByName("owner").get(0);
                userDAO.addRole(user, role);
                
                role = new Role(String.valueOf(compDAO.getCompanyByName(name).get(0).getId()));
                roleDAO.addRole(role); 
                userDAO.addRole(user, roleDAO.getRoleByName(String.valueOf(compDAO.getCompanyByName(name).get(0).getId())).get(0));

                
                UsernamePasswordToken token = new UsernamePasswordToken(username, password);
                Subject currentUser = SecurityUtils.getSubject();
                currentUser.login(token);
                currentUser.getSession().setAttribute("companyID", compDAO.getCompanyByName(name).get(0).getId());
                currentUser.getSession().setAttribute("companyName", name);
                response.getWriter().print("success");
            }

        }

    }

}
