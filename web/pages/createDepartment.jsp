<%-- 
    Document   : createDepartment
    Created on : 20.03.2016, 14:59:16
    Author     : Игорь
--%>

<%@page import="model.Company"%>
<%@page import="java.util.List"%>
<%@page import="controller.ControllerDAO"%>
<%@page import="model.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% long companyID = (Long)session.getAttribute("companyID");%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>main</title>
        <%
            ControllerDAO controller = ControllerDAO.getInstance();
            Company c = controller.getCompanyDAO().getCompanyById(companyID);
            session.setAttribute("company", c);
        %>
    </head>

   <body>
        <header>
            <table width="849" border="0" align="center">
                <tbody>
                    <tr>
                        <th scope="col"><img src="/InformationSystemWEB/images/nc-logo.jpg" width="200" height="55" alt=""/></th>
                        <th scope="col"><h1 style="text-align: center"><%=session.getAttribute("companyName")%></h1></th>
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
                <form action="/InformationSystemWEB/servlets/CreateDepartment" method="POST">
                    <h2 style="text-align: center">Изменение отдела</h2>
                <table width="50" border="0" align="center">
                    <tbody>                        
                        <tr>
                            <td>Название </td>
                            <td><input type="text" name="name" value="Введите названи отдела" size="30" maxlength="30"></td>
                        </tr>
                        <tr>
                            <td>Директор </td>
                            <td>
                                <select name="directorID">                         
                                    <%
                                        List<Employee> emps = ControllerDAO.getInstance().getEmployeeDAO().getlEmployeeByCompany(c);
                                        for(Employee e : emps){
                                    %>
                                    <option value="<%=e.getId()%>"><%=e.getFirstName() + " " + e.getLastName()%></option>
                                    <%}%>
                                </select>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p style="text-align: center"><input type="submit" value="Сохранить">
                    <input type="reset" value="Очистить"></p>
                </form>                
            </blockquote>
                                <div align="left"><a href="/InformationSystemWEB/pages/departmentTable.jsp">К отделам</a></div>
        </main>
        <footer>
            <p style="text-align: center">2016 год</p></footer>
    </body>
</html>
