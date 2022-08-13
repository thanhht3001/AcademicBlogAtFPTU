<%-- 
    Document   : error
    Created on : May 31, 2022, 11:04:34 PM
    Author     : To Quyen Phan
--%>

<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error page</title>
        <link rel="stylesheet" href="CSS/oldstyle.css">
    </head>
    <body>
        <%
            String error = (String) request.getAttribute("ERROR");
            if(error == null){
                error = "Something wrong with website!";
            }
            UserDTO loginUser = (UserDTO)session.getAttribute("LOGIN_USER");
        %>
        <div class="error-page">
            <div class="content-error-page">
                <h1 data-text="OOPS!">OOPS!</h1>
                <h3><%= error %></h3>
                <a href="index.html">Return to welcome page</a>
            </div>
        </div>
    </body>
</html>
