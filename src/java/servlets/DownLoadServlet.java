/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Company;

/**
 *
 * @author Alexey
 */
@WebServlet(name = "DownLoadServlet", urlPatterns = {"/DownLoadServlet"})
@MultipartConfig
public class DownLoadServlet extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/xml;charset=UTF-8");        
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        OutputStream out = resp.getOutputStream();
        List<Company> companys = (List<Company>) req.getSession().getAttribute("companys");
        ControllerDAO c = ControllerDAO.getInstance();
        c.saveCompany(out, companys);
        out.close();
    }
    
}
