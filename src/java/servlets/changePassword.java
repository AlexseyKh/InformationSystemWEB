/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import security.controller.SecurityControllerDAO;
import security.controller.UserDAO;
import security.model.User;

/**
 *
 * @author Игорь
 */
@WebServlet(name = "changePassword", urlPatterns = {"/changePassword"})
public class changePassword extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String oldPass = request.getParameter("oldPass");

        Subject currentUser = SecurityUtils.getSubject();
        SecurityControllerDAO sec = SecurityControllerDAO.getInstance();
        UserDAO userDAO = sec.getUserDAO();
        User user = userDAO.getUserByUsername(currentUser.getPrincipals().getPrimaryPrincipal().toString()).get(0);
        if (!user.getPassword().equals(oldPass)) {
            response.getWriter().print("error");
        } else {
            String pass = request.getParameter("pass");
            user.setPassword(pass);
            userDAO.updateUser(user);
            
            response.getWriter().print("success");
        }

    }
}
