
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
            var oldUsername;

            $('document').ready(function () {
                $("#new_form").hide();
                $("#list_a").hide();

                $('#table tbody').on('click', "tr", function (event) {
                    var username = $(event.target).parents(".tr").find(".name b").text();
                    var password = $(event.target).parents(".tr").find(".pass b").text();
                    var role = $(event.target).parents(".tr").find(".role b").text();
                    var id = $(event.target).parents(".tr").find(".usersCheckbox").val();
                    $("#username").val(username);
                    $("#password").val(password);
                    $("#role option[value=" + role + "]").attr("selected", "selected");
                    $("#id").val(id);
                    oldUsername = username;
                    $("#save").prop("disabled", false);
                });

                $('#new_a').on('click', function (event) {
                    $("#new_form").show();
                    $("#new_a").hide();
                    $("#users_list").hide();
                    $("#list_a").show();
                    $("#save").prop("disabled", true);
                });

                $('#list_a').on('click', function (event) {
                    $("#new_form").hide();
                    $("#new_a").show();
                    $("#users_list").show();
                    $("#list_a").hide();
                });







                $('#userData').validate({
                    //Правила
                    rules: {
                        passwordConfirm: {
                            equalTo: "#password"
                        }
                    },
                    //Тексты предупреждений
                    messages: {
                        passwordConfirm: "Пароли не совпадают"
                    },
                    //Обработка и отправка данных
                    submitHandler: function () {
                        var id = $("#id").val();
                        ;
                        $.ajax({
                            url: '/InformationSystemWEB/main',
                            type: 'GET',
                            data: {request: 'save',
                                username: $("#username").attr("value"),
                                pass: $("#password").attr("value"),
                                role: $("#role option:selected").attr("value"),
                                oldUsername: oldUsername},
                            success: function (result) {
                                if (result === "success") {
                                    $("#result").text("Данные пользователя изменены!");

                                    var username = $("#username").attr("value");
                                    var password = $("#password").attr("value");
                                    var role = $("#role option:selected").attr("value");

                                    $(".usersCheckbox[value=" + id + "]").parents(".tr").find(".name b").text(username);
                                    $(".usersCheckbox[value=" + id + "]").parents(".tr").find(".pass b").text(password);
                                    $(".usersCheckbox[value=" + id + "]").parents(".tr").find(".role b").text(role);
                                }
                                if (result === "error") {
                                    $("#usernameError").text("Имя уже существует");
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert(errorThrown);
                            }
                        });
                    }
                });
                jQuery.validator.addMethod("correctUsername", function (value, element) {
                    return /([_a-zA-Z][_a-zA-Z0-9 ]{2,30}[_a-zA-Z0-9])/.test(value);
                }, "Имя должно начинаться с латинской буквы или символа '_' и состоять из них же или цифр и пробелов");

                jQuery.validator.addMethod("correctPassword", function (value, element) {
                    return /([a-zA-Z0-9]{4,16})/.test(value);
                }, 'Пароль должен состоять только из латинских букв и цифр');


                $("#username").rules("add", {
                    required: true,
                    minlength: 4,
                    correctUsername: true,
                    maxlength: 32,
                    messages: {
                        required: "Вы забыли про имя",
                        minlength: jQuery.validator.format("Имя должно содержать не менее {0} символов"),
                        maxlength: jQuery.validator.format("Имя должно содержать не более {0} символов")
                    }
                });
                $("#password").rules("add", {
                    required: true,
                    minlength: 4,
                    correctPassword: true,
                    maxlength: 16,
                    messages: {
                        required: "Вы забыли про пароль",
                        minlength: jQuery.validator.format("Пароль должен содержать не менее {0} символов"),
                        maxlength: jQuery.validator.format("Пароль должен содержать не более {0} символов")
                    }
                });



                $('#new_userData').validate({
                    //Правила
                    rules: {
                        new_passwordConfirm: {
                            equalTo: "#new_password"
                        }
                    },
                    //Тексты предупреждений
                    messages: {
                        new_passwordConfirm: "Пароли не совпадают"
                    },
                    //Обработка и отправка данных
                    submitHandler: function () {
                        $.ajax({
                            url: '/InformationSystemWEB/main',
                            type: 'GET',
                            data: {request: 'create',
                                username: $("#new_username").attr("value"),
                                pass: $("#new_password").attr("value"),
                                role: $("#new_role option:selected").attr("value")},
                            success: function (result) {
                                if (result === "error") {
                                    $("#new_usernameError").text("Имя уже существует");
                                } else {

                                    $("#new_form").hide();
                                    $("#new_a").show();
                                    $("#users_list").show();
                                    $("#list_a").hide();

                                    var newRow = '<tr class="tr">' +
                                            '<td align="center"><input type="checkbox" id="usersCheckbox" value="' + result + '"></td>' +
                                            '<td align="center" class="name"><b>' + $("#new_username").attr("value") + '</b></td>' +
                                            '<td hidden="true" class="pass"><b>' + $("#new_password").attr("value") + '</b></td>' +
                                            '<td align="center" class="role"><b>' + $("#new_role option:selected").attr("value") + '</b></td>' +
                                            '</tr>';
                                    $("#table tbody").append(newRow);

                                    $("#new_username").attr("value", "");
                                    $("#new_password").attr("value", "");
                                    $("#new_passwordConfirm").attr("value", "");
                                }

                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert(errorThrown);
                            }
                        });
                    }
                });

                $("#new_username").rules("add", {
                    required: true,
                    minlength: 4,
                    correctUsername: true,
                    maxlength: 32,
                    messages: {
                        required: "Вы забыли про имя",
                        minlength: jQuery.validator.format("Имя должно содержать не менее {0} символов"),
                        maxlength: jQuery.validator.format("Имя должно содержать не более {0} символов")
                    }
                });
                $("#new_password").rules("add", {
                    required: true,
                    minlength: 4,
                    correctPassword: true,
                    maxlength: 16,
                    messages: {
                        required: "Вы забыли про пароль",
                        minlength: jQuery.validator.format("Пароль должен содержать не менее {0} символов"),
                        maxlength: jQuery.validator.format("Пароль должен содержать не более {0} символов")
                    }
                });
            });

            saveBtn = function () {
                $("#username").attr("value", $("#username").attr("value").trim());
            };

            createBtn = function () {
                $("#new_userbaname").attr("value", $("#new_userbaname").attr("value").trim());
            };
        </script>
        <style>
            #table {float: left;
                    padding-right: 10px;}
            #userData {float: left;
                       padding-right: 10px;}
            </style>
        </head>
        <body>
            <div style="background: #dcf2ff; max-width: 1024px; margin: 0 auto;">
            <header class="primary-header container group">
                <img src="/InformationSystemWEB/images/nc-logo.png" width="30%" align="center" class="logo">
                </img>
                <h1 class="tagline">Компания <%=name%></h1>

                <nav class="nav primary-nav">
                    <ul>
                        <li><a href="/InformationSystemWEB/index.jsp">Главная</a></li>
                        <li><a href="/InformationSystemWEB/pages/changePassword.jsp">Сменить пароль</a></li>
                        <li><a href="/InformationSystemWEB/pages/main.jsp">Список пользователей</a></li>
                        <!--
                        --><li><a href="/InformationSystemWEB/pages/changeCompany.jsp?companyID=<%=companyID%>">Изменить компанию</a></li><!--
                        --><li><a href="/InformationSystemWEB/pages/departmentTable.jsp">Список отделов</a></li><!--
                        --><li><a href="/InformationSystemWEB/pages/employeeTable.jsp">Список сотрудников</a></li><!--
                        --><li><a href="">Справка</a></li>
                    </ul>
                </nav>
                <a href="/InformationSystemWEB/logout">Выход</a>
            </header>

            <main>
                <section class="row">
                    <div id="users_list">

                        <h3>Пользователи системы</h3>
                        <table id="table" >
                            <% SecurityControllerDAO sec = SecurityControllerDAO.getInstance();
                                UserDAO userDAO = sec.getUserDAO();
                                RoleDAO roleDAO = sec.getRoleDAO();
                                Role roleComp = roleDAO.getRoleByName(String.valueOf(companyID)).get(0);
                                List<User> users = userDAO.getUserByRole(roleComp);
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
                                            } else if (r.getName().equals("owner")) {
                                                roleName = "owner";
                                                break;
                                            }
                                        }
                                        if (!roleName.equals("owner")) {
                                %>
                                <tr class="tr">
                                    <td align="center"><input type="checkbox" class="usersCheckbox" value="<%=u.getId()%>"></td>
                                    <td align="center" class="name"><b><%=u.getUsername()%></b></td>
                                    <td hidden="true" class="pass"><b><%=u.getPassword()%></b></td>
                                    <td align="center" class="role"><b><%=roleName%></b></td>
                                </tr>
                                <%}
                                    }%>
                            </tbody>
                        </table>

                        <form id="userData">
                            <h3>Данные пользователя</h3>
                            <input id="id" name="id" type="hidden"/>
                            <div>
                                <label>Логин:</label>
                                <input id="username" name="username" type="text"/>
                                <span id="nameError"></span>
                            </div>
                            <div>
                                <label>Пароль:</label>
                                <input id="password" name="password" type="text"/>

                            </div>
                            <div>
                                <label>Роль:</label>
                                <select id="role" name="role">
                                    <option id="opt_admin" value="admin">Администратор</option>
                                    <option id="opt_user" value="user">Пользователь</option>
                                </select>
                            </div>
                            <input type="submit" disabled id="save" value="Сохранить" onclick="saveBtn();"/>
                            <span id="result"></span>
                        </form>
                    </div>

                    <div id="new_form">
                        <form id="new_userData">
                            <h3>Данные пользователя</h3>
                            <div>
                                <label>Логин:</label>
                                <input id="new_username" name="new_username" type="text"/>
                                <span id="new_nameError"></span>
                            </div>
                            <div>
                                <label>Пароль:</label>
                                <input id="new_password" name="new_password" type="password"/>

                            </div>
                            <div>
                                <label>Подтвердите пароль:</label>
                                <input id="new_passwordConfirm" name="new_passwordConfirm" type="password"/>

                            </div>
                            <div>
                                <label>Роль:</label>
                                <select id="new_role" name="role">
                                    <option id="new_opt_admin" value="admin">Администратор</option>
                                    <option id="new_opt_user" value="user">Пользователь</option>
                                </select>
                            </div>
                            <input type="submit" id="create" value="Создать" onclick="createBtn();"/>
                            <span id="new_result"></span>
                        </form>

                    </div>
                </section>
            </main>

            <footer class="primary-footer container group">
                <nav class="navfoot">
                    <ul>
                        <li><a id="new_a">Добавить пользователя</a></li>
                        <li><a id="list_a">список пользователей</a></li>
                    </ul>
                </nav>
                <p style="text-align: center"> 2016 год</p>
            </footer>
        </header>
    </div>
</body>
</html>
