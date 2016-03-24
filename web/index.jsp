<%-- 
    Document   : companyTable
    Created on : Mar 20, 2016, 5:27:04 PM
    Author     : Alexey
--%>

<%@page import="model.Employee"%>
<%@page import="model.Department"%>
<%@page import="java.util.List"%>
<%@page import="model.Company"%>
<%@page import="controller.CompanyDAO"%>
<%@page import="controller.ControllerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%session.setAttribute("companyID", null);%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Company</title>
    </head>
    <body>
        <header>
            <table width="849" border="0" align="center">
                <tbody>
                    <tr>
                        <th scope="col"><img src="/InformationSystemWEB/images/nc-logo.jpg" width="200" height="55" alt=""/></th>
                        <th scope="col"><h1>Информационная система</h1></th>
                    </tr>
                </tbody>
            </table>
            <main>
            <table width="200" border="1" align="center">
                <tbody>
                    <tr>
                        <td align="center"><img src="/InformationSystemWEB/images/department.png" width="198" height="200" alt=""/>
                                <h3>Список отделов</h3></td>
                        <td align="center"><img src="/InformationSystemWEB/images/employee.png" width="200" height="200" alt=""/>
                                <h3>Список сотрудников</h3></td>
                        <td align="center"><img src="/InformationSystemWEB/images/help.png" width="200" height="200" alt=""/>
                            <h3>Справка</h3></td>
                    </tr>
                </tbody>
            </table>
        </main>
        <main>
            <blockquote>
                <h2 style="text-align: center">Таблица компаний</h2>                
            </blockquote>
            <div align="right"><a href="/InformationSystemWEB/pages/createCompany.jsp">Добавить компанию</a></div>
            <table width="500" border="1" align="center" cellpadding="10" cellspacing="0">
                <%  
                    ControllerDAO con = ControllerDAO.getInstance();   
                    CompanyDAO compDAO = con.getCompanyDAO();
                    List<Company> companys = compDAO.getAllCompany();                    
                %>
                <tbody>
                    <tr>
                        <td align="center">Название</td>
                        <td align="center">Отделы</td>
                        <td align="center">Изменить</td>
                        <td align="center">Удалить</td>
                    </tr>
                    <%
                        for(Company c : companys) {                           
                    %>
                    <tr>
                        <td align="center"><%=c.getName()%></td>
                        <td><a href="/InformationSystemWEB/departmentTable?companyID=<%=c.getId()%>">Просмотреть</a></td>
                        <td><a href="/InformationSystemWEB/pages/changeCompany.jsp?companyID=<%=c.getId()%>">Изменить</a></td>
                        <td><a href="/InformationSystemWEB/servlets/DeleteCompany?companyID=<%=c.getId()%>">Удалить</a></td>
                    </tr>
                    <%}%>
                    
                </tbody>
            </table> 
        </main>
        <footer>
            <p style="text-align: center"> 2016 год</p>
        </footer>
        </header>
    </body>
</html>
