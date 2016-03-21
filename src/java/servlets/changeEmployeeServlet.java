/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

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
import model.Department;
import model.Employee;

/**
 *
 * @author Игорь
 */
@WebServlet(name = "changeEmployeeServlet", urlPatterns = {"/changeEmployee"})
public class changeEmployeeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ControllerDAO con = ControllerDAO.getInstance();
        EmployeeDAO empDAO = con.getEmployeeDAO();
        DepartmentDAO depDAO = con.getDepartmentDAO();
        Employee emp = empDAO.getEmployeeById(Long.parseLong(request.getParameter("id")));
        emp.setFirstName(request.getParameter("firstName"));
        emp.setLastName(request.getParameter("lastName"));
        emp.setFunction(request.getParameter("function"));
        emp.setSalary(Integer.parseInt(request.getParameter("salary")));
        Department dep = depDAO.getDepartmentById(Long.parseLong(request.getParameter("department")));
        emp.setDepartment(dep);
        empDAO.updateEmployee(emp);

        request.getRequestDispatcher("/pages/departmentTable.jsp?companyID=" + request.getParameter("companyID")).forward(request, response);
    }

}
