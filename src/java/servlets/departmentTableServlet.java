/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.shiro.SecurityUtils;

/**
 *
 * @author Игорь
 */
@WebServlet(name = "departmentTableServlet", urlPatterns = {"/departmentTable"})
public class departmentTableServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ControllerDAO con = ControllerDAO.getInstance();
        long companyID = (Long) SecurityUtils.getSubject().getSession().getAttribute("companyID");

        request.getRequestDispatcher("/pages/departmentTable.jsp").forward(request, response);
    }

}
