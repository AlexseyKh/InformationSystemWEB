/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import controller.CompanyDAO;
import controller.ControllerDAO;
import controller.DepartmentDAO;
import controller.EmployeeDAO;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;

/**
 *
 * @author Alexey
 */
@WebServlet(name = "test", urlPatterns = {"/test"})
@MultipartConfig
public class test extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws org.apache.commons.fileupload.FileUploadException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
        ControllerDAO controller = ControllerDAO.getInstance();
        CompanyDAO companyDAO = controller.getCompanyDAO();
        DepartmentDAO departmentDAO = controller.getDepartmentDAO();        
        EmployeeDAO employeeDAO = controller.getEmployeeDAO();
          for(Part p : request.getParts()){
              System.out.println(p.getSubmittedFileName());
              System.out.println(p.getSize());
              System.out.println(p.getContentType());
              File f = new File("C:\\glassfish4\\glassfish\\domains\\domain1\\generated\\jsp\\InformationSystemWEB\\" +System.currentTimeMillis() + ".xml");
              System.out.println(f.getName());
              System.out.println(f.getCanonicalPath());
              f.createNewFile();
              System.out.println(f.getCanonicalPath());
              p.write(f.getName());
              System.out.println("___________________________");
          }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
