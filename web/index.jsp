<%-- 
    Document   : companyTable
    Created on : Mar 20, 2016, 5:27:04 PM
    Author     : Alexey
--%>

<%@page import="java.util.Locale"%>
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
        <title>Справочная система</title>
        <link rel="stylesheet" href="/InformationSystemWEB/css/main.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,100&subset=cyrillic,latin">
    </head>
    <body>
        <header class="primary-header container group">
            <img src="/InformationSystemWEB/images/nc-logo.png" width="30%" align="center" class="logo">
            </img>
            <h1 class="tagline">Справочная система</h1>
        </header>
    <main>
            <section class="row">
                <h2 style="text-align: center">Таблица компаний</h2>
                <table width="500" border="1" align="center" cellpadding="10" cellspacing="0">

                    <%
                        ControllerDAO con = ControllerDAO.getInstance();
                        CompanyDAO compDAO = con.getCompanyDAO();
                        List<Company> companys = compDAO.getAllCompany();
                    %>
                    <tbody>
                    <thead>
                        <tr>
                            <td align="center">Название</td>
                            <td align="center">Отделы</td>
                            <td align="center">Изменить</td>
                            <td align="center">Удалить</td>
                        </tr>
                    </thead>
                    <%
                        for (Company c : companys) {
                    %>
                    <tr>
                        <td align="center"><b><%=c.getName()%></b></td>
                        <td align="center"><a href = "/InformationSystemWEB/departmentTable?companyID=<%=c.getId()%>">Просмотреть</a></td>
                        <td align="center"><a href = "/InformationSystemWEB/pages/changeCompany.jsp?companyID=<%=c.getId()%>">Изменить</a></td>
                        <td align="center"><a href = "/InformationSystemWEB/servlets/DeleteCompany?companyID=<%=c.getId()%>">Удалить</a></td>
                    </tr>
                    <%}%>

                    </tbody>
                </table>
                <p><div align="center"><button class="btn btn-default" onclick="location.href = '/InformationSystemWEB/pages/createCompany.jsp';">Добавить компанию</button></div></p>
            </section>
        </main>
        <footer class="primary-footer container group">
            <p style="text-align: center"> 2016 год</p>
        </footer>
    </header>
</body>
</html>
