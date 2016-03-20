/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import java.io.IOException;
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
@WebServlet(urlPatterns = {"/servlets/CreateDepartment"})
public class CreateDepartment extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String departmentName = req.getParameter("departmentName");
        long directorID = Long.valueOf(req.getParameter("directorID"));
        Department d = new Department(departmentName);
        ControllerDAO con = ControllerDAO.getInstance();
        d.setDirector(con.getEmployeeDAO().getEmployeeById(directorID));
        d.setCompany(con.getCompanyDAO().getCompanyByName("Музыкальный Магазин").get(0));
        con.getDepartmentDAO().addDepartment(d, d.getCompany());      
    }
    
    
}
