<%-- 
    Document   : createCompany
    Created on : Mar 20, 2016, 11:21:20 PM
    Author     : Alexey
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Создание компании</title>
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
                        -->
                        <shiro:hasRole name="owner">
                            <li><a href="/InformationSystemWEB/pages/main.jsp">Список пользователей</a></li>
                        </shiro:hasRole><li><a href="/InformationSystemWEB/pages/departmentTable.jsp">Список отделов</a></li><!--
                        --><li><a href="/InformationSystemWEB/pages/employeeTable.jsp">Список сотрудников</a></li><!--
                        --><li><a href="">Справка</a></li>
                    </ul>
                </nav>
                <shiro:authenticated>
                    <a href="/InformationSystemWEB/logout">Выход</a>
                </shiro:authenticated>
            </header>
            <main>
                <section class="row">
                    <form action="/InformationSystemWEB/servlets/CreateCompany" method="POST">

                        <h2 style="text-align: center">Создание компании</h2>
                        <table width="50" border="0" align="center">                    
                            <tbody>                  
                                <tr>
                                    <td>Название </td>
                                    <td><input type="text" name="comapnyName" placeholder="Введите название компании" size="90" maxlength="90"></td>
                                </tr>                        
                            </tbody>
                        </table>
                        <p style="text-align: center"><input class="btn btn-default" type="submit" value="Создать">
                            <input class="btn btn-default" type="reset" value="Очистить"></p>

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
