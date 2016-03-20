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

/**
 *
 * @author Alexey
 */
@WebServlet(urlPatterns = {"/servlets/CreateCompany"})
public class CreateCompany extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String name = req.getParameter("comapnyName");
        Company c = new Company(name);
        ControllerDAO.getInstance().getCompanyDAO().addCompany(c);
        RequestDispatcher rd = req.getRequestDispatcher("/pages/companyTable.jsp");
        rd.forward(req, resp); // Redisplay JSP.SP.        
    }
    
    
}
