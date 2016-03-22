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
@WebServlet(urlPatterns = {"/servlets/CreateDepartment"})
public class CreateDepartment extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String departmentName = req.getParameter("name");
        Department d = new Department(departmentName);
        ControllerDAO con = ControllerDAO.getInstance();
        String str = req.getParameter("directorID");
        if(str != null){
            long directorID = Long.valueOf(str);
            d.setDirector(con.getEmployeeDAO().getEmployeeById(directorID));
        }
        Company c = (Company) req.getSession().getAttribute("company");
        d.setCompany(c);
        con.getDepartmentDAO().addDepartment(d, d.getCompany());
        RequestDispatcher rd = req.getRequestDispatcher("/pages/departmentTable.jsp");
        rd.forward(req, resp); // Redisplay JSP.SP.    
    }
    
    
}
