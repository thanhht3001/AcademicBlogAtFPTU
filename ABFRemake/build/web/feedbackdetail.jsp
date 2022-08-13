<%-- 
    Document   : feedbackdetail
    Created on : Jun 18, 2022, 1:54:06 PM
    Author     : Bat
--%>

<%@page import="java.util.List"%>
<%@page import="dto.FeedbackTypeDTO"%>
<%@page import="dto.FeedbackDTO"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Feedback Details</title>
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
                        <li class="tm-nav-item"><a href="manageaccount.jsp" class="tm-nav-link">
                                <i class="fas fa-user-tie"></i>
                                Admin Dashboard
                            </a></li>
<!--                        <li class="tm-nav-item"><a href="MainController?action=GetActivityList&userID=<%= loginUser.getUserID()%>" class="tm-nav-link">
                                <i class="fas fa-tasks"></i>
                                Activity
                            </a></li>-->
                        <li class="tm-nav-item"><a href="MainController?action=GetMajorList" class="tm-nav-link">
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

        <div class="container-fluid activity-page">
            <main class="tm-main activity-list">
                <%
                    FeedbackDTO fb = (FeedbackDTO) request.getAttribute("FEEDBACK_DETAIL");
                    List<FeedbackTypeDTO> fb2 = (List<FeedbackTypeDTO>) request.getAttribute("FEEDBACK_TYPE");
                    UserDTO author = (UserDTO) request.getAttribute("FEEDBACK_AUTHOR");
                    if (fb != null)
                        if (fb2 != null)
                            if (author != null) {
                %>
                <input type="hidden" name="feedbackID" value="<%= fb.getFeedbackID()%>">
                <h2><%= author.getFullName()%></h2>
                <p><%= fb.getDescription()%></p> 
                <%
                    for (FeedbackTypeDTO a : fb2) {
                        if (a.getFeedbackTypeID() == fb.getFeedbackTypeID()) {
                %>
                <p><%= a.getFeedbackName()%></p>
                <%
                        }
                    }
                %>
                <p><%= fb.getDate()%></p>
                <% }%>
            </main>
        </div>
        <script>
            var time_in_sec = 0;
            var start_calling = '';
            function showPopUp(item, size) {
                for (var i = 0; i <= size; i++) {
                    if (i == item) {
                        document.getElementById(item).style.display = "block";
                    }
                }
            }
            function countdownTime() {
                time_in_sec++;
                html_tag.innerHTML = time_in_sec; // show time in html tag
                if (time_in_sec == 10) {
                    clearInterval(start_calling) // stop calling
                    ClosePopUp();
                }
            }
            function closePopUpConfirm(item, size) {
                for (var i = 0; i <= size; i++) {
                    if (i == item) {
                        document.getElementById(item).style.display = "none";
                    }
                }
            }

            function closePopUp() {
                document.getElementById('delete-activity-message-popup').style.display = 'none';
            }
        </script>
        <script src="js/jquery.min.js"></script>
        <script src="js/templatemo-script.js"></script>
    </body>
</html>