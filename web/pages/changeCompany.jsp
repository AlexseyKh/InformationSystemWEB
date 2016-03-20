<%-- 
    Document   : changeCompany.jsp
    Created on : Mar 20, 2016, 6:18:34 PM
    Author     : Alexey
--%>

<%@page import="model.Company"%>
<%@page import="controller.ControllerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Change Company</title>
        <%
            long companyID = Long.valueOf(request.getParameter("companyID"));
            ControllerDAO con = ControllerDAO.getInstance();
            Company c = con.getCompanyDAO().getCompanyById(companyID);
            session.setAttribute("company", c);
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
                <form action="/InformationSystemWEB/servlets/ChangeCompany" method="POST">
                    <h2 style="text-align: center">Изменение компании</h2>
                <table width="50" border="0" align="center">
                    <tbody>                        
                        <tr>
                            <td>Название</td>
                            <td><input type="text" name="name" value="<%=c.getName()%>" size="30" maxlength="30"></td>
                        </tr>                       
                    </tbody>
                </table>
                <p style="text-align: center"><input type="submit" value="Сохранить">
                    <input type="reset" value="Очистить"></p>
                </form>                
            </blockquote>
        </main>
        <footer>
            <p style="text-align: center">2016 год</p></footer>
    </body>
</html>
