<%-- 
    Document   : voterating
    Created on : Jun 19, 2022, 3:50:18 PM
    Author     : hotan
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="dao.BlogDAO"%>
<%@page import="dto.BlogDTO"%>
<%@page import="java.util.List"%>
<%@page import="dao.UserDAO"%>
<%@page import="dto.UserDTO"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Vote Rating</title>
        <link rel="stylesheet" href="fontawesome/css/all.min.css"> <!-- https://fontawesome.com/ -->
        <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet"> <!-- https://fonts.google.com/ -->
        <link href="CSS/bootstrap.min.css" rel="stylesheet">
        <link href="css/templatemo-xtra-blog.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/style.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <link href="../vendor/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
        <link href="../vendor/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css">
        <link href="../vendor/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    </head>

    <body id="page-top" class="body-homepage">
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
            String giveAward = (String) request.getAttribute("GIVE_AWARD");
            List<BlogDTO> listPopularBlogs = new ArrayList<>();
            if (giveAward == null) {
                listPopularBlogs = (List<BlogDTO>) session.getAttribute("LIST_POPULAR_BLOGS");
            } else {
                listPopularBlogs = (List<BlogDTO>) request.getAttribute("LIST_POPULAR_BLOGS");
            }
//            BlogNotify blogNotify = (BlogNotify) request.getAttribute("GIVE_AWARD");
//            if (blogNotify == null) {
//                blogNotify = new BlogNotify();
//            }
        %>
        <nav style="margin-bottom: 3rem;" class="nav approve-page" id="header">
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
                    <div class="search-div col-sm-3">
                        <div class="search-form-search">
                            <input type="text" placeholder="Search..." name="search" type="text">
                            <div class="search-search"><button type="submit" name="action" value="Search"><i class="fas fa-search"></i></button></div>
                        </div>
                    </div>
                    <div class="new col-sm-1"><a href="MainController?action=GoToPostBlogPage&position=homepage.jsp"><i class="fas fa-pen"></i></a></div>

                    <div class="profile text-gray col-sm-3">
                        <div class="row">         
                            <a href="MainController?action=ViewProfile"><h6><%= loginUser.getFullName()%></h6></a>
                            <img onclick="menuToggle();" src="<%= image%>">
                        </div>
                    </div>
                </div>
            </form>
        </nav>
        <h1 style="text-align: center; top: 5rem;">Top Vote</h1>
        <main class="tm-main activity-list">   
            <div class="container-fluid activity-page">
                <div id="wrapper">
                    <!-- Sidebar -->
                    <div id="content-wrapper" class="d-flex flex-column">
                        <div id="content">
                            <div class="container-fluid" id="container-wrapper">
                                <div class="row">
                                    <div class="col-lg-12">
                                        <div class="card mb-4">
                                            <div class="table-responsive p-3">
                                                <%
                                                    BlogDAO dao = new BlogDAO();
                                                    int blogID = 0;
                                                    if (listPopularBlogs != null) {
                                                        if (listPopularBlogs.size() > 0) {
                                                %>                                                
                                                <table class="table align-items-center table-flush" id="dataTable">
                                                    <thead class="thead-light">
                                                        <tr>
                                                            <th class="border-0">#</th>
                                                            <th class="border-0">Title</th>
                                                            <th class="border-0">By</th>                                   
                                                            <th class="border-0">Date</th>
                                                            <th style="text-align: center;" class="border-0">Number of vote</th>
                                                            <th style="text-align: center;" class="border-0">Awards</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%  int count = 1;
                                                            int index = 0;
                                                            for (BlogDTO blog : listPopularBlogs) {
                                                                if (loginUser == null) {
                                                                    loginUser = new UserDTO();
                                                                }

                                                        %>
                                                        <tr>
                                                            <td><%= count++%></td>
                                                            <td><a class="title-blog-vote" href="MainController?action=ViewBlogDetails&blogID=<%= blog.getBlogID()%>"><%= blog.getTitle()%></a></td>
                                                            <td><%= blog.getFullName()%></td>
                                                            <td><%= blog.getDate()%></td>
                                                            <td style="text-align: center;"><%= blog.getNumberOfVotes()%></td>

                                                            <td style="text-align: center;">
                                                                <%
                                                                    if (blog.getAward() == 0) {
                                                                %>
                                                                <button onclick="showPopUp(<%= index%>, <%= listPopularBlogs.size()%>)" type="button" class="btn btn-primary" data-toggle="modal" data-target="#<%= blog.getBlogID()%>"><i class="fa fa-gift"></i></button>   
                                                                    <%
                                                                    } else {
                                                                    %>
                                                                <button type="button" class="btn btn-success" data-toggle="modal" data-target="#<%= blog.getBlogID()%>"><i class="fa fa-gift"></i></button>   
                                                                    <%
                                                                        }
                                                                    %>
                                                            </td>
                                                    <div class="delete-activity-message-popup-confirm" id="<%= index%>">
                                                        <p>Are you sure to give award to this blog?</p>
                                                        <div>
                                                            <a href="MainController?action=GiveAward&blogID=<%= blog.getBlogID()%>">Give Award</a>
                                                            <a onclick="closePopUpConfirm(<%= index%>, <%= listPopularBlogs.size()%>)">Cancel</a>
                                                        </div>
                                                    </div>

                                                    <%

                                                                    index++;
                                                                }
                                                            }
                                                        }
                                                    %>
                                                    </tr>
                                                    </tbody>
                                                </table>  
                                                <!--                                                <div class="menu">
                                                                                                    <ul>
                                                                                                        <li>
                                                                                                            <a href="MainController?action=ViewProfile">My profile</a>
                                                                                                        </li>
                                                                                                        <li>
                                                                                                            <a href="MainController?action=ViewPersonalPage&userID=<%= loginUser.getUserID()%>">Blog List</a>
                                                                                                        </li>
                                                                                                                                    <li>
                                                                                                                                        <a href="#">Draft</a>
                                                                                                                                    </li>
                                                <%
                                                    if (loginUser.getRoleID() == 3) {
                                                %>
                                                <li>
                                                    <a href="MainController?action=GetApproveList">Approve List</a>
                                                </li>
                                                <li>
                                                    <a href="MainController?action=ViewTopVote">Vote Ratings</a>
                                                </li>
                                                <%
                                                    }
                                                %>
                                                <li>
                                                    <a href="MainController?action=Logout">Logout</a>
                                                </li>
                                            </ul>
                                        </div>-->
                                            </div>

                                        </div>




                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>                
        </main>
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
    <script src="../vendor/vendor/jquery/jquery.min.js"></script>
    <script src="../vendor/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="../vendor/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="../vendor/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="../vendor/vendor/datatables/dataTables.bootstrap4.min.js"></script>
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
    <script>
        function menuToggle() {
            const toggleMenu = document.querySelector(".menu");
            toggleMenu.classList.toggle("active2");
        }

        function openNav() {
            if (document.getElementById('header').style.height === '20rem') {
                document.getElementById('header').style.height = '4rem'
            } else {
                document.getElementById('header').style.height = '20rem'
            }

        }

    </script>

</body>
</html>