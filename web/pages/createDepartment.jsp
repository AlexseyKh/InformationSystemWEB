<%-- 
    Document   : createDepartment
    Created on : 20.03.2016, 14:59:16
    Author     : Игорь
--%>

<%@page import="java.util.List"%>
<%@page import="controller.ControllerDAO"%>
<%@page import="model.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>main</title>
        <%
            ControllerDAO controller = ControllerDAO.getInstance();
            List<Employee> directors = controller.getEmployeeDAO().getEmployeeByFunction("директор");
        %>
    </head>

    <body>
        <header>
            <table width="849" border="0" align="center">
                <tbody>
                    <tr>
                        <th scope="col"><img src="/InformationSystemWEB/images/nc-logo.jpg" width="200" height="55" alt=""/></th>
                        <th scope="col"><h1 style="text-align: center">Информационная система</h1></th>
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
            <form action="/InformationSystemWEB/servlets/CreateDepartment" method="POST">
                <blockquote>
                <h2 style="text-align: center">Создание отдела</h2>
                <table width="50" border="0" align="center">                    
                    <tbody>                  
                        <tr>
                            <td>Название </td>
                            <td><input type="text" name="departmentName" value="Введите название отдела" size="30" maxlength="30"></td>
                        </tr>
                        <tr>
                            <td>Директор</td>
                            <td>
                                <select name="directorID">
                                    <option selected="selected" disabled>Выберите директора<option>
                                    <%
                                        for(Employee emp : directors){
                                    %>
                                    <option value="<%=emp.getId()%>"><%=emp.getFirstName() + " " + emp.getLastName()%></option>
                                    <%
                                        }
                                    %>
                               </select>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <p style="text-align: center"><input type="submit" value="Создать">
                    <input type="reset" value="Очистить"></p>
            </blockquote>
            </form>            
        </main>
        <footer>
            <p style="text-align: center">2016 год</p></footer>
    </body>
</html>
