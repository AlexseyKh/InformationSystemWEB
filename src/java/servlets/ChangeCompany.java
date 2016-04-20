/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.ControllerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Company;
import org.apache.shiro.SecurityUtils;

/**
 *
 * @author Игорь
 */
@WebServlet(name = "ChangeCompany", urlPatterns = {"/servlets/ChangeCompany"})
public class ChangeCompany extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Company c = (Company) SecurityUtils.getSubject().getSession().getAttribute("company");
        String name = req.getParameter("name");
        c.setName(name);
        ControllerDAO.getInstance().getCompanyDAO().updateCompany(c);
        req.getRequestDispatcher("/pages/main.jsp").forward(req, resp);
    }
}
