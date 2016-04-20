
<%@page import="org.apache.shiro.SecurityUtils"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%SecurityUtils.getSubject().getSession().setAttribute("companyID", null);%>
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
                $("#company").hide();
                $("#back").hide();


                $('#registration').validate({
                    //Правила
                    rules: {
                        pass_confirm: {
                            equalTo: "#pass"
                        }
                    },
                    //Тексты предупреждений
                    messages: {
                        pass_confirm: "Пароли не совпадают"
                    },
                    //Обработка и отправка данных
                    submitHandler: function () {
                        $.ajax({
                            url: '/InformationSystemWEB/registration',
                            type: 'GET',
                            data: {request: 'toCompany',
                                username: $("#username").attr("value"),
                                pass: $("#pass").attr("value")},
                            success: function (result) {
                                if (result === "success") {
                                    $("#registration").hide();
                                    $("#company").show();
                                    $("#back").show();
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
                jQuery.validator.addMethod("correctPassword", function (value, element) {
                    return /([a-zA-Z0-9]{4,16})/.test(value);
                }, 'Пароль должен состоять только из латинских букв и цифр');
                $("#pass").rules("add", {
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
                jQuery.validator.addMethod("correctUsername", function (value, element) {
                    return /([_a-zA-Z][_a-zA-Z0-9 ]{3,31})/.test(value);
                }, "Имя должно начинаться с латинской буквы или символа '_' и состоять из них же или цифр и пробелов");
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







                $('#company').validate({
                    //Обработка и отправка данных
                    submitHandler: function () {
                        $.ajax({
                            url: '/InformationSystemWEB/registration',
                            type: 'GET',
                            data: {request: 'finish',
                                companyName: $("#companyName").attr("value")},
                            success: function (result) {
                                if (result === "success") {
                                    document.location.href = "/InformationSystemWEB/pages/main.jsp";
                                }
                                if (result === "error") {
                                    $("#error").text("Название уже существует");
                                }
                            },
                            error: function (jqXHR, textStatus, errorThrown) {
                                alert(errorThrown);
                            }
                        });
                    }
                });


                jQuery.validator.addMethod("correctCompName", function (value, element) {
                    return /([a-zA-Z0-9][a-zA-Z0-9 ]{0,30})/.test(value);
                }, "Название должно состоять из латинских букв, цифр и пробелов");

                $("#companyName").rules("add", {
                    required: true,
                    correctCompName: true,
                    maxlength: 32,
                    messages: {
                        required: "Вы забыли про название",
                        maxlength: jQuery.validator.format("Имя должно содержать не более {0} символов")
                    }
                });
            });



            nextBtn = function () {
                $("#username").attr("value", $("#username").attr("value").trim());
            };
            
            finishBtn = function () {
                $("#companyName").attr("value", $("#companyName").attr("value").trim());
            };


            backBtn = function () {
                $("#company").hide();
                $("#registration").show();
                $("#back").hide();
            }
        </script>
    </head>
    <body>
        <div style="background: #dcf2ff; max-width: 1024px; margin: 0 auto;">
            <header class="primary-header container group">
                <img src="/InformationSystemWEB/images/nc-logo.png" width="30%" align="center" class="logo">
                </img>
                <h1 class="tagline">Справочная система</h1>
                <nav class="nav primary-nav">
                    <ul>
                        <li><a href="/InformationSystemWEB/index.jsp">Главная</a></li><!--
                        --><shiro:hasRole name="owner">
                            <li><a href="/InformationSystemWEB/pages/main.jsp">Список пользователей</a></li>
                            </shiro:hasRole>
                            <shiro:authenticated>
                            <li><a href="/InformationSystemWEB/pages/departmentTable.jsp">Список отделов</a></li><!--
                            --><li><a href="/InformationSystemWEB/pages/employeeTable.jsp">Список сотрудников</a></li>
                            </shiro:authenticated>
                        <li><a href="">Справка</a></li>
                    </ul>
                </nav>
                <shiro:authenticated>
                    <a href="/InformationSystemWEB/logout">Выход</a>
                </shiro:authenticated>
            </header>

            <main>
                <section class="row">
                    <div id="form_wrapper" class="form_wrapper">

                        <form id="registration">
                            <h3>Данные пользователя</h3>
                            <div>
                                <label>Логин:</label>
                                <input id="username" name="username" type="text" value=""/>
                                <span id="usernameError"></span>
                            </div>
                            <div>
                                <label>Пароль:</label>
                                <input id="pass" name="pass" type="password" value=""/>
                            </div>
                            <div>
                                <label>Подтверждение пароля:</label>
                                <input id="pass_confirm" name="pass_confirm" type="password" />
                            </div>
                            <input type="submit" id="toCompany" value="Далее"  onclick="nextBtn();"/>
                        </form>

                        <form id="company">
                            <h3>Данные компании</h3>
                            <div>
                                <label>Название компании:</label>
                                <input id="companyName" name="companyName" type="text"/>
                                <span id="error"></span>
                            </div>
                            <input type="submit" id="finish" value="Закончить" onclick="finishBtn();"/>
                        </form>
                        <button id="back" onclick="backBtn();">Назад</button>
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
