<%-- 
    Document   : changeDepartment
    Created on : 20.03.2016, 15:22:57
    Author     : Игорь
--%>

<%@page import="model.Employee"%>
<%@page import="java.util.List"%>
<%@page import="model.Department"%>
<%@page import="controller.ControllerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% long companyID = (Long)session.getAttribute("companyID");%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>main</title>
        <%
            long departmentID = Long.valueOf(request.getParameter("departmentID"));
            ControllerDAO controller = ControllerDAO.getInstance();
            Department d = controller.getDepartmentDAO().getDepartmentById(departmentID);
            session.setAttribute("department", d);
            Employee director = d.getDirector();
        %><link rel="stylesheet" href="/InformationSystemWEB/css/main.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,100&subset=cyrillic,latin">
    </head>
        <body>
        <header class="primary-header container group">
            <img src="/InformationSystemWEB/images/nc-logo.png" width="30%" align="center" class="logo">
            </img>
            <h1 class="tagline">Компания <%=session.getAttribute("companyName")%></h1>
            <nav class="nav primary-nav">
                <ul>
                    <li><a href="/InformationSystemWEB/index.jsp">Главная</a></li><!--
                    --><li><a href="/InformationSystemWEB/pages/departmentTable.jsp">Список отделов</a></li><!--
                    --><li><a href="/InformationSystemWEB/pages/employeeTable.jsp">Список сотрудников</a></li><!--
                    --><li><a href="">Справка</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <section class="row">
                <form action="/InformationSystemWEB/servlets/ChangeDepartment" method="POST">
                    <h2 style="text-align: center">Изменение отдела</h2>
                <table width="50" border="0" align="center">
                    <tbody>                        
                        <tr>
                            <td>Название </td>
                            <td><input type="text" name="name" value="<%=d.getName()%>" size="90" maxlength="90"></td>
                        </tr>
                        <tr>
                            <td>Директор </td>
                            <td>
                                <select name="directorID">
                                    <%
                                        List<Employee> emps = ControllerDAO.getInstance().getEmployeeDAO().getlEmployeeByCompany(d.getCompany());
                                        for(Employee e : emps){
                                    %>
                                    <option <%if(director != null && director.getId() == e.getId()){%>selected <%}%>value="<%=e.getId()%>"><%=e.getFirstName() + " " + e.getLastName()%></option>
                                    <option value="-1">null</option>
                                    <%}%>
                                </select>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p style="text-align: center"><input class="btn btn-default" type="submit" value="Сохранить">
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
    </body>
</html>
