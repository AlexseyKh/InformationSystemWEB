/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import controller.ControllerDAOImpl;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Department;

/**
 *
 * @author Alexey
 */
@WebServlet(urlPatterns = {"/servlets/ChangeDepartment"})
public class ChangeDepartment extends HttpServlet {
    @EJB
    ControllerDAO controller;
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        long directorID = Long.valueOf(req.getParameter("directorID"));
        Department d = (Department) req.getSession().getAttribute("department");
        d.setName(name);
        if (directorID != -1) {
            d.setDirector(controller.getEmployeeDAO().getEmployeeById(directorID));
        } else {
            d.setDirector(null);
        }
        controller.getDepartmentDAO().updateDepartment(d);
        RequestDispatcher rd = req.getRequestDispatcher("/pages/departmentTable.jsp");
        rd.forward(req, resp); // Redisplay JSP.SP.                
    }

}
