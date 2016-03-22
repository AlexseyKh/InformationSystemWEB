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
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Department;
import model.Employee;
import org.hibernate.mapping.Set;

/**
 *
 * @author Игорь
 */
@WebServlet(name = "searchInEmployeeServlet", urlPatterns = {"/searchInEmployee"})
public class searchInEmployeeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ControllerDAO con = ControllerDAO.getInstance();
        DepartmentDAO depDAO = con.getDepartmentDAO();
        EmployeeDAO empDAO = con.getEmployeeDAO();
        long companyID = (long)request.getSession().getAttribute("companyID");

        LinkedHashSet<Employee> emps = new LinkedHashSet(empDAO.getEmployeeByLastName("%"+request.getParameter("search")+"%"));
        emps.addAll(empDAO.getEmployeeByName("%"+request.getParameter("search")+"%"));
        emps.addAll(empDAO.getEmployeeByFunction("%"+request.getParameter("search")+"%"));
        emps.addAll(empDAO.getEmployeeByFunction("%"+request.getParameter("search")+"%"));
        List<Employee> emps1 = new LinkedList<Employee>();
        emps1.addAll(emps);

        request.getSession().setAttribute("searchEmployees", emps1);

        request.getRequestDispatcher("/pages/employeeTable.jsp?search="+request.getParameter("search")).forward(request, response);
    }

}
