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
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "searchEmployeeByPatternServlet", urlPatterns = {"/searchEmployeeByPattern"})
public class searchEmployeeByPatternServlet extends HttpServlet {

    @EJB
    ControllerDAO controller;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DepartmentDAO depDAO = controller.getDepartmentDAO();
        EmployeeDAO empDAO = controller.getEmployeeDAO();
        long companyID = (long)request.getSession().getAttribute("companyID");
        int min = Integer.parseInt(request.getParameter("salaryMin"));
        int max = Integer.parseInt(request.getParameter("salaryMax"));

        List<Employee> emps = empDAO.getEmployeeByLastName(request.getParameter("lastName"));
        List<Employee> emps1 = empDAO.getEmployeeByName(request.getParameter("firstName"));
        for (int i = emps.size() - 1; i >= 0; i--) {
            if (!emps1.contains(emps.get(i))) {
                emps.remove(i);
            }
        }
        emps1 = empDAO.getEmployeeByFunction(request.getParameter("function"));
        for (int i = emps.size() - 1; i >= 0; i--) {
            if (!emps1.contains(emps.get(i))) {
                emps.remove(i);
            }
        }
        for (int i = emps.size() - 1; i >= 0; i--) {
            if (emps.get(i).getSalary() < min || emps.get(i).getSalary() > max) {
                emps.remove(i);
            }
        }
        List<Department> deps = depDAO.getDepartmentByName(request.getParameter("department"));
        for (int i = deps.size() - 1; i >= 0; i--) {
            if (deps.get(i).getCompany().getId() != companyID) {
                deps.remove(i);
            }
        }
        emps1.clear();
        for (Department d : deps) {
            emps1.addAll(empDAO.getEmployeeeByDepartment(d));
        }
        for (int i = emps.size() - 1; i >= 0; i--) {
            if (!emps1.contains(emps.get(i))) {
                emps.remove(i);
            }
        }

        request.getSession().setAttribute("employees", emps);
        request.getSession().setAttribute("lastName", request.getParameter("lastName"));
        request.getSession().setAttribute("firstName", request.getParameter("firstName"));
        request.getSession().setAttribute("function", request.getParameter("function"));
        request.getSession().setAttribute("department", request.getParameter("department"));
        request.getSession().setAttribute("department", request.getParameter("salaryMin"));
        request.getSession().setAttribute("department", request.getParameter("salaryMax"));

        request.getRequestDispatcher("/pages/employeeTable.jsp").forward(request, response);
    }

}
