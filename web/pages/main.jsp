
<%@page import="org.apache.jasper.tagplugins.jstl.ForEach"%>
<%@page import="security.model.Role"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Set"%>
<%@page import="com.sun.xml.rpc.processor.modeler.j2ee.xml.roleNameType"%>
<%@page import="security.model.User"%>
<%@page import="java.util.List"%>
<%@page import="security.controller.UserDAO"%>
<%@page import="security.controller.RoleDAO"%>
<%@page import="security.controller.SecurityControllerDAO"%>
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%long companyID = (Long) SecurityUtils.getSubject().getSession().getAttribute("companyID");
String name = SecurityUtils.getSubject().getSession().getAttribute("companyName").toString();%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Справочная система</title>
        <link rel="stylesheet" href="/InformationSystemWEB/css/main.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,100&subset=cyrillic,latin">

        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script> 
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.js"></script>
        <script type="text/javascript">
            $('document').ready(function () {

                $('#table tbody').on('click', "tr", function (event) {
                    var username = $(event.target).parents(".tr").find(".name b").text();
                    var password = $(event.target).parents(".tr").find(".pass b").text();
                    $("#username").val(username);
                    $("#password").val(password);
                });

            });
        </script>
    </head>
    <body>
        <div style="background: #dcf2ff; max-width: 1024px; margin: 0 auto;">
            <header class="primary-header container group">
                <img src="/InformationSystemWEB/images/nc-logo.png" width="30%" align="center" class="logo">
                </img>
                <h1 class="tagline">Компания <%=name%></h1>
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
                <section class="row">
                    <div>

                        <h3>Пользователи системы</h3>
                        <table id="table" >
                            <% SecurityControllerDAO sec = SecurityControllerDAO.getInstance();
                                UserDAO userDAO = sec.getUserDAO();
                                RoleDAO roleDAO = sec.getRoleDAO();
                                Role roleComp = roleDAO.getRoleByName(String.valueOf(companyID)).get(0);
                                System.out.println("k3rjnthjgvbfyhjt5k3bvjtk4bvtgjnjtvtkjvbeyjktvejrbvhjtevbtejbvjthbv       " + roleComp.getName());
                                List<User> users = userDAO.getUserByRole(roleComp);
                                //List<User> users = userDAO.getAllUsers();
                            %>
                            <thead>
                                <tr>
                                    <td align="center"></td>
                                    <td align="center">Имя</td>
                                    <td align="center">Роль</td>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    for (User u : users) {
                                        Set<Role> roles = u.getRole();
                                        String roleName = "";
                                        for (Role r : roles) {
                                            if (r.getName().equals("admin")) {
                                                roleName = "admin";
                                                break;
                                            } else if (r.getName().equals("user")) {
                                                roleName = "user";
                                                break;
                                            }
                                        }
                                %>
                                <tr class="tr">
                                    <td align="center"><input type="checkbox" id="usersCheckbox" value="<%=u.getId()%>"></td>
                                    <td align="center" class="name"><b><%=u.getUsername()%></b></td>
                                    <td hidden="true" class="pass"><b><%=u.getPassword()%></b></td>
                                    <td align="center" class="role"><b><%=roleName%></b></td>
                                </tr>
                                <%}%>
                            </tbody>
                        </table>


                        <form id="userData">
                            <h3>Данные пользователя</h3>
                            <div>
                                <label>Логин:</label>
                                <input id="username" name="username" type="text"/>
                                <span class="nameError"></span>
                            </div>
                            <div>
                                <label>Пароль:</label>
                                <input id="password" name="password" type="text"/>
                                <span class="passError"></span>
                            </div>
                            <div>
                                <label>Роль:</label>
                                <select id="role" name="role">
                                    <option value="admin">Администратор</option>
                                    <option value="user">Пользователь</option>
                                </select>
                            </div>
                            <input type="submit" id="save" value="Сохранить" onclick="save"/>
                        </form>

                    </div>
                </section>
            </main>

            <footer class="primary-footer container group">
                <p style="text-align: center"> 2016 год</p>
            </footer>
        </header>
    </div>
</body>
</html>
