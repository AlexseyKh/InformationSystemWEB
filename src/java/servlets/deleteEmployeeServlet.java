/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.CompanyDAO;
import controller.ControllerDAO;
import controller.DepartmentDAO;
import controller.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Employee;

/**
 *
 * @author Игорь
 */
@WebServlet(name = "deleteEmployeeServlet", urlPatterns = {"/deleteEmployee"})
public class deleteEmployeeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ControllerDAO con = ControllerDAO.getInstance();
        EmployeeDAO empDAO = con.getEmployeeDAO();
        Employee  e = empDAO.getEmployeeById(Long.parseLong(request.getParameter("id")));
        empDAO.deleteEmployee(e);
        request.getRequestDispatcher("/pages/departmentTable.jsp").forward(request, response);
    }

}
