
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
                        <li><a href="/InformationSystemWEB/index.jsp">Главная</a></li><!--
                        --><shiro:hasRole name="owner">
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
                <shiro:notAuthenticated>
                    <form name="loginform" action="" method="POST" accept-charset="UTF-8" role="form">
                        <fieldset>
                            <div class="form-group">
                                <input class="form-control" placeholder="Логин" name="username" type="text">
                            </div>
                            <div class="form-group">
                                <input class="form-control" placeholder="Пароль" name="password" type="password" value="">
                            </div>
                            <!--<div class="checkbox">
                                <label>
                                    <input name="rememberMe" type="checkbox" value="true"> Remember Me
                                </label>
                            </div>-->
                            <input type="submit" value="Войти">
                        </fieldset>
                    </form>
                </shiro:notAuthenticated>
                <shiro:authenticated>
                    <div>Здравствуйте, <b><shiro:principal/></b>!</div>
                </shiro:authenticated>

            </main>
            <footer class="primary-footer container group">
                <p style="text-align: center"> 2016 год</p>
            </footer>
        </header>
    </div>
</body>
</html>
