<%-- 
    Document   : homepage
    Created on : May 30, 2022, 7:18:09 PM
    Author     : To Quyen Phan
--%>


<%@page import="java.util.Calendar"%>
<%@page import="java.util.concurrent.TimeUnit"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="dto.MajorDTO"%>
<%@page import="dto.SubjectDTO"%>
<%@page import="dto.BlogDTO"%>
<%@page import="java.util.List"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Academic Blog</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>

        <!-- Font Awesome Icons -->
        <!--<link rel="stylesheet" href="CSS/all.css">
    
    
        <!-- --------- Owl-Carousel ------------------->
        <!--<link rel="stylesheet" href="CSS/owl.carousel.min.css">
        <link rel="stylesheet" href="CSS/owl.theme.default.min.css">
    
        <!-- ------------ AOS Library ------------------------- -->
        <!--<link rel="stylesheet" href="CSS/aos.css">
    
        <!-- Custom Style   -->
        <link rel="stylesheet" href="CSS/style.css">

    </head>

    <body>

        <!-- ----------------------------  Navigation ---------------------------------------------- -->
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
        <nav class="nav approve-page" id="header">
            <form action="MainController" method="POST">
                <div class="nav-menu row">
                    <div class="nav-brand col-sm-2">
                        <a href="#" class="text-gray">Academic Blog</a>
                    </div>
                    <div class="approve-page toggle-collapse">
                        <div class="toggle-icons">
                            <i onclick="openNav();" class="fas fa-bars"></i>
                        </div>
                    </div>
                    <div class="nav-link-items col-sm-3">
                        <ul class="nav-items">
                            <li class="nav-link active">
                                <a href="#">Home</a>
                            </li>
                            <li class="nav-link">
                                <a href="MainController?action=GetFeedbackTypeList">Feedback</a>
                            </li>
                            <li class="nav-link"><a href="MainController?action=MentorRegisterPage&userID=<%=loginUser.getUserID()%>" class="tm-nav-link">
                                    Registration
                                </a></li>  
                            <li class="nav-link non-display">
                                <a href="MainController?action=GoToPostBlogPage&position=homepage.jsp">New Blog</a>
                            </li>
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

        <!-- ------------x---------------  Navigation --------------------------x------------------- -->

        <!----------------------------- Main Site Section ------------------------------>

        <main>

            <!------------------------ Site Title ---------------------->

            <section class="site-title">
                <div class="site-background">
                    <%
                        String roleName = "";
                        if (loginUser.getRoleID() == 2) {
                            roleName = "Student";
                        } else {
                            roleName = "Mentor";
                        }
                    %>
                    <h2>Welcome <%= roleName%> <%= loginUser.getFullName()%>!</h2>
                    <h1>Amazing Place on Sharing Experiences</h1>
                    <a href="#main-part"><button class="btn">Explore</button></a>
                    <div class="menu">
                        <ul>
                            <li>
                                <a href="MainController?action=ViewProfile">My profile</a>
                            </li>
                            <li>
                                <a href="MainController?action=ViewPersonalPage&userID=<%= loginUser.getUserID()%>">Blog List</a>
                            </li>
                            <!--                            <li>
                                                            <a href="#">Draft</a>
                                                        </li>-->
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
                    </div>
                </div>
            </section>

            <!------------x----------- Site Title ----------x----------->

            <!-- --------------------- Blog Carousel ----------------- -->

            <section id="main-part">
                <div class="blog">
                    <div class="">
                        <div>
                            <h1>Newest</h1>
                        </div>
                        <div class="owl-carousel owl-theme blog-post row">
                            <%
                                List<BlogDTO> listAllBlogs = (List<BlogDTO>) session.getAttribute("LIST_ALL_BLOGS");
                                List<BlogDTO> listNewestBlogs = (List<BlogDTO>) request.getAttribute("LIST_NEWEST_BLOGS");
                                List<BlogDTO> listPopulartBlogs = (List<BlogDTO>) session.getAttribute("LIST_POPULAR_BLOGS");
                                List<MajorDTO> listMajor = (List<MajorDTO>) session.getAttribute("LIST_MAJOR");
                                List<SubjectDTO> listSubject = (List<SubjectDTO>) session.getAttribute("LIST_SUBJECT");
                                if (listNewestBlogs != null) { //chỉ hiển thị khi người dùng đã đăng nhập
                                    if (listNewestBlogs.size() > 0) {
                                        int index = 1;
                                        for (BlogDTO blog : listNewestBlogs) {
                                            if (index == 4) {
                                                break;
                                            }
                                            if (blog.getImage() != null || blog.getImage() != "") {
                                                String title = "";
                                                if (blog.getTitle().length() > 20) {
                                                    title = blog.getTitle().substring(0, 20) + "...";
                                                } else {
                                                    title = blog.getTitle();
                                                }
                                                int majorID = 0;
                                                for (SubjectDTO subject : listSubject) {
                                                    if (blog.getSubjectID() == subject.getSubjectID()) {
                                                        majorID = subject.getMajorID();
                                                    }
                                                }
                                                String majorName = "";
                                                String status = "";
                                                for (MajorDTO major : listMajor) {
                                                    if (majorID == major.getMajorID()) {
                                                        majorName = major.getMajorName();
                                                        status = major.getStatus();
                                                    }
                                                }
                                                if (status.equals("1")) {
                            %> 
                            <div class="blog-content col-sm-3">
                                <form action="MainController" method="POST">
                                    <img src="<%= blog.getImage()%>" alt="post-<%= index%>">
                                    <div class="blog-title">
                                        <h3><a href="MainController?action=ViewBlogDetails&blogID=<%= blog.getBlogID()%>"><%= title%></a></h3>
                                        <input type="hidden" name="majorID" value="<%= majorID%>"/>
                                        <input type="hidden" name="majorName" value="<%= majorName%>"/>
                                        <button type="submit" name="action" value="SearchMajor" class="btn btn-blog"><%= majorName%></button>
                                        <span><%= blog.getDate()%></span>
                                    </div>
                                </form>
                            </div>
                            <%
                                                    index++;
                                                }
                                            }
                                        }
                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>
            </section>

            <!-- ----------x---------- Blog Carousel --------x-------- -->

            <!-- ---------------------- Site Content -------------------------->

            <section class="site-blog-content">
                <div class="site-content">
                    <div class="posts">
                        <%
                            if (listAllBlogs != null) {
                                if (listAllBlogs.size() > 0) {
                                    int index = 0;
                                    for (BlogDTO blog : listAllBlogs) {
                                        if (index == 4) {
                                            break;
                                        }
                                        String content = "";
                                        String remain = "";
                        %>
                        <form action="MainController"method="POST">
                            <div class="post-content" data-aos="zoom-in" data-aos-delay="200">
                                <div class="post-image">
                                    <div>
                                        <img src="<%= blog.getImage()%>" class="img" alt="blog1">
                                    </div>
                                    <div class="post-info flex-row">
                                        <span><i class="fas fa-user text-gray"></i>&nbsp;&nbsp;<%= blog.getFullName()%></span>
                                        <span><i class="fas fa-calendar-alt text-gray"></i>&nbsp;&nbsp;<%= blog.getDate()%></span>
<!--                                        <span><%= blog.getNumberOfComments()%> Comments</span>-->
                                    </div>
                                </div>
                                <div class="post-title">
                                    <a href="MainController?action=ViewBlogDetails&blogID=<%= blog.getBlogID()%>"><%= blog.getTitle()%></a>
                                    <%
                                        if (blog.getContent().length() > 138) {
                                            content = blog.getContent().substring(0, 138) + "<br>";
                                            remain = blog.getContent().substring(138, 273) + "...";
                                    %>
                                    <p><%= content%><%= remain%></p>
                                    <%
                                    } else {
                                        content = blog.getContent();

                                    %>
                                    <p><%= content%></p>
                                    <%
                                        }
                                    %>
                                    <input type="hidden" name="blogID" value="<%= blog.getBlogID()%>"/>
                                    <button type="submit" value="ViewBlogDetails" name="action" class="btn post-btn">Read More &nbsp; <i class="fas fa-arrow-right"></i></button>
                                </div>
                            </div>
                        </form>
                        <%
                                        index++;
                                    }
                                }
                            }
                        %>
                        <hr>
                        <!--                        <div class="pagination flex-row">
                                                    <a href="#"><i class="fas fa-chevron-left"></i></a>
                                                    <a href="#" class="pages">1</a>
                                                    <a href="#" class="pages">2</a>
                                                    <a href="#" class="pages">3</a>
                                                    <a href="#"><i class="fas fa-chevron-right"></i></a>
                                                </div>-->
                    </div>
                    <aside class="sidebar">
                        <div class="category">
                            <h2>Majors</h2>
                            <ul class="category-list">
                                <%
                                    if (listMajor != null) {
                                        if (listMajor.size() > 0) {
                                            for (MajorDTO major : listMajor) {
                                                int numberOfBlogs = 0;
                                                int subjectID = 0;
                                                for (SubjectDTO subject : listSubject) {
                                                    if (major.getMajorID() == subject.getMajorID()) {
                                                        subjectID = subject.getSubjectID();
                                                    }
                                                    for (BlogDTO blog : listNewestBlogs) {
                                                        if (blog.getSubjectID() == subjectID) {
                                                            numberOfBlogs++;
                                                        }
                                                    }
                                                }
                                %>
                                <li class="list-items" data-aos="fade-left" data-aos-delay="100">
                                    <a href="MainController?action=SearchMajor&majorID=<%= major.getMajorID()%>&majorName=<%= major.getMajorName()%>"><%= major.getMajorName()%></a>
                                    <span>(<%= numberOfBlogs%>)</span>
                                </li>
                                <%
                                            }
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                        <div class="popular-post">
                            <h2>Popular Post</h2>
                            <%
                                if (listPopulartBlogs != null) {
                                    if (listPopulartBlogs.size() > 0) {
                                        int index = 0;
                                        for (BlogDTO blog : listPopulartBlogs) {
                                            if (index == 5) {
                                                break;
                                            }
                            %>
                            <form>
                                <div class="post-content" data-aos="flip-up" data-aos-delay="200">
                                    <div class="post-image">
                                        <div>
                                            <img src="<%= blog.getImage()%>" class="img" alt="blog1">
                                        </div>
                                        <div class="post-info flex-row">
                                            <span><i class="fas fa-calendar-alt text-gray"></i>&nbsp;&nbsp;<%= blog.getDate()%></span>
                                            <span><%= blog.getNumberOfVotes()%> Votes</span>
                                        </div>
                                    </div>
                                    <div class="post-title">
                                        <a href="MainController?action=ViewBlogDetails&blogID=<%= blog.getBlogID()%>"><%= blog.getTitle()%></a>
                                    </div>
                                </div>
                            </form>
                            <%
                                            index++;
                                        }
                                    }
                                }
                            %>
                        </div>
                        <!--                        <div class="newsletter" data-aos="fade-up" data-aos-delay="300">
                                                    <h2>Newsletter</h2>
                                                    <div class="form-element">
                                                        <input type="text" class="input-element" placeholder="Email">
                                                        <button class="btn form-btn">Subscribe</button>
                                                    </div>
                                                </div>-->
                        <div class="popular-tags">
                            <h2>Subjects</h2>
                            <div class="tags flex-row">
                                <%
                                    if (listSubject != null) {
                                        if (listSubject.size() > 0) {
                                            for (SubjectDTO subject : listSubject) {

                                %>
                                <span class="tag" data-aos="flip-up" data-aos-delay="100"><a href="MainController?action=SearchSubject&subjectID=<%= subject.getSubjectID()%>&subjectName=<%= subject.getSubjectName()%>"><%= subject.getSubjectName()%></a></span>
                                    <%
                                                }
                                            }
                                        }
                                    %>
                            </div>
                        </div>
                    </aside>
                </div>
            </section>

            <!-- -----------x---------- Site Content -------------x------------>

        </main>

        <!---------------x------------- Main Site Section ---------------x-------------->


        <!-- --------------------------- Footer ---------------------------------------- -->

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

        <!-- -------------x------------- Footer --------------------x------------------- -->

        <!-- Jquery Library file -->
        <script src="./js/Jquery3.4.1.min.js"></script>

        <!-- --------- Owl-Carousel js ------------------->
        <script src="./js/owl.carousel.min.js"></script>

        <!-- ------------ AOS js Library  ------------------------- -->
        <script src="./js/aos.js"></script>

        <!-- Custom Javascript file -->
        <script src="js/main.js"></script>

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