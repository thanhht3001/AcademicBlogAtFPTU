<%-- 
    Document   : activity
    Created on : Jun 9, 2022, 1:33:47 PM
    Author     : To Quyen Phan
--%>

<%@page import="dto.UserDTO"%>
<%@page import="dto.ActivityDTO"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Activity Page</title>
        <link rel="stylesheet" href="fontawesome/css/all.min.css"> <!-- https://fontawesome.com/ -->
        <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet"> <!-- https://fonts.google.com/ -->
        <link href="CSS/bootstrap.min.css" rel="stylesheet">
        <link href="css/templatemo-xtra-blog.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/style.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <!--
            
        TemplateMo 553 Xtra Blog
        
        https://templatemo.com/tm-553-xtra-blog
        
        -->
    </head>
    <body class="body-activity-page">
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
        %>
        <header class="tm-header" id="tm-header">
            <div class="tm-header-wrapper">
                <button class="navbar-toggler" type="button" aria-label="Toggle navigation">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="tm-site-header">
                    <a href="profile.jsp">
                        <div class="mb-3 mx-auto tm-site-logo">
                            <img class="responsive" src="<%= image%>">

                        </div>            
                        <h2 class="text-center"><%= loginUser.getFullName()%></h2>
                    </a>
                </div>
                <nav class="tm-nav" id="tm-nav">            
                    <ul>
                        <li class="tm-nav-item"><a href="MainController?action=GetList" class="tm-nav-link">
                                <i class="fas fa-home"></i>
                                Blog Home
                            </a></li>
                        <li class="tm-nav-item active"><a href="#" class="tm-nav-link">
                                <i class="fas fa-tasks"></i>
                                Activity
                            </a></li>
                        <li class="tm-nav-item"><a href="post.html" class="tm-nav-link">
                                <i class="fas fa-users"></i>
                                Majors
                            </a></li>
                        <li class="tm-nav-item"><a href="about.html" class="tm-nav-link">
                                <i class="fas fa-users"></i>
                                Subjects
                            </a></li>
                        <li class="tm-nav-item"><a href="MainController?action=GetFeedbackTypeList" class="tm-nav-link">
                                <i class="far fa-comments"></i>
                                Feedback
                            </a></li>
                    </ul>
                </nav>
            </div>
        </header>
        <div class="container-fluid activity-page">
            <main class="tm-main activity-list">
                <!-- Search form -->
                <div class="row tm-row">
                    <div class="col-12 row">
                        <form class="form-inline tm-mb-80 tm-search-form col-sm-9 row" action="MainController" method="POST">                
                            <input class="form-control tm-search-input col-sm-9" name="searchName" type="text" placeholder="Search..." aria-label="Search">
                            <input type="hidden" name="userID" value="<%= loginUser.getUserID() %>">
                            <button class="tm-search-button col-sm-1" type="submit" name="action" value="PersonalSearch">
                                <i class="fas fa-search tm-search-icon" aria-hidden="true"></i>
                            </button>                                
                        </form>
                    </div>                
                </div> 
                <%
                    List<ActivityDTO> listAllActivities = (List<ActivityDTO>) request.getAttribute("LIST_ALL_ACTIVITY");
                    if (listAllActivities != null) {
                        if (listAllActivities.size() > 0) {
                            int all = listAllActivities.size();
                            int index = 0;
                            for (ActivityDTO activity : listAllActivities) {
                %>
                <div class="row tm-row activity-item">
                    <div class="row activity-item-header">
                        <h6 class="col-sm-12"><%= activity.getDate()%></h6>
                    </div>
                    <div class="row">
                        <h5 class="col-sm-11"><%= activity.getActivity()%></h5> 
                        <a onclick="showPopUp(<%= index%>, <%= all%>)" class="col-sm-1">Delete</a>
                    </div>  
                </div>
                <div class="delete-activity-message-popup-confirm" id="<%= index%>">
                    <p>Are you sure to delete this activity?</p>
                    <div>
                        <a href="MainController?action=DeleteActivity&historyActivityID=<%= activity.getHistoryActivityID()%>&userID=<%= activity.getUserID()%>">Delete</a>
                        <a onclick="closePopUpConfirm(<%= index%>, <%= all%>)">Cancel</a>
                    </div>
                </div>
                <%
                            index++;
                        }
                    }
                } else {
                    String message = (String) request.getAttribute("MESSAGE");
                    if (message == null) {
                        message = "";
                    }
                %>
                <div>
                    <h1><%= message%></h1>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                    <br>
                </div>
                <%
                    }
                %>
                <div class="row tm-row page-activity-list">
                    <div class="tm-prev-next-wrapper">
                        <a href="#" class="mb-2 tm-btn tm-btn-primary tm-prev-next disabled tm-mr-20">Prev</a>
                        <a href="#" class="mb-2 tm-btn tm-btn-primary tm-prev-next">Next</a>
                    </div>
                    <div class="tm-paging-wrapper">
                        <span class="d-inline-block mr-3">Page</span>
                        <nav class="tm-paging-nav d-inline-block">
                            <ul>
                                <li class="tm-paging-item active">
                                    <a href="#" class="mb-2 tm-btn tm-paging-link">1</a>
                                </li>
                                <li class="tm-paging-item">
                                    <a href="#" class="mb-2 tm-btn tm-paging-link">2</a>
                                </li>
                                <li class="tm-paging-item">
                                    <a href="#" class="mb-2 tm-btn tm-paging-link">3</a>
                                </li>
                                <li class="tm-paging-item">
                                    <a href="#" class="mb-2 tm-btn tm-paging-link">4</a>
                                </li>
                            </ul>
                        </nav>
                    </div>                
                </div>  
                <%
                    String deleteMessage = (String) request.getAttribute("DELETE_MESSAGE");
                    if (deleteMessage != null) {
                %>
                <div id="delete-activity-message-popup" style="display: block;">
                    <button onclick="closePopUp()" id="close-delete-activity-message-popup">X</button>
                    <p><%= deleteMessage%></p>
                </div>
                <%
                } else {
                %>
                <div id="delete-activity-message-popup" style="display: none;">
                    <button onclick="closePopUp()" id="close-delete-activity-message-popup">X</button>
                    <p><%= deleteMessage%></p>
                </div>
                <%
                    }
                %>
                <footer class="row tm-row">
                </footer>
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
