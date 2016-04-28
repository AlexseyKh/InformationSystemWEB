/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Company;
import org.apache.shiro.SecurityUtils;

/**
 *
 * @author Игорь
 */

@WebServlet(urlPatterns = {"/servlets/ChangeCompany"})
public class ChangeCompany extends HttpServlet{
    @EJB
    ControllerDAO controller;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Company c = (Company) SecurityUtils.getSubject().getSession().getAttribute("company");
        String name = req.getParameter("name");
        c.setName(name);
        controller.getCompanyDAO().updateCompany(c);
        RequestDispatcher rd = req.getRequestDispatcher("/pages/main.jsp");
        rd.forward(req, resp); // Redisplay JSP.SP.
    }    
}
