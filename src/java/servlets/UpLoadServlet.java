/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.URLEncoder;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Alexey
 */
@WebServlet(name = "UpLoadServlet", urlPatterns = {"/UpLoadServlet"})
@MultipartConfig
public class UpLoadServlet extends HttpServlet{

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8"); 
        resp.setContentType("text/xml;charset=UTF-8");
        String fileName = URLEncoder.encode(System.currentTimeMillis() + ".xml", "UTF-8");        
        File file =  new File("XML\\" + fileName);        
        //resp.setHeader("Content-Disposition","attachment; filename=" + fileName);
        file.createNewFile();
        OutputStream out = new FileOutputStream(file);       
        for(Part p : req.getParts()){
            System.out.println(p.getContentType());
            System.out.println(p.getName());
            System.out.println(p.getSubmittedFileName());
            for(String s : p.getHeaderNames()){
                System.out.println(s + " : " + p.getHeader(s));
            }
            copyLarge(p.getInputStream(), out);
        }
        req.getSession().setAttribute("file", file);
        FileReader fr = new FileReader(file);
        System.out.println(fr.getEncoding());
        char[] buffer = new char[(int)file.length()];
        // считаем файл полностью
        fr.read(buffer);
        System.out.println(new String(buffer));
        
        
        
        RequestDispatcher rd = req.getRequestDispatcher("/pages/export.jsp");
        rd.forward(req, resp); // Redisplay JSP.SP.               
    }
    
    public static long copyLarge(InputStream input, OutputStream output)
        throws IOException {
        byte[] buffer = new byte[8*1024];
        long count = 0;
        int n = 0;
        while (-1 != (n = input.read(buffer))) {
            output.write(buffer, 0, n);
            count += n;
        }
        return count;
    }      
    
    
}
