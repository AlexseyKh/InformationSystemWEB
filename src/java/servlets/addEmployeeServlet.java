/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import controller.ControllerDAOImpl;
import controller.DepartmentDAO;
import controller.EmployeeDAO;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Department;
import model.Employee;

/**
 *
 * @author Игорь
 */
@WebServlet(name = "addEmployeeServlet", urlPatterns = {"/addEmployee"})
public class addEmployeeServlet extends HttpServlet {

    @EJB
    ControllerDAO controller;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        EmployeeDAO empDAO = controller.getEmployeeDAO();  
        DepartmentDAO depDAO = controller.getDepartmentDAO();
        Employee emp = new Employee(request.getParameter("firstName"), request.getParameter("lastName"),
                request.getParameter("function"), Integer.parseInt(request.getParameter("salary")));
        Department dep = depDAO.getDepartmentById(Long.parseLong(request.getParameter("department")));
        empDAO.addEmployee(emp, dep);
                
        request.getRequestDispatcher("/pages/departmentTable.jsp").forward(request, response);
    }

}
