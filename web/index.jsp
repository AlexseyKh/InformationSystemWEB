<%-- 
    Document   : index
    Created on : 14.04.2016, 12:06:40
    Author     : Игорь
--%>

<%@page import="org.apache.shiro.SecurityUtils"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Справочная система</title>
        <link rel="stylesheet" href="/InformationSystemWEB/css/main.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,100&subset=cyrillic,latin">

    </head>
    <body>
        <div style="background: #dcf2ff; max-width: 1024px; margin: 0 auto;">
            <header class="primary-header container group">
                <img src="/InformationSystemWEB/images/nc-logo.png" width="30%" align="center" class="logo">
                </img>
                <h1 class="tagline">Справочная система</h1>
                <nav class="nav primary-nav">
                    <ul>
                        <shiro:hasRole name="owner">
                            <li><a href="/InformationSystemWEB/pages/main.jsp">Список пользователей</a></li>
                            </shiro:hasRole>
                            <shiro:authenticated>
                            <li><a href="/InformationSystemWEB/pages/departmentTable.jsp">Список отделов</a></li><!--
                            --><li><a href="/InformationSystemWEB/pages/employeeTable.jsp">Список сотрудников</a></li>
                            </shiro:authenticated>
                        <li><a href="">Справка</a></li>
                    </ul>
                </nav>
                <shiro:authenticated>
                    <a href="/InformationSystemWEB/logout">Выход</a>
                </shiro:authenticated>
            </header>
            <main>
                <section id="section" class="row">
                    <p><a href="registration.jsp">Создать новую компанию</a></p>
                    <p><a href="login.jsp">Войти в систему</a></p>
                    <shiro:authenticated>
                        <p><a href="/pages/changePassword.jsp">Сменить пароль</a></p>
                    </shiro:authenticated>
                </section>
            </main>

            <footer class="primary-footer container group">
                <p style="text-align: center"> 2016 год</p>
            </footer>
        </header>
    </div>
</body>
</html>
