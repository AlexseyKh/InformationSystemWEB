<%-- 
    Document   : Departments
    Created on : Feb 29, 2016, 2:12:04 PM
    Author     : Alexey
--%>

<%@page import="model.Company"%>
<%@page import="model.Department"%>
<%@page import="java.util.List"%>
<%@page import="controller.ControllerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Departments</title>
    </head>
    <body>
         <%
            ControllerDAO con = ControllerDAO.getInstance();
            List<Company> comp = con.getCompanyDAO().getCompanyByName("New Company");
            List<Department> list = con.getDepartmentDAO().getDepartmentByCompany(comp.get(0));
        %>
        <h1>All Departments</h1>
        <table border="2px">
            <tr>
                <td>ID</td>
                <td>Name</td>
                <td>Company</td>
            </tr>
            <% 
               for(Department d : list){ 
            %>
            <tr>
                <td><%=d.getId()%></td>
                <td><%=d.getName()%></td>
                <td><%=d.getCompany().getId()%></td>
            </tr>
            <%}%>
        </table>
    </body>
</html>
