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
        <title>main</title>
    </head>

    <body>
        <header>
            <table width="849" border="0" align="center">
                <tbody>
                    <tr>
                        <th scope="col"><img src="/InformationSystemWEB/images/nc-logo.jpg" width="200" height="55" alt="" /></th>
                        <th scope="col"><h1><%=session.getAttribute("companyName")%></h1></th>
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
                    ControllerDAO con = ControllerDAO.getInstance();
                    CompanyDAO compDAO = con.getCompanyDAO();
                    DepartmentDAO depDAO = con.getDepartmentDAO();                    
                    List<Department> list = null;                         
                %>
            <blockquote>
                <h2 style="text-align: center">Таблица отделов</h2>
            </blockquote>
                <div align="right"><a href="/InformationSystemWEB/pages/createDepartment.jsp?">Добавить отдел</a></div>
               
                <form method="POST" action="/InformationSystemWEB/searchInDepartment">
                    <input type="hidden" name="companyID" value="<%=companyID%>">
                    <p><input type="search" name="search" <%String search = request.getParameter("search");
    if (search == null) {%>
                              placeholder="Поиск по отделам"
                              <%} else {%>
                              value="<%=search%>"
                              <%}%>> 
                        <input type="submit" value="Найти"></p>
                </form>
            
                <form method="POST" action="/InformationSystemWEB/searchDepartmentByPattern">
                <p style="text-align: center"><button type="submit">Искать</button></p>
                <table width="500" border="1" align="center" cellpadding="10" cellspacing="0">                
                <tbody>
                    
                    <tr>
                        <td align="center">Название</td>
                        <td align="center">Директор</td>
                        <td align="center">Сотрудники</td>
                        <td align="center">Изменить</td>
                        <td align="center">Удалить</td>
                    </tr>
                    <tr>
                        <td align="center"><input type="text" name="name" value="<%=pName%>"></td>
                        <td align="center"><input type="text" name="director" value="<%=pDirector%>"></td>
                        <td align="center"></td>
                        <td align="center"></td>
                        <td align="center"></td>
                        
                    </tr>
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
                            if(search != null){
                                name = d.getName().replaceAll(search, "<b>"+search+"</b>");
                            
                            } else {
                                name = d.getName();
                            }
                            String director = (d.getDirector() != null)?(d.getDirector().getFirstName() + " " + d.getDirector().getLastName()):("null");
                    %>
                    <tr>
                        <td><%=name%></td>
                        <td><%=director%></td>
                        <td><a href="/InformationSystemWEB/pages/employeeTable.jsp?departmentID=<%=d.getId()%>">Просмотреть</a></td>
                        <td><a href="/InformationSystemWEB/pages/changeDepartment.jsp?&departmentID=<%=d.getId()%>">Изменить</a></td>
                        <td><a href="/InformationSystemWEB/servlets/DeleteDepartment?departmentID=<%=d.getId()%>">Удалить</a></td>
                    </tr>
                    <%}
                    %>
                    
                </tbody>
            </table> 
                
                </form>
                    <div align="left"><a href="/InformationSystemWEB/index.jsp">К списку компаний</a></div>
                    <div align="left"><a href="/InformationSystemWEB/index.jsp">На главную</a></div>
        </main>
        <footer>
            <p style="text-align: center">2016 год</p></footer>
    </body>
</html>
