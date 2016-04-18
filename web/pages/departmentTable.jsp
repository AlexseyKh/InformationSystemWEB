<%-- 
    Document   : departmentTable
    Created on : 17.03.2016, 20:24:36
    Author     : Игорь
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="model.Employee"%>
<%@page import="controller.EmployeeDAO"%>
<%@page import="controller.DepartmentDAO"%>
<%@page import="controller.CompanyDAO"%>
<%@page import="model.Company"%>
<%@page import="model.Department"%>
<%@page import="java.util.List"%>
<%@page import="controller.ControllerDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% long companyID = (Long) session.getAttribute("companyID");
    String pName = (String) session.getAttribute("name");
    String pDirector = null;
    if (pName != null) {
        pDirector = (String) session.getAttribute("director");
    } else {
        pName = "%";
        pDirector = "%";
    }
    %>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Список отделов</title>
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
            <h1 class="tagline">Компания <%=session.getAttribute("companyName")%></h1>
            <nav class="nav primary-nav">
                <ul>
                    <li><a href="/InformationSystemWEB/index.jsp">Главная</a></li><!--
                    --><li><a href="/InformationSystemWEB/pages/changeCompany.jsp?companyID=<%=companyID%>">Изменить компанию</a></li><!--
                    --><li><a href="/InformationSystemWEB/pages/departmentTable.jsp">Список отделов</a></li><!--
                    --><li><a href="/InformationSystemWEB/pages/employeeTable.jsp">Список сотрудников</a></li><!--
                    --><li><a href="">Справка</a></li>
                </ul>
            </nav>
        </header>
        <main>
            <script>CheckboxDepartmentDel = function () {
                        var selectedItems = new Array();
                        var checked = $("input[class='departmentsCheckbox']:checked");
                        checked.each(function () {
                            selectedItems.push($(this).val());
                        });
                        $.ajax({
                            url: '/InformationSystemWEB/servlets/DeleteDepartment',
                            type: 'POST',
                            data: 'department_Ids=' + selectedItems.valueOf(),
                            success: function () {
                                document.location.href = "/InformationSystemWEB/departmentTable?companyID=<%=companyID%>";
                            },
                            error: function(jqXHR, textStatus, errorThrown) {
                                alert(errorThrown);
                            }
                        });

                    }</script>
                <%
                    InitialContext ic = new InitialContext();
                    ControllerDAO controller = (ControllerDAO)ic.lookup("controller.ControllerDAO");
                    CompanyDAO compDAO = controller.getCompanyDAO();
                    DepartmentDAO depDAO = controller.getDepartmentDAO();                    
                    List<Department> list = null;                         
                %>
            <section class="row">
                <h2 style="text-align: center">Таблица отделов</h2>

                <table id="table" width="600">                
                
                <thead>
                    <tr>
                        <td align="center"></td>
                        <td align="center">Название</td>
                        <td align="center">Директор</td>
                        <td align="center">Изменить</td>
                    </tr>
                </thead>
                    <tbody>
                    <%
                        List<Department> deps = (List<Department>) request.getSession().getAttribute("searchDepartments");
                        request.getSession().setAttribute("searchDepartments", null);
                        if (deps != null) {
                                list = deps;
                            } else {
                                deps = (List<Department>) request.getSession().getAttribute("departments");
                                request.getSession().setAttribute("departments", null);
                                if (deps == null) {
                                    list = depDAO.getDepartmentByCompany(compDAO.getCompanyById(companyID));
                                } else {
                                    list = deps;
                                }
                            }
                        for (Department d : list) {
                            String name = null;
                                name = d.getName();
                            String director = (d.getDirector() != null)?(d.getDirector().getFirstName() + " " + d.getDirector().getLastName()):("null");
                         
                    %>
                    <tr>
                        <td align="center"><input type="checkbox" class="departmentsCheckbox" value="<%=d.getId()%>"></td>
                        <td><a href="/InformationSystemWEB/pages/employeeTable.jsp?departmentID=<%=d.getId()%>"><%=name%></a></td>
                        <td><%=director%></td>
                        <td><a href="/InformationSystemWEB/pages/changeDepartment.jsp?&departmentID=<%=d.getId()%>">Изменить</a></td>
                    </tr>
                    <%}
                    %>
                    
                </tbody>
            </table>
                    <p><div align="center"><button class="btn btn-default" onclick="location.href = '/InformationSystemWEB/pages/createDepartment.jsp?';">Добавить отдел</button><button class="btn btn-default" margin-left="5" onclick="CheckboxDepartmentDel();">Удалить отмеченное</button></div></p>
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
        </div>
    </body>
</html>
