/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import controller.ControllerDAOImpl;
import java.io.IOException;
import java.io.PrintWriter;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Игорь
 */
@WebServlet(name = "departmentTableServlet", urlPatterns = {"/departmentTable"})
public class departmentTableServlet extends HttpServlet {

    @EJB
    ControllerDAO controller;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        long companyID = Long.parseLong(request.getParameter("companyID"));
        HttpSession session = request.getSession(true);
        session.setAttribute("companyID", companyID);
        session.setAttribute("companyName", controller.getCompanyDAO().getCompanyById(companyID).getName());

        request.getRequestDispatcher("/pages/departmentTable.jsp").forward(request, response);
    }

}
