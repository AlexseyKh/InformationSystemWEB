/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import controller.EmployeeDAO;
import java.io.IOException;
import javax.ejb.EJB;
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

    @EJB
    ControllerDAO controller;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        EmployeeDAO empDAO = controller.getEmployeeDAO();
        Employee  e = empDAO.getEmployeeById(Long.parseLong(request.getParameter("id")));
        empDAO.deleteEmployee(e);
        request.getRequestDispatcher("/pages/departmentTable.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String ids = req.getParameter("employee_Ids");
        String[] idsArr = ids.replaceAll("\\ ", "").split(",");
        long[] results = new long[idsArr.length];
        for (int i = 0; i < idsArr.length; i++) {
            try {
                results[i] = Long.valueOf(idsArr[i]);
            } catch (NumberFormatException nfe) {
            }
        }
        for (int j = 0; j < results.length; j++) {
            Employee e = controller.getEmployeeDAO().getEmployeeById(results[j]);
            controller.getEmployeeDAO().deleteEmployee(e);
        }
    }
}
