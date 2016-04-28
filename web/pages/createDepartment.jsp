<%-- 
    Document   : createDepartment
    Created on : 20.03.2016, 14:59:16
    Author     : Игорь
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="model.Company"%>
<%@page import="java.util.List"%>
<%@page import="controller.ControllerDAO"%>
<%@page import="model.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%long companyID = (Long) SecurityUtils.getSubject().getSession().getAttribute("companyID");
    String name = SecurityUtils.getSubject().getSession().getAttribute("companyName").toString();%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Создание отдела</title>
        <%
            InitialContext ic = new InitialContext();
            ControllerDAO controller = (ControllerDAO)ic.lookup("controller.ControllerDAO");
            Company c = controller.getCompanyDAO().getCompanyById(companyID);
            session.setAttribute("company", c);
        %>
        <link rel="stylesheet" href="/InformationSystemWEB/css/main.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,100&subset=cyrillic,latin">
    </head>

    <body>
        <div style="background: #dcf2ff; max-width: 1024px; margin: 0 auto;">
            <header class="primary-header container group">
                <img src="/InformationSystemWEB/images/nc-logo.png" width="30%" align="center" class="logo">
                </img>
                <h1 class="tagline">Компания <%=name%></h1>
                <nav class="nav primary-nav">
                    <ul>
                        <li><a href="/InformationSystemWEB/index.jsp">Главная</a></li><!--
                        -->
                        <shiro:hasRole name="owner">
                            <li><a href="/InformationSystemWEB/pages/main.jsp">Список пользователей</a></li>
                        </shiro:hasRole><li><a href="/InformationSystemWEB/pages/departmentTable.jsp">Список отделов</a></li><!--
                        --><li><a href="/InformationSystemWEB/pages/employeeTable.jsp">Список сотрудников</a></li><!--
                        --><li><a href="">Справка</a></li>
                    </ul>
                </nav>
                <a href="/InformationSystemWEB/logout">Выход</a>
            </header>
            <main>
                <section class="row">
                    <form action="/InformationSystemWEB/servlets/CreateDepartment" method="POST">
                        <h2 style="text-align: center">Добавление отдела</h2>
                        <table width="50" border="0" align="center">
                            <tbody>                        
                                <tr>
                                    <td>Название </td>
                                    <td><input type="text" name="name" placeholder="Введите названи отдела" size="90" maxlength="90"></td>
                                </tr>
                                <tr>
                                    <td>Директор </td>
                                    <td>
                                        <select name="directorID">                         
                                            <%
                                                List<Employee> emps = controller.getEmployeeDAO().getlEmployeeByCompany(c);
                                                for (Employee e : emps) {
                                            %>
                                            <option value="<%=e.getId()%>"><%=e.getFirstName() + " " + e.getLastName()%></option>
                                            <%}%>
                                            <option value="-1">null</option>
                                        </select>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <p style="text-align: center"><input type="submit" value="Сохранить">
                            <input type="reset" value="Очистить"></p>
                    </form>                
                </section>
            </main>
            <footer>
                <nav class="navfoot">
                    <ul>
                        <li><a href="/InformationSystemWEB/index.jsp">К списку компаний</a></li><!--
                        --><li><a href="/InformationSystemWEB/index.jsp">На главную</a></li>
                    </ul>
                </nav>
                <p style="text-align: center">2016 год</p>
            </footer>
        </div>
    </body>

</html>
