<%-- 
    Document   : employeeTable
    Created on : 17.03.2016, 20:23:40
    Author     : Игорь
--%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@page import="java.util.LinkedList"%>
<%@page import="model.Employee"%>
<%@page import="controller.EmployeeDAO"%>
<%@page import="controller.DepartmentDAO"%>
<%@page import="controller.CompanyDAO"%>
<%@page import="model.Company"%>
<%@page import="model.Department"%>
<%@page import="java.util.List"%>
<%@page import="controller.ControllerDAO"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%long companyID = (Long) SecurityUtils.getSubject().getSession().getAttribute("companyID");
    String name = SecurityUtils.getSubject().getSession().getAttribute("companyName").toString();
    String pLastName = (String) request.getParameter("lastName");
    String pFirstName = null;
    String pFunction = null;
    String pDepartment = null;
    int salaryMin = 0;
    int salaryMax = 1000000;
    if (pLastName != null) {
        pFirstName = (String) request.getParameter("firstName");
        pFunction = (String) request.getParameter("function");
        pDepartment = (String) request.getParameter("department");
        salaryMin = Integer.parseInt(request.getParameter("salaryMin"));
        salaryMax = Integer.parseInt(request.getParameter("salaryMax"));
    } else {
        pLastName = "%";
        pFirstName = "%";
        pFunction = "%";
        pDepartment = "%";

    }
%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Список сотрудников</title>
        <link rel="stylesheet" href="/InformationSystemWEB/css/main.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,100&subset=cyrillic,latin">
        <script>
            $(document).ready(function () {
                $('#table').DataTable({
                    "ordering": [2],
                    "paging": false,
                    "info": false,
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Russian.json"
                    }
                });
            });

            CheckboxEmployeeDel = function () {
                var selectedItems = new Array();
                var checked = $("input[class='employeesCheckbox']:checked");
                checked.each(function () {
                    selectedItems.push($(this).val());
                });
                $.ajax({
                    url: '/InformationSystemWEB/deleteEmployee',
                    type: 'POST',
                    data: 'employee_Ids=' + selectedItems.valueOf(),
                    success: function () {
                        document.location.href = "/InformationSystemWEB/employeeTable";
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        alert(errorThrown);
                    }
                });

            }</script>
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
                    <h2 style="text-align: center">Таблица сотрудников</h2>


                    <table id="table">
                        <%
                            ControllerDAO con = ControllerDAO.getInstance();
                            CompanyDAO compDAO = con.getCompanyDAO();
                            DepartmentDAO depDAO = con.getDepartmentDAO();
                            EmployeeDAO empDAO = con.getEmployeeDAO();

                            List<Employee> list = null;

                        %>
                        <tbody>
                        <thead>
                            <tr>
                                <shiro:hasAnyRoles name="admin, owner">
                                    <td align="center"></td>
                                </shiro:hasAnyRoles>
                                <td align="center">Фамилия </td>
                                <td align="center">Имя</td>
                                <td align="center">Должность</td>
                                <td align="center">Зарплата</td>
                                <td align="center">Отдел </td>
                                <shiro:hasAnyRoles name="admin, owner">
                                    <td align="center">Изменить</td>
                                </shiro:hasAnyRoles>
                            </tr>
                        </thead>


                        <%                            List<Employee> emps = (List<Employee>) request.getSession().getAttribute("searchEmployees");
                            request.getSession().setAttribute("searchEmployees", null);
                            if (emps != null) {
                                list = emps;
                            } else {
                                emps = (List<Employee>) request.getSession().getAttribute("employees");
                                request.getSession().setAttribute("employees", null);
                                if (emps != null) {
                                    list = emps;
                                } else if (request.getParameter("departmentID") == null) {
                                    list = new LinkedList<Employee>();
                                    List<Department> deps = depDAO.getDepartmentByCompany(compDAO.getCompanyById(companyID));
                                    for (Department dep : deps) {
                                        list.addAll(empDAO.getEmployeeeByDepartment(dep));
                                    }
                                } else {
                                    Department dep = depDAO.getDepartmentById(Long.parseLong(request.getParameter("departmentID")));
                                    list = new LinkedList<Employee>();
                                    list.addAll(empDAO.getEmployeeeByDepartment(dep));
                                }
                            }
                            for (Employee e : list) {
                                StringBuffer edit = new StringBuffer("/InformationSystemWEB/pages/employee.jsp?");
                                edit.append("goal=edit");
                                edit.append("&id=" + e.getId());
                                edit.append("&lastName=" + e.getLastName());
                                edit.append("&firstName=" + e.getFirstName());
                                edit.append("&function=" + e.getFunction());
                                edit.append("&salary=" + e.getSalary());
                                edit.append("&department=" + e.getDepartment().getId());

                                String lastName = null;
                                String firstName = null;
                                String function = null;

                                lastName = e.getLastName();
                                firstName = e.getFirstName();
                                function = e.getFunction();

                        %>
                        <tr>
                            <shiro:hasAnyRoles name="admin, owner">
                                <td align="center"><input type="checkbox" class="employeesCheckbox" value="<%=e.getId()%>"></td>
                                </shiro:hasAnyRoles>
                            <td align="center"><%=lastName%></td>
                            <td align="center"><%=firstName%></td>
                            <td align="center"><%=function%></td>
                            <td align="center"><%=e.getSalary()%></td>
                            <td align="center"><%=e.getDepartment().getName()%></td>
                            <shiro:hasAnyRoles name="admin, owner">
                                <td align="center"><a href="<%=edit.toString()%>">Изменить</a></td>
                            </shiro:hasAnyRoles>
                        </tr>
                        <%}%>

                        </tbody>
                    </table>
                    <shiro:hasAnyRoles name="admin, owner"><p><div align="center"><button class="btn btn-default" onclick="location.href = '/InformationSystemWEB/pages/employee.jsp?goal=add';">Добавить сотрудника</button><button class="btn btn-default" margin-left="5" onclick="CheckboxEmployeeDel();">Удалить отмеченное</button></div></p></shiro:hasAnyRoles>

                </section>    
            </main>
            <footer>
                <nav class="navfoot">
                    <ul>
                        <li><a href="/InformationSystemWEB/pages/departmentTable.jsp">К отделам</a></li><!--
                        --><li><a href="/InformationSystemWEB/index.jsp">На главную</a></li>
                    </ul>
                </nav>
                <p style="text-align: center">2016 год</p>
            </footer>
        </div>
    </body>
</html>
