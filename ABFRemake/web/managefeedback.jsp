<%-- 
    Document   : ManageFeedback
    Created on : Jun 18, 2022, 12:43:18 AM
    Author     : Bat
--%>

<%@page import="dto.FeedbackTypeDTO"%>
<%@page import="java.util.List"%>
<%@page import="dto.FeedbackDTO"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Manage Feedback Page</title>
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
                        <li class="tm-nav-item active"><a href="#" class="tm-nav-link">
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
                <!-- Search form -->
                <div class="row tm-row">
                    <div class="col-12 row">
                        <form class="form-inline tm-mb-80 tm-search-form col-sm-9 row" action="MainController">                
                            <input class="form-control tm-search-input col-sm-9" name="searchName" type="text" placeholder="Search..." aria-label="Search">
                            <button class="tm-search-button col-sm-1" type="submit" name="action" value="SearchFeedbackByName">
                                <i class="fas fa-search tm-search-icon" aria-hidden="true"></i>
                            </button>                                
                        </form>
                    </div>                
                </div> 
                <%
                    List<FeedbackDTO> listfeedback = (List<FeedbackDTO>) request.getAttribute("LIST_FEEDBACKS");
                    List<FeedbackTypeDTO> listfbType = (List<FeedbackTypeDTO>) request.getAttribute("LIST_FEEDBACK_TYPES");
                    List<UserDTO> user = (List<UserDTO>) request.getAttribute("AUTHOR");
                    if (listfeedback != null) {
                        if (listfeedback.size() > 0) {
                            int all = listfeedback.size();
                            int index = 0;
                            for (FeedbackDTO fb : listfeedback) {
                %>
                <div class="row tm-row activity-item">
                    <div class="row  col-md-10">  
                        <div>
                            <%
                                for (FeedbackTypeDTO a : listfbType) {
                                    if (a.getFeedbackTypeID() == fb.getFeedbackTypeID()) {
                            %>
                            <a href="MainController?action=FeedbackDetail&feedbackID=<%= fb.getFeedbackID()%>">
                                <%= a.getFeedbackName()%>
                            </a>
                            <%
                                    }
                                }
                            %> 
                        </div>
                        <div>
                            <%    for (UserDTO u : user)
                                    if (u.getUserID() == fb.getUserID()) {
                            %>
                            <h6><%= u.getFullName()%></h6>
                            <% }%>
                        </div>
                    </div>
                    <div class="col-md-0">
                        <!-- Them o day 
                            nếu thêm thì sửa chỉ số cột lại
                        -->
                    </div>
                    <div class="col-md-2">
                        <h6 class="col-sm-12"><%= fb.getDate()%></h6>
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
                    <h1>Empty!</h1>
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


