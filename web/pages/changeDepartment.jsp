<%-- 
    Document   : changeDepartment
    Created on : 20.03.2016, 15:22:57
    Author     : Игорь
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>main</title>
        <%
            Object obj = session.getAttribute("department");
            
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
            <blockquote>
                <h2 style="text-align: center">Изменение отдела</h2>
                <table width="50" border="0" align="center">
                    <tbody>                        
                        <tr>
                            <td>Название </td>
                            <td><input type="text" name="id" value="" size="30" maxlength="30"></td>
                        </tr>
                        <tr>
                            <td>Директор </td>
                            <td><input type="text" name="id" value="" size="30" maxlength="15"></td>
                        </tr>
                    </tbody>
                </table>
                <p style="text-align: center"><input type="submit" value="Сохранить">
                    <input type="reset" value="Очистить"></p>
            </blockquote>
        </main>
        <footer>
            <p style="text-align: center">2016 год</p></footer>
    </body>
</html>
