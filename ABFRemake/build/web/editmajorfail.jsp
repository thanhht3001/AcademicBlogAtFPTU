<%-- 
    Document   : editmajor
    Created on : Jul 27, 2022, 3:38:43 AM
    Author     : Bat
--%>

<%@page import="dto.MajorDTO"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Major Page</title>
        <link rel="stylesheet" href="fontawesome/css/all.min.css"> <!-- https://fontawesome.com/ -->
        <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet"> <!-- https://fonts.google.com/ -->
        <link href="CSS/bootstrap.min.css" rel="stylesheet">
        <link href="css/templatemo-xtra-blog.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/oldstyle.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <!--
            
        TemplateMo 553 Xtra Blog
        
        https://templatemo.com/tm-553-xtra-blog
        
        -->
    </head>
    <body class="body-homepage">
        <%
            //Hiển thị Full Name của user
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                loginUser = new UserDTO();
            }
            String image = loginUser.getImage();
            if (image == null) {
                image = "image/0c3b3adb1a7530892e55ef36d3be6cb8 (1).png";
            }
        %>
        <header class="tm-header" id="tm-header">
            <div class="tm-header-wrapper">
                <button class="navbar-toggler" type="button" aria-label="Toggle navigation">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="tm-site-header">
                    <a href="profile.jsp">
                        <div class="mb-3 mx-auto tm-site-logo">
                            <img src="<%= image%>">

                        </div>            
                        <h2 class="text-center"><%= loginUser.getFullName()%></h2>
                    </a>
                </div>
                <nav class="tm-nav" id="tm-nav">            
                    <ul>
                        <li class="tm-nav-item"><a href="admin.jsp" class="tm-nav-link">
                                <i class="fas fa-user-tie"></i>
                                Admin Dashboard
                            </a></li>
<!--                        <li class="tm-nav-item"><a href="MainController?action=GetActivityList&userID=<%= loginUser.getUserID()%>" class="tm-nav-link">
                                <i class="fas fa-tasks"></i>
                                Activity
                            </a></li>-->
                        <li class="tm-nav-item active"><a href="MainController?action=GetMajorList" class="tm-nav-link">
                                <i class="fas fa-users"></i>
                                Majors
                            </a></li>
                        <li class="tm-nav-item"><a href="MainController?action=GetSubjectList" class="tm-nav-link">
                                <i class="fas fa-users"></i>
                                Subjects
                            </a></li>
                        <li class="tm-nav-item"><a href="MainController?action=ManageRegistration" class="tm-nav-link">
                                <i class="fa fa-user-plus"></i>
                                Registrations
                            </a></li>
                        <li class="tm-nav-item"><a href="MainController?action=GetFeedbackList" class="tm-nav-link">
                                <i class="far fa-comments"></i>
                                Feedbacks
                            </a></li>
                        <li class="tm-nav-item"><a href="MainController?action=Logout" class="tm-nav-link">
                                <i class="fas fa-sign-out-alt"></i>
                                Logout
                            </a></li>
                    </ul>
                </nav>
            </div>
        </header>
        <div class="container-fluid">
            <main class="tm-main">
                <div class="row tm-row">
                    <div class="col-12">
                        <hr class="tm-hr-primary tm-mb-45">
                        <form action="MainController" method="POST" name="f">
                            <input type="hidden" name="userID" value="<%=loginUser.getUserID()%>" readonly="">                      
                            <div class="mb-4">                   

                                <%
                                    int majorID = 0;
                                    majorID = (Integer) request.getAttribute("MAJORID");
                                    String majorName = (String) request.getAttribute("MAJORNAME");
                                    if (majorName == null || majorName.trim().length() == 0) {
                                        majorName = "";
                                    }
                                    if (majorID != 0) {%>
                            </div>
                            <div class="mb-4">
                                <input type="hidden" name="majorID" value="<%= majorID%>">
                                Major Name: <input class="form-control" name="majorName" type="text" value="<%= majorName%>">                             
                                <div style="color: red"><%= (request.getAttribute("MAJOR_INVALID") == null) ? "" : request.getAttribute("MAJOR_INVALID")%> </div>
                                <div style="color: red"><%= (request.getAttribute("DOUBLE_MAJOR") == null) ? "" : request.getAttribute("DOUBLE_MAJOR")%> </div>
                            </div>                           
                            <div class="text-right">
                                <input type="submit" name="action" value="Save Major" 
                                       <button class="tm-btn tm-btn-primary tm-btn-small"></button>                        
                            </div>    
                            <% }
                            %>


                        </form>
                    </div>
                </div>
                <footer class="row tm-row">
                    <div class="col-md-6 col-12 tm-color-gray">
                        FPT University
                    </div>
                    <div class="col-md-6 col-12 tm-color-gray tm-copyright">
                        ACADEMIC BLOG
                    </div>

                </footer>
            </main>
        </div>
        <footer class="row tm-row">
        </footer>
    </main>
</div>
<script src="js/jquery.min.js"></script>
<script src="js/templatemo-script.js"></script>
</body>
</html>