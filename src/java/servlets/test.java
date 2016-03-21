/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import java.io.IOException;
import java.util.List;
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
@WebServlet(urlPatterns = {"/servlets/test"})
public class test extends HttpServlet{
    
    @Override    
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ControllerDAO c = ControllerDAO.getInstance();
        List<Company> cs = c.getCompanyDAO().getCompanyByName("Net");
    }
    
    
    
}
