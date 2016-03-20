<%-- 
    Document   : employeeTable
    Created on : 17.03.2016, 20:23:40
    Author     : Игорь
--%>
<%@page import="model.Employee"%>
<%@page import="controller.EmployeeDAO"%>
<%@page import="controller.DepartmentDAO"%>
<%@page import="controller.CompanyDAO"%>
<%@page import="model.Company"%>
<%@page import="model.Department"%>
<%@page import="java.util.List"%>
<%@page import="controller.ControllerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>main</title>
    </head>

    <body>
        <header>
            <table width="849" border="0" align="center">
                <tbody>
                    <tr>
                        <th scope="col"><img src="/InformationSystemWEB/pages/nc-logo.jpg" width="200" height="55" alt=""/></th>
                        <th scope="col"><h1>Информационная система</h1></th>
                    </tr>
                </tbody>
            </table>
            <main>
            <table width="200" border="1" align="center">
                <tbody>
                    <tr>
                        <td align="center"><a href="/InformationSystemWEB/pages/departmentTable.jsp"><img src="/InformationSystemWEB/images/department.png" width="198" height="200" alt=""/>
                                <h3>Список отделов</h3><a></td>
                        <td align="center"><a href="/InformationSystemWEB/pages/employeeTable.jsp"><img src="/InformationSystemWEB/images/employee.png" width="200" height="200" alt=""/>
                                <h3>Список сотрудников</h3><a></td>
                        <td align="center"><img src="/InformationSystemWEB/images/help.png" width="200" height="200" alt=""/>
                            <h3>Справка</h3></td>
                    </tr>
                </tbody>
            </table>
        </main>
        </header>
        <main>
            <blockquote>
                <h2 style="text-align: center">Таблица сотрудников</h2>
            </blockquote>
            <table width="500" border="1" align="center" cellpadding="10" cellspacing="0">
                <%
                    ControllerDAO con = ControllerDAO.getInstance();
                    CompanyDAO compDAO = con.getCompanyDAO();
                    DepartmentDAO depDAO = con.getDepartmentDAO();
                    EmployeeDAO empDAO = con.getEmployeeDAO();
                    
                    Department dep = depDAO.getDepartmentByName("Руководство").get(0);
                    List<Employee> list = empDAO.getEmployeeeByDepartment(dep);
                    %>
                <tbody>
                    <tr>
                        <td align="center">id </td>
                        <td align="center">Фамилия </td>
                        <td align="center">Имя</td>
                        <td align="center">Должность</td>
                        <td align="center">Зарплата</td>
                        <td align="center">Отдел </td>
                    </tr>
                    <%
                        for(Employee e : list) {
                        %>
                    <tr>
                        <td align="center"><%=e.getId()%></td>
                        <td align="center"><%=e.getLastName()%></td>
                        <td align="center"><%=e.getFirstName()%></td>
                        <td align="center"><%=e.getFunction()%></td>
                        <td align="center"><%=e.getSalary()%></td>
                        <td align="center"><%=e.getDepartment().getName()%></td>
                    </tr>
                    <%}%>
                    
                </tbody>
            </table> 
        </main>
        <footer>
            <p style="text-align: center"> 2016 год</p>
        </footer>
    </body>
</html>
