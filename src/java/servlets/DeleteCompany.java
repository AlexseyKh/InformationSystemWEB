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
@WebServlet(urlPatterns = {"/servlets/DeleteCompany"})
public class DeleteCompany extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        long companyID = Long.valueOf(req.getParameter("companyID"));
        ControllerDAO controller = ControllerDAO.getInstance();
        Company c = controller.getCompanyDAO().getCompanyById(companyID);
        controller.getCompanyDAO().deleteCompany(c);
        RequestDispatcher rd = req.getRequestDispatcher("/index.jsp");
        rd.forward(req, resp); // Redisplay JSP.SP.
    }
    
    
    
}
