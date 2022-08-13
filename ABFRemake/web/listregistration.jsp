<%-- 
    Document   : listregistration
    Created on : Jul 12, 2022, 10:00:17 PM
    Author     : Bat
--%>

<%@page import="dto.FeedbackDTO"%>
<%@page import="dto.RegistrationDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.RegistrationDAO"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%
    //check co parameter warning=thanhcong nhan dc tu trang addtocart
    String msq = request.getParameter("notiRegis");
    String msq2 = request.getParameter("notiRegis2");
    if (msq != null) {
%>
<script>
    alert("Registration has been approve");
</script>
<%
    }
    if (msq2 != null) {
%>    
<script>
    alert("Registration has been reject");
</script>
<%
    }
%>--%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Manage Account</title>
        <link rel="stylesheet" href="fontawesome/css/all.min.css"> <!-- https://fontawesome.com/ -->
        <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet"> <!-- https://fonts.google.com/ -->
        <link href="CSS/bootstrap.min.css" rel="stylesheet">
        <link href="css/templatemo-xtra-blog.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/oldstyle.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
    </head>

    <body id="page-top" class="body-homepage">
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
                        <li class="tm-nav-item"><a href="MainController?action=GetActivityList&userID=<%= loginUser.getUserID()%>" class="tm-nav-link">
                                <i class="fas fa-tasks"></i>
                                Activity
                            </a></li>
                        <li class="tm-nav-item"><a href="MainController?action=GetMajorList" class="tm-nav-link">
                                <i class="fas fa-users"></i>
                                Majors
                            </a></li>
                        <li class="tm-nav-item"><a href="MainController?action=GetSubjectList" class="tm-nav-link">
                                <i class="fas fa-users"></i>
                                Subjects
                            </a></li>
                        <li class="tm-nav-item active"><a href="#" class="tm-nav-link">
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
                <div id="wrapper">
                    <!-- Sidebar -->
                    <div id="content-wrapper" class="d-flex flex-column">
                        <div id="content"><h1>List Registration</h1> 
                            <div class="container-fluid" id="container-wrapper">

                                <div class="row">
                                    <div class="col-lg-12">                                      
                                        <div class="card mb-4">
                                            <%
                                                List<RegistrationDTO> list = (List<RegistrationDTO>) request.getAttribute("LIST_REGISTRATION");
                                                int count = 1;
                                                if (list != null)
                                                    if (list.size() > 0) {
                                            %>
                                            <table class="table align-items-center table-flush" id="dataTable">
                                                <thead class="thead-light">
                                                    <tr>
                                                        <th class="border-0">No</th>       
                                                        <th class="border-0">Email</th>
                                                        <th class="border-0">Subject</th>
                                                        <th class="border-0">Action</th> 
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (RegistrationDTO regis : list) {
                                                    %>
                                                    <tr>
                                                        <td><%= count++%></td>                                           
                                                        <td><%= regis.getEmail()%></td>    
                                                        <td><%= regis.getSubjectName()%></td> 
                                                        <td><a style=" background-color: white; color: blue;" href="MainController?action=RegistrationDetail&registrationID=<%=regis.getRegistrationID()%>">Detail</a>
                                                        </td>
                                                        <%
                                                            }
                                                        %>                                               
                                                    </tr>
                                                </tbody>
                                            </table>
                                            <%
                                            } else if (count == 0) {
                                            %>
                                            <h2>Don't have any Registration</h2>
                                            <%
                                                    }
                                            %>

                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </main>
        </div>        
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable(); // ID From dataTable 
                $('#dataTableHover').DataTable(); // ID From dataTable with Hover
            });
        </script>
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
