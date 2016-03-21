/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import java.io.IOException;
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long departmentID = Long.valueOf(req.getParameter("departmentID"));
        ControllerDAO controller = ControllerDAO.getInstance();
        Department d = controller.getDepartmentDAO().getDepartmentById(departmentID);
        long companyID = d.getCompany().getId();
        controller.getDepartmentDAO().deleteDepartment(d);
        RequestDispatcher rd = req.getRequestDispatcher("/pages/departmentTable.jsp?companyID="+companyID);
        rd.forward(req, resp); // Redisplay JSP.SP.          
    }
    
}
