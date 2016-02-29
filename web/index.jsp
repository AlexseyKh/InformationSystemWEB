<%-- 
    Document   : index
    Created on : Feb 29, 2016, 2:01:17 PM
    Author     : Alexey
--%>

<%@page import="model.Company"%>
<%@page import="java.util.List"%>
<%@page import="controller.ControllerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Company</title>
    </head>
    <body>
        <%
            ControllerDAO con = ControllerDAO.getInstance();
            List<Company> list = con.getCompanyDAO().getAllCompany();
        %>
        <h1>All Company</h1>
        <table border="2px">
            <tr>
                <td>ID</td>
                <td>Name</td>
            </tr>
            <% 
               for(Company c : list){ 
            %>
            <tr>
                <td><%=c.getId()%></td>
                <td><%=c.getName()%></td>
            </tr>
            <%}%>
        </table>
    </body>
</html>
