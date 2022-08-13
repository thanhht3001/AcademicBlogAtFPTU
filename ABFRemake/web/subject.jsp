<%-- 
    Document   : admin
    Created on : Jun 11, 2022, 9:16:11 AM
    Author     : To Quyen Phan
--%>

<%@page import="dto.SubjectDTO"%>
<%@page import="dto.MajorDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.List"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Subject Page</title>
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
                        <li class="tm-nav-item active"><a href="#" class="tm-nav-link">
                                <i class="fas fa-users"></i>
                                Subjects
                            </a></li>
                        <li class="tm-nav-item"><a href="MainController?action=GetFeedbackList" class="tm-nav-link">
                                <i class="far fa-comments"></i>
                                Feedback
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
                <!-- Search form -->
                <div class="row tm-row">
                    <div class="col-12 row">
                        <form class="form-inline tm-mb-80 tm-search-form col-sm-9 row" action="MainController">                
                            <input class="form-control tm-search-input col-sm-9" name="searchName" type="text" placeholder="Search..." aria-label="Search">
                            <button class="tm-search-button col-sm-1" type="submit" name="action" value="SearchSubjectByName">
                                <i class="fas fa-search tm-search-icon" aria-hidden="true"></i>
                            </button>                                
                        </form>
                        <a href="createsubject.jsp" class="tm-nav-link col-sm-3">
                            <i class="fas fa-pen"></i>
                            Create
                        </a>
                    </div>                
                </div>   
                <%
                    List<SubjectDTO> listAllSubjects = (List<SubjectDTO>) request.getAttribute("LIST_ALL_SUBJECTS");
                    if (listAllSubjects != null) {
                        if (listAllSubjects.size() > 0) {
                            int all = listAllSubjects.size();
                            int index = 0;
                            for (SubjectDTO subject : listAllSubjects) {
                %>
                <div class="row tm-row activity-item major-item">
                    <div class="row">
                        <h5 class="col-sm-8"><%= subject.getSubjectName() %></h5> 
                        <div class="col-sm-4 row">
                            <a class="col-sm-5" href="MainController?action=GoToEditSubject&subjectID=<%=subject.getSubjectID() %>" >Edit</a>
                            <a onclick="showPopUp(<%= index%>, <%= all%>)" class="col-sm-5">Deactivate</a>
                        </div>
                    </div>  
                </div> 
                <div class="delete-activity-message-popup-confirm" id="<%= index%>">
                    <p>Are you sure to delete this activity?</p>
                    <div>
                        <a href="MainController?action=DeleteSubject&subjectID=<%= subject.getSubjectID() %>">Deactivate</a>
                        <a onclick="closePopUpConfirm(<%= index%>, <%= all%>)">Cancel</a>
                    </div>
                </div>
                <%
                            index++;
                        }
                    }
                } else {
                %>
                <h1>Empty</h1>
                <%
                    }
                %>

                <div class="row tm-row tm-mt-100 tm-mb-75">
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
            function showPopUp(item, size) {
                for (var i = 0; i <= size; i++) {
                    if (i == item) {
                        document.getElementById(item).style.display = "block";
                    }
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
