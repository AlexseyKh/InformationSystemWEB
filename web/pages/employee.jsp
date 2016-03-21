<%-- 
    Document   : createEmployee
    Created on : 20.03.2016, 15:24:12
    Author     : Игорь
--%>

<%@page import="model.Company"%>
<%@page import="controller.EmployeeDAO"%>
<%@page import="controller.CompanyDAO"%>
<%@page import="controller.DepartmentDAO"%>
<%@page import="model.Department"%>
<%@page import="controller.ControllerDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.Employee"%>
<%@page import="model.Employee"%>
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
                <%  ControllerDAO con = ControllerDAO.getInstance();
                    CompanyDAO compDAO = con.getCompanyDAO();
                    DepartmentDAO depDAO = con.getDepartmentDAO();
                    EmployeeDAO empDAO = con.getEmployeeDAO();
                    Company c = compDAO.getCompanyById(Long.parseLong(request.getParameter("companyID")));
                    
                    
                    if(request.getParameter("goal").equals("add")){ %>
                    <h2 style="text-align: center">Создание сотрудника</h2>
                
                            <form method="POST" action="/InformationSystemWEB/addEmployee">
                <table width="50" border="0" align="center">
                    <tbody>                        
                        <tr>
                            <td>Фамилия</td>
                            <td><input type="text" name="lastName" placeholder="Введите фамилию" size="30" maxlength="30"></td>
                        </tr>
                        <tr>
                            <td>Имя</td>
                            <td><input type="text" name="firstName" placeholder="Введите имя" size="30" maxlength="15"></td>
                        </tr>
                        <tr>
                            <td>Должность</td>
                            <td><input type="text" name="function" placeholder="Введите должность" size="30" maxlength="15"></td>
                        </tr>
                        <tr>
                            <td>Зарплата</td>
                            <td><input type="text" name="salary" placeholder="Введите зарплату" size="30" maxlength="15"></td>
                        </tr>
                        <tr>
                            <td>Отдел</td>
                            <td><select name="department">
                                    <% 
                                        List<Department> deps = depDAO.getDepartmentByCompany(c);
                                        for(Department d : deps){
                                    %>
                                    <option value="<%=d.getId()%>"><%=d.getName()%></option>
                                    <%}%>
                                </select></td>
                        </tr>
                    </tbody>
                </table>
                                <p style="text-align: center"><button type="submit">Создать</button></p>
                            </form>
                    <% } else if(request.getParameter("goal").equals("edit")){%>
                    <h2 style="text-align: center">Редактирование сотрудника</h2>
                    
                    <form method="POST" action="/InformationSystemWEB/changeEmployee">
                <table width="50" border="0" align="center">
                    <tbody>                        
                        <tr>
                            <td>Фамилия</td>
                            <td><input type="" name="lastName" value="<%=request.getParameter("lastName")%>" size="30" maxlength="30"></td>
                        </tr>
                        <tr>
                            <td>Имя</td>
                            <td><input type="text" name="firstName" value="<%=request.getParameter("firstName")%>" size="30" maxlength="15"></td>
                        </tr>
                        <tr>
                            <td>Должность</td>
                            <td><input type="text" name="function" value="<%=request.getParameter("function")%>" size="30" maxlength="15"></td>
                        </tr>
                        <tr>
                            <td>Зарплата</td>
                            <td><input type="text" name="salary" value="<%=request.getParameter("salary")%>" size="30" maxlength="15"></td>
                        </tr>
                        <tr>
                            <td>Отдел</td>
                            <td><select name="department">
                                    <% 
                                        Employee e = empDAO.getEmployeeById(Long.parseLong(request.getParameter("id")));
                                        List<Department> deps = depDAO.getDepartmentByCompany(c);
                                        for(Department d : deps){
                                    %>
                                    <option <%if(d.getId() == e.getDepartment().getId()){%>selected <%}%>value="<%=d.getId()%>">
                                    <%=d.getName()%></option>
                                    <%}%>
                                </select></td>
                        </tr>
                    </tbody>
                </table>
                                <p style="text-align: center"><button type="submit">Изменить</button></p>
                            </form>
                    <% } %>
            </blockquote>
        </main>
        <footer>
            <p style="text-align: center">2016 год</p></footer>
    </body>
</html>
