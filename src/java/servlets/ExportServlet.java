/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.CompanyDAO;
import controller.ControllerDAO;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Companies;
import model.Company;

/**
 *
 * @author Alexey
 */
@WebServlet(name = "ExportServlet", urlPatterns = {"/ExportServlet"})
public class ExportServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        File file = (File) req.getSession().getAttribute("file");
        ControllerDAO controllerDAO =ControllerDAO.getInstance();
        InputStream in = new FileInputStream(file);
        Companies c = controllerDAO.loadCompany(in);
        CompanyDAO companyDAO = controllerDAO.getCompanyDAO();
        for(Company company : c.getCompanys()){
            companyDAO.addCompany(company);
        }
    }
    
    
}
