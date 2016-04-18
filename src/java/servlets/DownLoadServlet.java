/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import controller.ControllerDAOImpl;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.bind.JAXBException;
import model.Company;

/**
 *
 * @author Alexey
 */
@WebServlet(name = "DownLoadServlet", urlPatterns = {"/DownLoadServlet"})
@MultipartConfig
public class DownLoadServlet extends HttpServlet{

    @EJB
    ControllerDAO controller;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            resp.setContentType("text/xml;charset=UTF-8");
            req.setCharacterEncoding("UTF-8");
            resp.setCharacterEncoding("UTF-8");
            OutputStream out = resp.getOutputStream();
            List<Company> companys = (List<Company>) req.getSession().getAttribute("companys");
            controller.saveCompany(out, companys);
            out.close();
        } catch (JAXBException ex) {}
    }
    
}
