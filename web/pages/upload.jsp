<%-- 
    Document   : test.jsp
    Created on : Apr 5, 2016, 1:15:26 PM
    Author     : Alexey
--%>

<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
 <head>
    <meta charset="utf-8" />
    <title>Загрузка файла</title>
</head>
 <body>
     <%
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
     %>
  <form action="/InformationSystemWEB/UpLoadServlet" enctype="multipart/form-data" method="post">
   <p>Загрузите</p>
   <p><input type="file" name="xml">
   <input type="submit" value="Отправить"></p>
  </form>
 </body>
</html>
