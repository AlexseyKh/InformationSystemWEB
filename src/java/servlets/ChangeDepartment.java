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
import model.Department;

/**
 *
 * @author Alexey
 */
@WebServlet(urlPatterns = {"/servlets/ChangeDepartment"})
public class ChangeDepartment extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("name");
        long directorID = Long.valueOf(req.getParameter("directorID"));
        ControllerDAO controller = ControllerDAO.getInstance();
        Department d = (Department) req.getSession().getAttribute("department");
        d.setName(name);
        d.setDirector(controller.getEmployeeDAO().getEmployeeById(directorID));
        controller.getDepartmentDAO().updateDepartment(d);
        RequestDispatcher rd = req.getRequestDispatcher("/pages/departmentTable.jsp?companyID="+d.getCompany().getId());
        rd.forward(req, resp); // Redisplay JSP.SP.                
    }
    
    
}
