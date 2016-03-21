<%-- 
    Document   : departmentTable
    Created on : 17.03.2016, 20:24:36
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
                        <th scope="col"><img src="/InformationSystemWEB/images/nc-logo.jpg" width="200" height="55" alt="" /></th>
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
            <%
                    String s = request.getParameter("companyID");
                    long companyID = Long.valueOf(s);
                    ControllerDAO con = ControllerDAO.getInstance();
                    CompanyDAO compDAO = con.getCompanyDAO();
                    DepartmentDAO depDAO = con.getDepartmentDAO();                    
                    List<Department> list = depDAO.getDepartmentByCompany(compDAO.getCompanyById(companyID));                  
                    
                    
                %>
            <blockquote>
                <h2 style="text-align: center">Таблица отделов</h2>
            </blockquote>
                <div align="right"><a href="/InformationSystemWEB/pages/createDepartment.jsp?companyID=<%=companyID%>">Добавить отдел</a></div>
            <table width="500" border="1" align="center" cellpadding="10" cellspacing="0">
                
                <tbody>
                    <tr>
                        <td align="center">id </td>
                        <td align="center">Название</td>
                        <td align="center">Директор</td>
                        <td align="center">Сотрудники</td>
                        <td align="center">Изменить</td>
                        <td align="center">Удалить</td>
                    </tr>
                    <%
                        for (Department d : list) {
                            String director = (d.getDirector() != null)?(d.getDirector().getFirstName() + " " + d.getDirector().getLastName()):("null");
                    %>
                    <tr>
                        <td><%=d.getId()%></td>
                        <td><%=d.getName()%></td>
                        <td><%=director%></td>
                        <td><a href="/InformationSystemWEB/pages/employeeTable.jsp?companyID=<%=s%>&departmentID=<%=d.getId()%>">Просмотреть</a></td>
                        <td><a href="/InformationSystemWEB/pages/changeDepartment.jsp?departmentID=<%=d.getId()%>">Изменить</a></td>
                        <td><a href="/InformationSystemWEB/servlets/DeleteDepartment?departmentID=<%=d.getId()%>">Удалить</a></td>
                    </tr>
                    <%}%>
                </tbody>
            </table> 
        </main>
        <footer>
            <p style="text-align: center">2016 год</p></footer>
    </body>
</html>
