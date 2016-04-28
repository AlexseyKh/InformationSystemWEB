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
import model.Company;
import model.Department;

/**
 *
 * @author Alexey
 */
@WebServlet(urlPatterns = {"/servlets/DeleteDepartment"})
public class DeleteDepartment extends HttpServlet{
    
    @EJB
    ControllerDAO controller;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long departmentID = Long.valueOf(req.getParameter("departmentID"));
        Department d = controller.getDepartmentDAO().getDepartmentById(departmentID);
        long companyID = d.getCompany().getId();
        controller.getDepartmentDAO().deleteDepartment(d);
        RequestDispatcher rd = req.getRequestDispatcher("/pages/departmentTable.jsp");
        rd.forward(req, resp); // Redisplay JSP.SP.          
    }
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
            String ids = req.getParameter("department_Ids");
            String[] idsArr = ids.replaceAll("\\ ","").split(",");
            long[] results = new long[idsArr.length];
            for (int i =0; i < idsArr.length; i++)
            {
                try {
                    results[i]= Long.valueOf(idsArr[i]);
                }
                catch (NumberFormatException nfe) {}
            }
            for (int j = 0; j < results.length; j++)
            {
                Department d = controller.getDepartmentDAO().getDepartmentById(results[j]);
                controller.getDepartmentDAO().deleteDepartment(d);
            }
        }
    
}
