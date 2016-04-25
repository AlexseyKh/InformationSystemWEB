/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.CompanyDAO;
import controller.ControllerDAO;
import controller.ControllerDAOImpl;
import controller.DepartmentDAO;
import controller.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
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

/**
 *
 * @author Игорь
 */
@WebServlet(name = "searchDepartmentByPatternServlet", urlPatterns = {"/searchDepartmentByPattern"})
public class searchDepartmentByPatternServlet extends HttpServlet {

    
    @EJB
    ControllerDAO controller;
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DepartmentDAO depDAO = controller.getDepartmentDAO();
        EmployeeDAO empDAO = controller.getEmployeeDAO();
        long companyID = (long)request.getSession().getAttribute("companyID");
        
        List<Department> deps = depDAO.getDepartmentByName(request.getParameter("name"));
        List<Employee> emps = empDAO.getEmployeeByLastName(request.getParameter("director"));
        for(int i = deps.size() - 1; i >= 0; i --) {
            if(!emps.contains(deps.get(i).getDirector())) {
                deps.remove(i);
            }
        }
        for(int i = deps.size() - 1; i >= 0; i --) {
            if(deps.get(i).getCompany().getId() != companyID) {
                deps.remove(i);
            }
        }
        request.getSession().setAttribute("departments", deps);
        request.getSession().setAttribute("name", request.getParameter("name"));
        request.getSession().setAttribute("director", request.getParameter("director"));
        
        request.getRequestDispatcher("/pages/departmentTable.jsp").forward(request, response);
    }

}
