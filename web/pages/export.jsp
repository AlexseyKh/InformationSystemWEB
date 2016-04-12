<%-- 
    Document   : export
    Created on : Apr 11, 2016, 10:18:05 AM
    Author     : Alexey
--%>

<%@page import="java.io.FileReader"%>
<%@page import="javax.xml.transform.OutputKeys"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="javax.xml.transform.stream.StreamResult"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="javax.xml.transform.stream.StreamSource"%>
<%@page import="java.io.InputStream"%>
<%@page import="javax.xml.transform.TransformerFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilderFactory"%>
<%@page import="javax.xml.parsers.DocumentBuilder"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/xml"  prefix="x" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            //response.setContentType("text/html;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            request.setCharacterEncoding("UTF-8");
            File file = (File) session.getAttribute("file");  
             FileReader fr = new FileReader(file);
            System.out.println(fr.getEncoding());
            char[] buffer = new char[(int)file.length()];
            // считаем файл полностью
            fr.read(buffer);
            System.out.println(new String(buffer));
            TransformerFactory tFactory = TransformerFactory.newInstance();
            InputStream input = new FileInputStream("C:\\JavaProject\\InformationSystemWEB\\web\\xlst\\style.xsl");
            StreamSource ss = new StreamSource(input);
            javax.xml.transform.Transformer transformer = tFactory.newTransformer(ss);
            transformer.setOutputProperty(OutputKeys.ENCODING, "cp1251");
            InputStream inputStream = new FileInputStream(file);            
            StreamSource source = new javax.xml.transform.stream.StreamSource(inputStream);
            ByteArrayOutputStream stream = new ByteArrayOutputStream(8*1024);
            StreamResult streamResult = new javax.xml.transform.stream.StreamResult(stream);
            transformer.transform(source, streamResult);
            String result = stream.toString();
            
        %>
        <%= result%>
        <a href="/InformationSystemWEB/ExportServlet">Экспортировать</a> 
    </body>
</html>
