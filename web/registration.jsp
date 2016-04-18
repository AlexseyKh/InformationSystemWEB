
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%session.setAttribute("companyID", null);%>
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

                $('#registration').validate(
                        {
                            //Правила
                            rules: {
                                username: "required",
                                pass: "required",
                                pass_confirm: {
                                    equalTo: "#pass"
                                }
                            },
                            //Тексты предупреждений
                            messages: {
                                username: "Заполните поле",
                                pass: "Заполните поле",
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
                $('#company').validate(
                        {
                            //Правила
                            rules: {
                                companyName: "required"
                            },
                            //Тексты предупреждений
                            messages: {
                                companyName: "Заполните поле"
                            },
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
            });

            back = function () {
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
                        --><li><a href="">Справка</a></li>
                    </ul>
                </nav>
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
                            <input type="submit" id="toCompany" value="Далее" />
                        </form>

                        <form id="company">
                            <h3>Данные компании</h3>
                            <div>
                                <label>Название компании:</label>
                                <input id="companyName" name="companyName" type="text"/>
                                <span class="error"></span>
                            </div>
                            <input type="submit" id="finish" value="Закончить" />
                        </form>
                        <button id="back" onclick="back();">Назад</button>
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
