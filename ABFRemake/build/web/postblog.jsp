<%-- 
    Document   : postBlog
    Created on : Jun 6, 2022, 12:54:48 AM
    Author     : hotan
--%>

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
        <title>Create New Blog</title>
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
        <nav class="nav approve-page" id="header">
            <form action="MainController" method="POST">
                <div class="nav-menu row">
                    <div class="nav-brand col-sm-2">
                        <a href="MainController?action=GetList" class="text-gray">Academic Blog</a>
                    </div>
                    <div class="approve-page toggle-collapse">
                        <div class="toggle-icons">
                            <i onclick="openNav();" class="fas fa-bars"></i>
                        </div>
                    </div>
                    <div class="nav-link-items col-sm-3">
                        <ul class="nav-items">
                            <li class="nav-link">
                                <a href="MainController?action=GetList">Home</a>
                            </li>
                            <li class="nav-link">
                                <a href="MainController?action=GetFeedbackTypeList">Feedback</a>
                            </li>
                            <li class="nav-link"><a href="MainController?action=MentorRegisterPage&userID=<%=loginUser.getUserID()%>" class="tm-nav-link">
                                    Registration
                                </a></li>  
                        </ul>
                    </div>
                    <div class="search-div col-sm-4">
                        <div class="search-form-search">
                            <input type="text" placeholder="Search..." name="search" type="text">
                            <div class="search-search"><button type="submit" name="action" value="Search"><i class="fas fa-search"></i></button></div>
                        </div>
                    </div>
                    <!--                    <div class="new col-sm-1"><a href="#"><i class="fas fa-pen"></i></a></div>-->

                    <div class="profile text-gray col-sm-3">
                        <div class="row">         
                            <a href="MainController?action=ViewProfile"><h6><%= loginUser.getFullName()%></h6></a>
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
                                    <a style="text-align: center;" href="MainController?action=ViewProfile">My profile</a>
                                </li>
                                <li>
                                    <a style="text-align: center;" href="MainController?action=ViewPersonalPage&userID=<%= loginUser.getUserID()%>">Blog List</a>
                                </li>
                                <%
                                    if (loginUser.getRoleID() == 3) {
                                %>
                                <li>
                                    <a style="text-align: center;" href="MainController?action=GetApproveList">Approve List</a>
                                </li>
                                <li>
                                    <a style="text-align: center;" href="MainController?action=ViewTopVote">Vote Ratings</a>
                                </li>
                                <%
                                    }
                                %>
                                <li>
                                    <a style="text-align: center;" href="MainController?action=Logout">Logout</a>
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
                                    String title = (String) request.getAttribute("TITLE");
                                    if (title == null) {
                                        title = "";
                                    }
                                    if (titleError == null) {
                                        titleError = "";
                                    }
                                %>
                                Title<input class="form-control" name="title" type="text" value="<%= title%>">
                                <h6><%= titleError%></h6>
                            </div>

                            <div class="mb-4">
                                Subject
                                <select name="subjectID" class="form-control" >
                                    <%
                                        ArrayList<SubjectDTO> listc = SubjectDAO.getSubject();
                                        if (listc != null && !listc.isEmpty()) {
                                            for (SubjectDTO c : listc) {
                                    %>
                                    <option value="<%=c.getSubjectID()%>"><%= c.getSubjectName()%> </option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                            </div>
                            <div class="mb-4">
                                <%
                                    String content = (String) request.getAttribute("CONTENT");
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
                                <%
                                    String imageError = blogError.getImageError();
                                    if (imageError == null) {
                                        imageError = "";
                                    }
                                %>
                                <form method="post" action="MainController" enctype="multipart/form-data">
                                    Image<input style="height: 3rem;" class="form-control" name="file" type="file">
                                    <h6><%= imageError%></h6>
                            </div>
                            <div class="text-right post-blog-form">
                                <input type="hidden" name="position" value="<%= position%>"/>
                                <input type="submit" name="action" value="Cancel"
                                       <button class="tm-btn tm-btn-primary tm-btn-small"></button>
                                <!--<input type="submit" name="action" value="SaveDraftBlog"
                                       <button class="tm-btn tm-btn-primary tm-btn-small"></button>-->

                                <input type="submit" name="action" value="Post"
                                       <button class="tm-btn tm-btn-primary tm-btn-small"></button>  
                            </div>
                        </form>

                    </div>
                </div>
                <footer class="footer">
                    <div class="container">
                        <div class="about-us" data-aos="fade-right" data-aos-delay="200">
                            <h2>About us</h2>
                            <p>ABF is a website for all students of FPT University, this is a place for students to learn, gather knowledge and share experiences about their major, especially their subject.</p>
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
                        <div class="newsletter" data-aos="fade-right" data-aos-delay="200">
                            <h4 class="text-gray">
                                Copyright ©2022 Team 4
                            </h4>
                        </div>
                    </div>
                    <div class="move-up">
                        <span><a href="#header"><i class="fas fa-arrow-circle-up fa-2x"></i></a></span>
                    </div>
                </footer>
            </main>
        </div>

        <script src="js/jquery.min.js"></script>
        <script src="js/templatemo-script.js"></script>
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
    </body>
</html>