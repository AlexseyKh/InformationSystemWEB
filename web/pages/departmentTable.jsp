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
                        <th scope="col"><h1>Информационная система</h1></th>
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
                <h2 style="text-align: center">Таблица отделов</h2>
            </blockquote>
            <table width="500" border="1" align="center" cellpadding="10" cellspacing="0">
                <%
                    ControllerDAO con = ControllerDAO.getInstance();
                    CompanyDAO compDAO = con.getCompanyDAO();
                    DepartmentDAO depDAO = con.getDepartmentDAO();
                    EmployeeDAO empDAO = con.getEmployeeDAO();
                    
                    Company comp = new Company("Музыкальный Магазин");
                    compDAO.addCompany(comp);
                    
                    Department dep = new Department("Руководство");
                    depDAO.addDepartment(dep, comp);
                    Employee director = new Employee("Владимир", "Владимиров", "директор", 14000);
                    empDAO.addEmployee(director, dep);
                    dep.setDirector(director);
                    
                    
                    dep = new Department("Гитары");
                    depDAO.addDepartment(dep, comp);
                    Employee emp = new Employee("Карл", "Зиновьев", "продавец", 15000);
                    empDAO.addEmployee(emp, dep);
                    emp = new Employee("Илья", "Трофимов", "консультант", 14000);
                    empDAO.addEmployee(emp, dep);
                    empDAO.addEmployee(director, dep);
                    
                    dep = new Department("Ударные и Перкуссия");
                    depDAO.addDepartment(dep, comp);
                    emp = new Employee("Сергей", "Коржин", "продавец-консультант", 19000);
                    empDAO.addEmployee(emp, dep);
                    empDAO.addEmployee(director, dep);
                    
                    dep = new Department("Клавишные");
                    depDAO.addDepartment(dep, comp);
                    emp = new Employee("Генадий", "Плут", "продавец", 15000);
                    empDAO.addEmployee(emp, dep);
                    emp = new Employee("Валерия", "Тимофеева", "консультант", 14000);
                    empDAO.addEmployee(emp, dep);
                    List<Department> list = depDAO.getDepartmentByCompany(compDAO.getCompanyByName("Музыкальный Магазин").get(0));
                    empDAO.addEmployee(director, dep);
                    
                    
                %>
                <tbody>
                    <tr>
                        <td align="center">id </td>
                        <td align="center">Название</td>
                        <td align="center">Директор</td>
                    </tr>
                    </tr>
                    <%
                        for (Department d : list) {
                    %>
                    <tr>
                        <td><%=d.getId()%></td>
                        <td><%=d.getName()%></td>
                        <td><%="null"%></td>
                    </tr>
                    <%}%>
                </tbody>
            </table> 
        </main>
        <footer>
            <p style="text-align: center">2016 год</p></footer>
    </body>
</html>
