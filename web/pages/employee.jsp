<%-- 
    Document   : createEmployee
    Created on : 20.03.2016, 15:24:12
    Author     : Игорь
--%>

<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="model.Company"%>
<%@page import="controller.EmployeeDAO"%>
<%@page import="controller.CompanyDAO"%>
<%@page import="controller.DepartmentDAO"%>
<%@page import="model.Department"%>
<%@page import="controller.ControllerDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Employee"%>
<%@page import="model.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%long companyID = (Long) SecurityUtils.getSubject().getSession().getAttribute("companyID");
    String name = SecurityUtils.getSubject().getSession().getAttribute("companyName").toString();%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Изменение сотрудника</title>
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
                        <li><a href="/InformationSystemWEB/index.jsp">Главная</a></li>
                        <shiro:hasRole name="owner">
                            <li><a href="/InformationSystemWEB/pages/main.jsp">Список пользователей</a></li>
                        </shiro:hasRole><!--
                        --><li><a href="/InformationSystemWEB/pages/departmentTable.jsp">Список отделов</a></li><!--
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
                    <%  ControllerDAO con = ControllerDAO.getInstance();
                        CompanyDAO compDAO = con.getCompanyDAO();
                        DepartmentDAO depDAO = con.getDepartmentDAO();
                        EmployeeDAO empDAO = con.getEmployeeDAO();
                        Company c = compDAO.getCompanyById(companyID);

                        if (request.getParameter("goal").equals("add")) {%>
                    <h2 style="text-align: center">Создание сотрудника</h2>

                    <form method="POST" action="/InformationSystemWEB/addEmployee">
                        <table width="50" border="0" align="center">
                            <tbody>   
                            <input type="hidden" name="companyID" value="<%=companyID%>">
                            <tr>
                                <td>Фамилия</td>
                                <td><input type="text" name="lastName" placeholder="Введите фамилию" size="90" maxlength="90"></td>
                            </tr>
                            <tr>
                                <td>Имя</td>
                                <td><input type="text" name="firstName" placeholder="Введите имя" size="90" maxlength="90"></td>
                            </tr>
                            <tr>
                                <td>Должность</td>
                                <td><input type="text" name="function" placeholder="Введите должность" size="90" maxlength="90"></td>
                            </tr>
                            <tr>
                                <td>Зарплата</td>
                                <td><input type="text" name="salary" placeholder="Введите зарплату" size="90" maxlength="90"></td>
                            </tr>
                            <tr>
                                <td>Отдел</td>
                                <td><select name="department">
                                        <%
                                            List<Department> deps = depDAO.getDepartmentByCompany(c);
                                            for (Department d : deps) {
                                        %>
                                        <option value="<%=d.getId()%>"><%=d.getName()%></option>
                                        <%}%>
                                    </select></td>
                            </tr>
                            </tbody>
                        </table>
                        <p style="text-align: center"><button class="btn btn-default" type="submit">Создать</button></p>
                    </form>
                    <% } else if (request.getParameter("goal").equals("edit")) {%>
                    <h2 style="text-align: center">Редактирование сотрудника</h2>

                    <form method="POST" action="/InformationSystemWEB/changeEmployee">
                        <table width="50" border="0" align="center">
                            <tbody>      
                            <input type="hidden" name="id" value="<%=request.getParameter("id")%>">
                            <input type="hidden" name="companyID" value="<%=companyID%>">
                            <tr>
                                <td>Фамилия</td>
                                <td><input type="" name="lastName" value="<%=request.getParameter("lastName")%>" size="90" maxlength="90"></td>
                            </tr>
                            <tr>
                                <td>Имя</td>
                                <td><input type="text" name="firstName" value="<%=request.getParameter("firstName")%>" size="90" maxlength="90"></td>
                            </tr>
                            <tr>
                                <td>Должность</td>
                                <td><input type="text" name="function" value="<%=request.getParameter("function")%>" size="90" maxlength="90"></td>
                            </tr>
                            <tr>
                                <td>Зарплата</td>
                                <td><input type="text" name="salary" value="<%=request.getParameter("salary")%>" size="90" maxlength="90"></td>
                            </tr>
                            <tr>
                                <td>Отдел</td>
                                <td><select name="department">
                                        <%
                                            Employee e = empDAO.getEmployeeById(Long.parseLong(request.getParameter("id")));
                                            List<Department> deps = depDAO.getDepartmentByCompany(c);
                                            for (Department d : deps) {
                                        %>
                                        <option <%if (d.getId() == e.getDepartment().getId()) {%>selected <%}%>value="<%=d.getId()%>">
                                            <%=d.getName()%></option>
                                            <%}%>
                                    </select></td>
                            </tr>
                            </tbody>
                        </table>
                        <p style="text-align: center"><button class="btn btn-default" type="submit">Изменить</button></p>
                    </form>
                    <% }%>
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

