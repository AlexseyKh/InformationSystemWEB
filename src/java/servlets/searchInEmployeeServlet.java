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
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import javax.ejb.EJB;
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

    @EJB
    ControllerDAO controller;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DepartmentDAO depDAO = controller.getDepartmentDAO();
        EmployeeDAO empDAO = controller.getEmployeeDAO();
        long companyID = (long)request.getSession().getAttribute("companyID");

        LinkedHashSet<Employee> emps = new LinkedHashSet(empDAO.getEmployeeByLastName("%"+request.getParameter("search")+"%"));
        emps.addAll(empDAO.getEmployeeByName("%"+request.getParameter("search")+"%"));
        emps.addAll(empDAO.getEmployeeByFunction("%"+request.getParameter("search")+"%"));
        List<Employee> emps1 = new LinkedList<Employee>();
        emps1.addAll(emps);
        for(int i = emps1.size() - 1; i >= 0; i--) {
            if(emps1.get(i).getDepartment().getCompany().getId() != companyID) {
                emps1.remove(i);
            }
        }

        request.getSession().setAttribute("searchEmployees", emps1);

        request.getRequestDispatcher("/pages/employeeTable.jsp?search="+request.getParameter("search")).forward(request, response);
    }

}
