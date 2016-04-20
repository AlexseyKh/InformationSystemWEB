
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Справочная система</title>
        <link rel="stylesheet" href="/InformationSystemWEB/css/main.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script> 
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,300,100&subset=cyrillic,latin">
        <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.js"></script>
        <script type="text/javascript">
            $('document').ready(function () {

                $('#form').validate({
                    //Правила
                    rules: {
                        passConfirm: {
                            equalTo: "#pass"
                        }
                    },
                    //Тексты предупреждений
                    messages: {
                        passConfirm: "Пароли не совпадают"
                    },
                    //Обработка и отправка данных
                    submitHandler: function () {
                        $.ajax({
                            url: '/InformationSystemWEB/changePassword',
                            type: 'GET',
                            data: {
                                oldPass: $("#oldPass").attr("value"),
                                pass: $("#pass").attr("value")},
                            success: function (result) {
                                if (result === "success") {
                                    $("#result").text("Пароль изменен!");
                                    $("#oldPass").attr("value", "");
                                    $("#pass").attr("value", "");
                                    $("#passConfirm").attr("value", "");
                                }
                                if (result === "error") {
                                    $("#result").text("Неверный старый пароль!");
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
                $("#oldPass").rules("add", {
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
            });
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
                        <li><a href="/InformationSystemWEB/pages/departmentTable.jsp">Список отделов</a></li><!--
                        --><li><a href="/InformationSystemWEB/pages/employeeTable.jsp">Список сотрудников</a></li>
                        <li><a href="">Справка</a></li>
                    </ul>
                </nav>
                <a href="/InformationSystemWEB/logout">Выход</a>
            </header>
            <main>
                <form id="form">
                    <fieldset>
                        <div>
                            <input id="oldPass" placeholder="Старый пароль" name="oldPass" type="password">
                        </div>
                        <div>
                            <input id="pass" placeholder="Новый пароль" name="pass" type="password" value="">
                        </div>
                        <div>
                            <input id="passConfirm" placeholder="Подтверждение пароля" name="passConfirm" type="password" value="">
                        </div>
                        <input type="submit" value="Сменить">
                        <span id="result"></span>
                    </fieldset>
                </form>

            </main>
            <footer class="primary-footer container group">
                <p style="text-align: center"> 2016 год</p>
            </footer>
        </header>
    </div>
</body>
</html>
