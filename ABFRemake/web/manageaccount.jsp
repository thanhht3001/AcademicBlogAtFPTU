<%-- 
    Document   : manageAccount
    Created on : Jun 19, 2022, 3:04:02 PM
    Author     : hotan
--%>

<%@page import="java.util.List"%>
<%@page import="dao.UserDAO"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link rel="stylesheet" href="fontawesome/css/all.min.css"> <!-- https://fontawesome.com/ -->
        <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet"> <!-- https://fonts.google.com/ -->
        <link href="CSS/bootstrap.min.css" rel="stylesheet">
        <link href="css/templatemo-xtra-blog.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/oldstyle.css">
        <link href="vendor/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="vendor/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
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
                    <a href="#">
                        <div class="mb-3 mx-auto tm-site-logo">
                            <img src="<%= image%>">

                        </div>            
                        <h2 class="text-center"><%= loginUser.getFullName()%></h2>
                    </a>
                </div>
                <nav class="tm-nav" id="tm-nav">            
                    <ul>
                        <li class="tm-nav-item active"><a href="#" class="tm-nav-link">
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
                <!-- Search form -->
                <div class="row tm-row">
                    <div class="col-12 row">
                        <form class="form-inline tm-mb-80 tm-search-form col-sm-10 row">                
                            <input class="form-control tm-search-input col-sm-10" name="query" type="text" placeholder="Search..." aria-label="Search">
                            <button class="tm-search-button col-sm-1" type="submit">
                                <i class="fas fa-search tm-search-icon" aria-hidden="true"></i>
                            </button>                                
                        </form>
                    </div>                
                </div> 

                <div class="row tm-row activity-item">
                    <div class="table-responsive">
                        <%
                            UserDAO dao = new UserDAO();
                            List<UserDTO> listAllUser = dao.getAllUser();
                            if (listAllUser.size() > 0) {


                        %>
                        <table class="table">
                            <thead class="bg-light">
                                <tr class="border-0" style="">
                                    <th class="border-0">No</th>                                    
                                    <th class="border-0">Full Name</th>
                                    <th class="border-0">Email</th> 
                                    <th class="border-0">Role</th>                                  
                                    <th class="border-0">Status</th> 
                                    <th class="border-0" style="text-align: center">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%  int count = 1;
                                    for (UserDTO user : listAllUser) {
                                        if (loginUser == null) {
                                            loginUser = new UserDTO();
                                        }
                                %>
                                <tr style="">                            
                                    <td><%= count++%></td>
                                    <td><%= user.getFullName()%></td>
                                    <td><%= user.getEmail()%></td>
                                    <%
                                        if (user.getRoleID() == 1) {
                                    %>
                                    <td>Admin</td>
                                    <%
                                    } else{
                                    %>
                                    <td>User</td>
                                    <% }

                                        if (user.isStatus() == true) {
                                    %>
                                    <td>Active</td>
                                    <% if (user.getRoleID() != 1) {%>
                                    <td class="ban-or-unban" style="text-align:center"><a href="MainController?action=UpdateStatusUser&userID=<%=user.getUserID()%>&oldStatus=<%=user.isStatus()%>">Ban</a></td>
                                    <%
                                        }
                                    } else {
                                    %>
                                    <td>InActive</td>   
                                    <% if (user.getRoleID() != 1) {%>
                                    <td class="ban-or-unban" style="text-align:center"><a href="MainController?action=UpdateStatusUser&userID=<%=user.getUserID()%>&oldStatus=<%=user.isStatus()%>">UnBan</a></td>
                                    <% }
                                                }
                                            }
                                        }
                                    %>

                                </tr>
                            </tbody>
                        </table>
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
        <script src="vendor/vendor/jquery/jquery.min.js"></script>
        <script src="vendor/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
        <script src="vendor/vendor/jquery-easing/jquery.easing.min.js"></script>
        <script src="vendor/vendor/datatables/jquery.dataTables.min.js"></script>
        <script src="vendor/vendor/datatables/dataTables.bootstrap4.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#dataTable').DataTable(); // ID From dataTable 
                $('#dataTableHover').DataTable(); // ID From dataTable with Hover
            });
        </script>
        <script src="js/jquery.min.js"></script>
        <script src="js/templatemo-script.js"></script>
    </body>
</html>
