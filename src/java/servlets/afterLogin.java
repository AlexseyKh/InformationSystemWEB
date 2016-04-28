/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import security.controller.SecurityControllerDAO;
import security.controller.UserDAO;
import security.model.Role;
import security.model.User;

/**
 *
 * @author Игорь
 */
@WebServlet(name = "afterLogin", urlPatterns = {"/afterLogin"})
public class afterLogin extends HttpServlet {

    @EJB
    ControllerDAO controller;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Subject currentUser = SecurityUtils.getSubject();
        SecurityControllerDAO sec = SecurityControllerDAO.getInstance();
        UserDAO userDAO = sec.getUserDAO();
        User user = userDAO.getUserByUsername(currentUser.getPrincipals().getPrimaryPrincipal().toString()).get(0);
        List<Role> roles = sec.getRoleDAO().getRolesByUser(user);

        long companyID = 0;
        for (Role r : roles) {
            if (!r.getName().equals("owner")
                    && !r.getName().equals("admin")
                    && !r.getName().equals("user")) {
                companyID = Long.parseLong(r.getName());
                break;
            }
        }
        SecurityUtils.getSubject().getSession().setAttribute("companyID", companyID);
        SecurityUtils.getSubject().getSession().setAttribute("companyName", controller.getCompanyDAO().getCompanyById(companyID).getName());

        if (currentUser.hasRole("owner")) {
            request.getRequestDispatcher("/pages/main.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/pages/departmentTable.jsp").forward(request, response);
        }
    }

}
