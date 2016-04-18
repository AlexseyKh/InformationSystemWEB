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
@WebServlet(name = "searchInDepartmentServlet", urlPatterns = {"/searchInDepartment"})
public class searchInDepartmentServlet extends HttpServlet {
    
    
    @EJB
    ControllerDAO controller;
    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DepartmentDAO depDAO = controller.getDepartmentDAO();
        EmployeeDAO empDAO = controller.getEmployeeDAO();
        long companyID = (long)request.getSession().getAttribute("companyID");
        
        List<Department> deps = depDAO.getDepartmentByName("%" + request.getParameter("search") + "%");
        for(int i = deps.size() - 1; i >= 0; i --) {
            if(deps.get(i).getCompany().getId() != companyID) {
                deps.remove(i);
            }
        }
        
        request.getSession().setAttribute("searchDepartments", deps);
        
        request.getRequestDispatcher("/pages/departmentTable.jsp?search="+request.getParameter("search")).forward(request, response);
    }

}
