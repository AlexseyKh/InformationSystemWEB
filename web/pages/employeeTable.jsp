<%-- 
    Document   : employeeTable
    Created on : 17.03.2016, 20:23:40
    Author     : Игорь
--%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="java.util.LinkedList"%>
<%@page import="model.Employee"%>
<%@page import="controller.EmployeeDAO"%>
<%@page import="controller.DepartmentDAO"%>
<%@page import="controller.CompanyDAO"%>
<%@page import="model.Company"%>
<%@page import="model.Department"%>
<%@page import="java.util.List"%>
<%@page import="controller.ControllerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%  long companyID = (Long) session.getAttribute("companyID");
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
        
    </head>

    <body>
         <div style="background: #dcf2ff; max-width: 1024px; margin: 0 auto;">
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
                <h2 style="text-align: center">Таблица сотрудников</h2>
            <div align="center"><form method="POST" action="/InformationSystemWEB/searchInEmployee">
                    
                    <p><input type="search" name="search" <%String search = request.getParameter("search");
    if (search == null) {

            search = "Поиск по сотрудникам";%>
                              placeholder="<%=search%>"
                              <%} else {%>
                              value="<%=search%>"
                              <%}%>> > 
                        <input type="submit" value="Найти"></p>
                </form>
            </div>
                    
            
                
                
            
            <table width="1024" tableborder="1" align="center" cellpadding="10" cellspacing="0">
                <%
                        InitialContext ic = new InitialContext();
                        ControllerDAO controller = (ControllerDAO)ic.lookup("controller.ControllerDAO");
                        CompanyDAO compDAO = controller.getCompanyDAO();
                        DepartmentDAO depDAO = controller.getDepartmentDAO();
                        EmployeeDAO empDAO = controller.getEmployeeDAO();

                        
                        List<Employee> list = null;
                        
                    %>
                <tbody>
                <thead>
                    <tr>
                        <td align="center">Фамилия </td>
                        <td align="center">Имя</td>
                        <td align="center">Должность</td>
                        <td align="center">Зарплата</td>
                        <td align="center">Отдел </td>
                        <td align="center">Редактировать</td>
                        <td align="center">Удалить</td>
                    </tr>
                </thead>
                    <tr>
                        <td align="center" rowspan="2"><input class="inputwidth" type="text" name="lastName" value="<%=pLastName%>"></td>
                        <td align="center" rowspan="2"><input class="inputwidth" type="text" name="firstName" value="<%=pFirstName%>"></td>
                        <td align="center" rowspan="2"><input class="inputwidth" type="text" name="function" value="<%=pFunction%>"></td>
                        <td align="center">MIN:<input class="inputwidth" type="number" id="salMin" name="salaryMin" min="0" max="1000000" value="<%=salaryMin%>"></td>
                        <td align="center" rowspan="2"><input class="inputwidth" type="text" name="department" value="<%=pDepartment%>"></td>
                        <td align="center" rowspan="2"></td>
                        <td align="center" rowspan="2"></td>
                    </tr>
                    <tr>
                        <td align="center"> MAX:                       
                            <input class="inputwidth" type="number" id="salMax" name="salaryMax" min="0" max="1000000" value="<%=salaryMax%>">
                        </td>
                    </tr>

                    <%
                        List<Employee> emps = (List<Employee>) request.getSession().getAttribute("searchEmployees");
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
                        for(Employee e : list) {
                            StringBuffer edit = new StringBuffer("/InformationSystemWEB/pages/employee.jsp?");
                            edit.append("goal=edit");
                            edit.append("&id=" + e.getId());
                            edit.append("&lastName=" + e.getLastName());
                            edit.append("&firstName=" + e.getFirstName());
                            edit.append("&function=" + e.getFunction());
                            edit.append("&salary=" + e.getSalary());
                            edit.append("&department=" + e.getDepartment().getId());
                            
                            String delete = "/InformationSystemWEB/deleteEmployee?id=" + e.getId();
                            
                            String lastName = null;
                            String firstName = null;
                            String function = null;

                            if(search != null){
                                lastName = e.getLastName().replaceAll(search, "<b>"+search+"</b>");
                                firstName = e.getFirstName().replaceAll(search, "<b>"+search+"</b>");
                                function = e.getFunction().replaceAll(search, "<b>"+search+"</b>");
                            
                            } else {
                                lastName = e.getLastName();
                                firstName = e.getFirstName();
                                function = e.getFunction();
                            }
                        %>
                    <tr>
                        <td align="center"><%=lastName%></td>
                        <td align="center"><%=firstName%></td>
                        <td align="center"><%=function%></td>
                        <td align="center"><%=e.getSalary()%></td>
                        <td align="center"><%=e.getDepartment().getName()%></td>
                        <td align="center"><a href="<%=edit.toString()%>">Редактировать</a></td>
                        <td align="center"><a href="<%=delete%>">Удалить</a></td>
                    </tr>
                    <%}%>
                    
                </tbody>
            </table>
                    <div align="center"><p><form name="tableForm" method="POST" action="/InformationSystemWEB/searchEmployeeByPattern"><button class="btn btn-default" type="submit">Искать</button></form><button class="btn btn-default" onclick="location.href = '/InformationSystemWEB/pages/employee.jsp?goal=add';">Добавить сотрудника</button></p></div>
            
                    
                    
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
