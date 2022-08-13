<%-- 
    Document   : profile
    Created on : Jun 6, 2022, 10:38:28 PM
    Author     : To Quyen Phan
--%>

<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
  <head>
    <title>Profile Page</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="CSS/oldstyle.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
  </head>
  <body>
      <%
          UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
          String dateOfBirth = loginUser.getDateOfBirth();
          if(dateOfBirth == null){
              dateOfBirth = "...";
          }
          String gender = loginUser.getGender();
          if(gender == null){
              gender = "...";
          }
          String address = loginUser.getAddress();
          if(address == null){
              address = "...";
          }
          String contact = loginUser.getContact();
          if(contact == null){
              contact = "...";
          }
          String aboutme = loginUser.getAboutme();
          if(aboutme == null){
              aboutme = "...";
          }
          String image = loginUser.getImage();
          if(image == null){
              image = "image/0c3b3adb1a7530892e55ef36d3be6cb8 (1).png";
          }
      %>
    <div class="container-profile-page row">
        <div class="wrapper-profile-page col-sm-4">
            <img src="<%= image %>">
            <h1><%= loginUser.getFullName() %></h1>
            <h4><%= loginUser.getNumberOfBlogs() %> blogs</h4>
            <a href="MainController?action=GetList"><i class='far fa-arrow-alt-circle-left'></i></a>
        </div>
        <div class="content-profile-page">
          <h2>Date Of Birth: <%= dateOfBirth %></h2>
          <h2>Gender: <%= gender %></h2>
          <h2>Email:<%= loginUser.getEmail() %></h2>
          <h2>Address: <%= address %></h2>
          <h2>Contact: <%= contact %></h2>
          <h2>About me: <%= aboutme %></h2>
          <a href="index.html"><i class='fas fa-edit'></i></a>
        </div>
      </div>
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
  </body>
</html>