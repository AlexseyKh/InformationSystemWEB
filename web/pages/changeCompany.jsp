<%-- 
    Document   : changeCompany.jsp
    Created on : Mar 20, 2016, 6:18:34 PM
    Author     : Alexey
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="model.Company"%>
<%@page import="controller.ControllerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Изменение компании</title>
        <%
            long companyID = Long.valueOf(request.getParameter("companyID"));
            InitialContext ic = new InitialContext();
            ControllerDAO controller = (ControllerDAO)ic.lookup("controller.ControllerDAO");
            Company c = controller.getCompanyDAO().getCompanyById(companyID);
            session.setAttribute("company", c);
        %>
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
            
                <form action="/InformationSystemWEB/servlets/ChangeCompany" method="POST">
                    <p><h2 style="text-align: center">Изменение компании</h2></p>
                <p><table width="50" border="0" align="center">
                    <tbody>                        
                        <tr>
                            <td>Название</td>
                            <td><input type="text" name="name" value="<%=c.getName()%>" size="30" maxlength="30"></td>
                        </tr>                       
                    </tbody>
                </table></p>
                <p style="text-align: center"><input type="submit" value="Сохранить">
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
            </div>    </body>
</html>
