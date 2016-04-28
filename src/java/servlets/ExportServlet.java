/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.CompanyDAO;
import controller.ControllerDAO;
import controller.ControllerDAOImpl;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBException;
import model.Companies;
import model.Company;

/**
 *
 * @author Alexey
 */
@WebServlet(name = "ExportServlet", urlPatterns = {"/ExportServlet"})
public class ExportServlet extends HttpServlet{

    @EJB
    ControllerDAO controller;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            File file = (File) req.getSession().getAttribute("file");
            InputStream in = new FileInputStream(file);
            Companies c = controller.loadCompany(in);
            CompanyDAO companyDAO = controller.getCompanyDAO();
            for(Company company : c.getCompanys()){
                companyDAO.addCompany(company);
            }
        } catch (FileNotFoundException ex) {            
        } catch (JAXBException ex) {}
    }
    
    
}
