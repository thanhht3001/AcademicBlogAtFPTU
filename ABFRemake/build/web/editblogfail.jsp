<%-- 
    Document   : editBlog
    Created on : Jun 3, 2022, 10:08:21 PM
    Author     : Bat
--%>
<%@page import="dto.BlogDTO"%>
<%@page import="dao.SubjectDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dto.SubjectDTO"%>
<%@page import="java.util.List"%>
<%@page import="dto.BlogError"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Blog</title>
        <link rel="stylesheet" href="fontawesome/css/all.min.css"> <!-- https://fontawesome.com/ -->
        <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet"> <!-- https://fonts.google.com/ -->
        <link href="CSS/bootstrap.min.css" rel="stylesheet">
        <link href="CSS/templatemo-xtra-blog.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/style.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <!--
            
        TemplateMo 553 Xtra Blog
        
        https://templatemo.com/tm-553-xtra-blog
        
        -->
    </head>
    <body class="body-postblog-page">
        <%
            //Hiển thị Full Name của user
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                loginUser = new UserDTO();
            }
            String search = request.getParameter("search");
            if (search == null) {
                search = "";
            }
            String image = loginUser.getImage();
            if (image == null) {
                image = "image/0c3b3adb1a7530892e55ef36d3be6cb8 (1).png";
            }
            BlogError blogError = (BlogError) request.getAttribute("BLOG_ERROR");
            if (blogError == null) {
                blogError = new BlogError();
            }

            String position = request.getParameter("position");
        %>
        <nav class="nav" id="header">
            <form action="MainController" method="POST">
                <div class="nav-menu row">
                    <div class="nav-brand">
                        <a href="MainController?action=GetList" class="text-gray">Academic Blog</a>
                    </div>
                    <div onclick="openNav();" class="toggle-collapse">
                        <div class="toggle-icons">
                            <i class="fas fa-bars"></i>
                        </div>
                    </div>
                    <div class="">
                        <ul class="nav-items">
                            <li class="nav-link">
                                <a href="MainController?action=GetList">Home</a>
                            </li>
                            <li class="nav-link">
                                <a href="MainController?action=GetFeedbackTypeList">Feedback</a>
                            </li>
                        </ul>
                    </div>
                    <div class="new col-sm-3"><a href="#"><i class="fas fa-pen"></i></a></div>
                    <div class="profile text-gray col-sm-3">
                        <div class="row">         
                            <a><h6><%= loginUser.getFullName()%></h6></a>
                            <img onclick="menuToggle();" src="<%= image%>">
                        </div>
                    </div>
                </div>
            </form>
        </nav>
        <div>
            <main class="tm-main">
                <!-- Search form -->

                <div class="row tm-row">
                    <div class="col-12">
                        <div class="menu">
                            <ul>
                                <li>
                                    <a href="profile.jsp">My profile</a>
                                </li>
                                <li>
                                    <a href="MainController?action=ViewPersonalPage&userID=<%= loginUser.getUserID()%>">Blog List</a>
                                </li>
                                <%
                                    if (loginUser.getRoleID() == 3) {
                                %>
                                <li>
                                    <a href="MainController?action=GetApproveList">Approve List</a>
                                </li>
                                <%
                                    }
                                %>
                                <li>
                                    <a href="MainController?action=Logout">Logout</a>
                                </li>
                            </ul>
                        </div>
                        <hr class="tm-hr-primary tm-mb-45">
                        <form action="MainController" method="POST" enctype="multipart/form-data">
                            <h2 class="tm-color-primary tm-post-title mb-4">Your Post</h2>
                            <input type="hidden" name="userID" value="<%=loginUser.getUserID()%>" readonly="">

                            <div class="mb-4">

                                <%
                                    String titleError = blogError.getTitleError();
                                    int blogId = (Integer) request.getAttribute("BLOGID");
                                    int subjectID = (Integer) request.getAttribute("SUBJECTID");
                                    String title = (String) request.getAttribute("TITLE");
                                    if (titleError == null) {
                                        titleError = "";
                                    }
                                    if (title == null) {
                                        title = "";
                                    }
                                %>
                                Title<input class="form-control" name="title" type="text" value="<%= title%>">
                                <h6><%= titleError%></h6>                                                           
                            </div>
                            <input type="hidden" name="blogID" value="<%= blogId%>">
                            <div class="mb-4">
                                Subject
                                <select name="subjectID" class="form-control" >
                                    <%  ArrayList<SubjectDTO> listc = SubjectDAO.getSubject();
                                        if (listc != null && !listc.isEmpty()) {
                                            for (SubjectDTO c : listc) {
                                                if (c.getSubjectID() == subjectID) {

                                    %>
                                    <option value="<%=c.getSubjectID()%>" selected="<%=c.getSubjectID()%>"><%= c.getSubjectName()%> </option>
                                    <% } else {%>
                                    <option value="<%=c.getSubjectID()%>"><%= c.getSubjectName()%> </option>
                                    <% }
                                            }
                                        }

                                    %>
                                </select>
                            </div>
                            <div class="mb-4">
                                <%  String content = (String) request.getAttribute("CONTENT");
                                    if (content == null) {
                                        content = "";
                                    }
                                %>
                                Details<textarea class="form-control" name="content" rows="6"><%= content%></textarea>
                                <%
                                    String contentError = blogError.getContentError();
                                    if (contentError == null) {
                                        contentError = "";
                                    }
                                %>
                                <h6><%= contentError%></h6>
                            </div>
                            <div class="mb-4">
                                <form method="post" action="MainController" enctype="multipart/form-data">
                                    <%
                                        String imageError = blogError.getImageError();
                                        if (imageError == null) {
                                            imageError = "";
                                        }

                                    %>
                                    Image<input class="form-control" name="file" type="file">                                                                                        
                                    <h6><%= imageError%></h6>
                            </div>
                            <div class="text-right post-blog-form">
                                <input type="hidden" name="position" value="<%= position%>"/>
                                <input type="submit" name="action" value="Cancel"
                                       <button class="tm-btn tm-btn-primary tm-btn-small"></button>
                                <!--<input type="submit" name="action" value="SaveDraftBlog"
                                       <button class="tm-btn tm-btn-primary tm-btn-small"></button>-->

                                <input type="submit" name="action" value="Edit"
                                       <button class="tm-btn tm-btn-primary tm-btn-small"></button>  
                            </div>
                        </form>

                    </div>
                </div>
                <footer class="footer">
                    <div class="container">
                        <div class="about-us" data-aos="fade-right" data-aos-delay="200">
                            <h2>About us</h2>
                            <p>Lorem ipsum dolor sit amet consectetur adipisicing elit. Accusantium quia atque nemo ad modi officiis
                                iure, autem nulla tenetur repellendus.</p>
                        </div>
                        <div class="newsletter" data-aos="fade-right" data-aos-delay="200">
                            <h2>Newsletter</h2>
                            <p>Stay update with our latest</p>
                            <div class="form-element">
                                <input type="text" placeholder="Email"><span><i class="fas fa-chevron-right"></i></span>
                            </div>
                        </div>
                        <div class="instagram" data-aos="fade-left" data-aos-delay="200">
                            <h2>Instagram</h2>
                            <div class="flex-row">
                                <img src="./assets/instagram/thumb-card3.png" alt="insta1">
                                <img src="./assets/instagram/thumb-card4.png" alt="insta2">
                                <img src="./assets/instagram/thumb-card5.png" alt="insta3">
                            </div>
                            <div class="flex-row">
                                <img src="./assets/instagram/thumb-card6.png" alt="insta4">
                                <img src="./assets/instagram/thumb-card7.png" alt="insta5">
                                <img src="./assets/instagram/thumb-card8.png" alt="insta6">
                            </div>
                        </div>
                        <div class="follow" data-aos="fade-left" data-aos-delay="200">
                            <h2>Follow us</h2>
                            <p>Let us be Social</p>
                            <div>
                                <i class="fab fa-facebook-f"></i>
                                <i class="fab fa-twitter"></i>
                                <i class="fab fa-instagram"></i>
                                <i class="fab fa-youtube"></i>
                            </div>
                        </div>
                    </div>
                    <div class="rights flex-row">
                        <h4 class="text-gray">
                            Copyright ©2019 All rights reserved | made by
                            <a href="www.youtube.com/c/dailytuition" target="_black">Daily Tuition <i class="fab fa-youtube"></i>
                                Channel</a>
                        </h4>
                    </div>
                    <div class="move-up">
                        <span><a href="#header"><i class="fas fa-arrow-circle-up fa-2x"></i></a></span>
                    </div>
                </footer>
            </main>
        </div>
        <script>
            function menuToggle() {
                const toggleMenu = document.querySelector(".menu");
                toggleMenu.classList.toggle("active2");
            }

            function openNav() {
                if (document.getElementById('header').style.height === '15rem') {
                    document.getElementById('header').style.height = '4rem'
                } else {
                    document.getElementById('header').style.height = '15rem'
                }

            }

        </script>
        <script src="js/jquery.min.js"></script>
        <script src="js/templatemo-script.js"></script>
    </body>
</html>