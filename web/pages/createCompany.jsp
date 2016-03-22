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
        <title>Create Company</title>
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
                        <td align="center"><img src="/InformationSystemWEB/images/department.png" width="198" height="200" alt=""/>
                                <h3>Список отделов</h3></td>
                        <td align="center"><img src="/InformationSystemWEB/images/employee.png" width="200" height="200" alt=""/>
                                <h3>Список сотрудников</h3></td>
                        <td align="center"><img src="/InformationSystemWEB/images/help.png" width="200" height="200" alt=""/>
                            <h3>Справка</h3></td>
                    </tr>
                </tbody>
            </table>
        </main>
                    </header>
        <main>
            <form action="/InformationSystemWEB/servlets/CreateCompany" method="POST">
                <blockquote>
                <h2 style="text-align: center">Создание компании</h2>
                <table width="50" border="0" align="center">                    
                    <tbody>                  
                        <tr>
                            <td>Название </td>
                            <td><input type="text" name="comapnyName" value="Введите название компании" size="30" maxlength="30"></td>
                        </tr>                        
                    </tbody>
                </table>
                <p style="text-align: center"><input type="submit" value="Создать">
                    <input type="reset" value="Очистить"></p>
            </blockquote>
            </form>            
        </main>
        <div align="left"><a href="/InformationSystemWEB/index.jsp">К списку компаний</a></div>
        <footer>
            <p style="text-align: center">2016 год</p></footer>
    </body>
</html>
