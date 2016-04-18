<%-- 
    Document   : companyTable
    Created on : Mar 20, 2016, 5:27:04 PM
    Author     : Alexey
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.ejb.EJB"%>
<%@page import="java.util.Locale"%>
<%@page import="model.Employee"%>
<%@page import="model.Department"%>
<%@page import="java.util.List"%>
<%@page import="model.Company"%>
<%@page import="controller.CompanyDAO"%>
<%@page import="controller.ControllerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%session.setAttribute("companyID", null);%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Справочная система</title>
        <% 
            InitialContext ic = new InitialContext();
            ControllerDAO controller = (ControllerDAO)ic.lookup("controller.ControllerDAO");
        %>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,100&subset=cyrillic,latin">
        <script src="http://code.jquery.com/jquery-1.8.3.js"></script>
        <link rel="stylesheet" type="text/css" href="/InformationSystemWEB/jquery/datatables.min.css"/>
        <script type="text/javascript" src="/InformationSystemWEB/jquery/datatables.min.js"></script>
        <link rel="stylesheet" type="text/css" href="/InformationSystemWEB/css/main.css">
        <script>
            $(document).ready(function () {
                $('#table').DataTable({
                    "ordering": [2],
                    "paging": false,
                    "info": false,
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/9dcbecd42ad/i18n/Russian.json"
                    }
                });
            });
        </script>
    </head>
    <body>
        <div style="background: #dcf2ff; max-width: 1024px; margin: 0 auto;">
            <header class="primary-header container group">
                <img src="/InformationSystemWEB/images/nc-logo.png" width="30%" align="center" class="logo">
                </img>
                <h1 class="tagline">Справочная система</h1>
            </header>
            <main>
                <script>CheckboxCompanyDel = function () {
                        var selectedItems = new Array();
                        var checked = $("input[class='companiesCheckbox']:checked");
                        checked.each(function () {
                            selectedItems.push($(this).val());
                        });
                        $.ajax({
                            url: '/InformationSystemWEB/servlets/DeleteCompany',
                            type: 'POST',
                            data: 'company_Ids=' + selectedItems.valueOf(),
                            success: function () {
                                document.location.href = "/InformationSystemWEB/index.jsp";
                            },
                            error: function(jqXHR, textStatus, errorThrown) {
                                alert(errorThrown);
                            }
                        });

                    }</script>
                <section id="section" class="row">
                    <h2 style="text-align: center">Таблица компаний</h2>
                    <table id="table" width="600">

                        <%
                            Locale.setDefault(Locale.ENGLISH);
                            CompanyDAO compDAO = controller.getCompanyDAO();
                            List<Company> companys = compDAO.getAllCompany();
                        %>

                        <thead>
                            <tr>
                                <td align="center"></td>
                                <td align="center">Название</td>
                                <td align="center">Удалить</td>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (Company c : companys) {
                            %>
                            <tr>
                                <td align="center"><input type="checkbox" class="companiesCheckbox" value="<%=c.getId()%>"></td>
                                <td align="center"><a href = "/InformationSystemWEB/departmentTable?companyID=<%=c.getId()%>"><b><%=c.getName()%></b></a></td>
                                <td align="center"><a href = "/InformationSystemWEB/servlets/DeleteCompany?companyID=<%=c.getId()%>">Удалить</a></td>
                            </tr>
                            <%}%>
                        </tbody>
                    </table>
                    <p><div align="center"><button class="btn btn-default" onclick="location.href = '/InformationSystemWEB/pages/createCompany.jsp';">Добавить компанию</button><button class="btn btn-default" margin-left="5" onclick="CheckboxCompanyDel();">Удалить отмеченное</button></div></p>
                </section>
            </main>
            <footer class="primary-footer container group">
                <p style="text-align: center"> 2016 год</p>
            </footer>
        </header>
    </div>
</body>
</html>
