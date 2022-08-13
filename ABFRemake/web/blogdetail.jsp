<%-- 
    Document   : blogdetail
    Created on : Jun 7, 2022, 1:36:08 PM
    Author     : ASUS
--%>

<%@page import="dto.MajorDTO"%>
<%@page import="dto.SubjectDTO"%>
<%@page import="dto.CommentDTO"%>
<%@page import="dto.BlogDTO"%>
<%@page import="java.util.List"%>
<%@page import="dto.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Blog Details</title>
        <link rel="stylesheet" href="fontawesome/css/all.min.css"> <!-- https://fontawesome.com/ -->
        <link href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro&display=swap" rel="stylesheet"> <!-- https://fonts.google.com/ -->
        <link href="CSS/bootstrap.min.css" rel="stylesheet">
        <link href="CSS/templatemo-xtra-blog.css" rel="stylesheet">
        <link rel="stylesheet" href="CSS/style.css">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src='https://kit.fontawesome.com/a076d05399.js' crossorigin='anonymous'></script>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <!--
            
        TemplateMo 553 Xtra Blog
        
        https://templatemo.com/tm-553-xtra-blog
        
        -->
    </head>
    <body class="body-blog-detail">
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
            String voteValue = (String) request.getAttribute("VOTE_VALUE");
            if (voteValue == null) {
                voteValue = "";
            }
            String numberOfVotes = request.getParameter("numberOfVotes");
            if (numberOfVotes == null) {
                numberOfVotes = "";
            }
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
                    <div class="search-div col-sm-3">
                        <div class="search-form-search">
                            <input type="text" placeholder="Search..." name="search" type="text">
                            <div class="search-search"><button type="submit" name="action" value="Search"><i class="fas fa-search"></i></button></div>
                        </div>
                    </div>
                    <div class="new col-sm-1"><a href="MainController?action=GoToPostBlogPage&position=homepage.jsp"><i class="fas fa-pen"></i></a></div>

                    <div class="profile text-gray col-sm-3">
                        <div class="row">         
                            <a style="color: black;" href="MainController?action=ViewProfile"><h6><%= loginUser.getFullName()%></h6></a>
                            <img onclick="menuToggle();" src="<%= image%>">
                        </div>
                    </div>
                </div>
            </form>
        </nav>


        <%
            List<MajorDTO> listMajor = (List<MajorDTO>) session.getAttribute("LIST_MAJOR");
            List<SubjectDTO> listSubject = (List<SubjectDTO>) session.getAttribute("LIST_SUBJECT");
            BlogDTO blogDetail = (BlogDTO) request.getAttribute("BLOG_DETAIL");
            if (blogDetail != null) {
                int majorID = 0;
                for (SubjectDTO subject : listSubject) {
                    if (blogDetail.getSubjectID() == subject.getSubjectID()) {
                        majorID = subject.getMajorID();
                        break;
                    }
                }
                String majorName = "";
                for (MajorDTO major : listMajor) {
                    if (majorID == major.getMajorID()) {
                        majorName = major.getMajorName();
                    }
                }
                String content = blogDetail.getContent();
                if (content.length() > 125 && content.length() <= 250) {
                    content = blogDetail.getContent().substring(0, 150) + "<br>"
                            + blogDetail.getContent().substring(150, blogDetail.getContent().length());

                } else if (content.length() > 250 && content.length() <= 375) {
                    content = blogDetail.getContent().substring(0, 150) + "<br>"
                            + blogDetail.getContent().substring(150, 250) + "<br>"
                            + blogDetail.getContent().substring(250, blogDetail.getContent().length());
                }
        %>
        <section class="py-5">
            <div class="container py-4">
                <div class="row text-center">
                    <div class="col-lg-8 mx-auto"><a style="background-color: #104f55; color: white; padding: 0.5rem;"  class="category-link mb-3 d-inline-block" href="MainController?action=SearchMajor&majorID=<%= majorID%>&majorName=<%= majorName%>"><%= majorName%></a>
                        <h1><%= blogDetail.getTitle()%></h1>
                        <ul class="list-inline mb-5">
                            <li class="list-inline-item mx-2 text-uppercase text-muted reset-anchor">BY <%= blogDetail.getFullName()%></li>
                            <li class="list-inline-item mx-2 text-uppercase text-muted reset-anchor"><%= blogDetail.getDate()%></li>
                        </ul>
                    </div>
                </div><img class="w-100 mb-5" src="<%= blogDetail.getImage()%>" alt="...">
                <div class="row gy-5">
                    <div class="col-lg-12">
                        <p class="lead drop-caps mb-5"><%= content%></p>

                        <!--<h2>Heading level two</h2>
                        <p class="mb-4">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                        <div class="row">
                          <div class="col-lg-6 mb-4"><a class="glightbox product-view" href="img/post-demo-1.jpg" data-gallery="gallery" data-glightbox="Image one"><img class="img-fluid img-thumbnail" src="img/post-demo-1.jpg" alt="..."></a></div>
                          <div class="col-lg-6 mb-4"><a class="glightbox product-view" href="img/post-demo-2.jpg" data-gallery="gallery" data-glightbox="Image two"><img class="img-fluid img-thumbnail" src="img/post-demo-2.jpg" alt=""></a></div>
                        </div>
                        <p class="text-muted mb-4">Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.</p>
                        <h3>Heading level three</h3>
                        <ul class="list-bullets mb-5">
                          <li>Lorem ipsum dolor sit amet, consectetur adipisicing elit.</li>
                          <li>Inventore magni sed error dignissimos repudiandae.</li>
                          <li>Aperiam cum, nisi sed aliquam soluta amet molestiae.</li>
                          <li>Consequatur sequi dolore, doloribus officia Nihil fugit.</li>
                        </ul>
                        <figure class="bg-light p-4 p-lg-5 text-center mb-5">
                          <blockquote class="blockquote">
                            <p class="h4 mb-5">Design is the fundamental soul of a human-made creation that ends up expressing itself in successive outer layers of the product or service.</p>
                          </blockquote>
                          <figcaption class="blockquote-footer">
                            <cite class="fst-normal" title="Source Title">Steve Jobs</cite>
                          </figcaption>
                        </figure>
                        <p class="mb-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. </p>
                        <!-- Post tags-->
                        <div class="d-flex align-items-center flex-column flex-sm-row mb-4 p-4 bg-light tag-blog-detail">
                            <h3 class="h4 mb-3 mb-sm-0">Tags</h3>
                            <%
                                String subjectName = "";
                                for (SubjectDTO subject : listSubject) {
                                    if (blogDetail.getSubjectID() == subject.getSubjectID()) {
                                        subjectName = subject.getSubjectName();
                                    }
                                }
                                String status = "";
                                if (blogDetail.getStatus().equals("approved")) {
                                    status = "Approved";
                                } else if (blogDetail.getStatus().equals("waiting")) {
                                    status = "Waiting For Approval";
                                }
                            %>
                            <ul class="list-inline mb-0 ms-0 ms-sm-3">
                                <li class="list-inline-item my-1 me-2"><a class="sidebar-tag-link" href="MainController?action=SearchSubject&subjectID=<%= blogDetail.getSubjectID()%>&subjectName=<%= subjectName%>"><%= subjectName%></a></li>

                            </ul>
                            <h3 class="h4 mb-3 mb-sm-0 status-blog-detail"><%= status%></h3>
                        </div>
                        <%
                            if (blogDetail.getStatus().equals("approved")) {
                                if ("".equals(numberOfVotes)) {
                        %>
                        <div id="vote-part" class="form-inline number-blog-detail row">
                            <div class="col-sm-6">
                                <a style="text-decoration: none;" href="MainController?action=Vote&blogID=<%= blogDetail.getBlogID()%>&numberOfVotes=<%= blogDetail.getNumberOfVotes()%>&userID=<%= loginUser.getUserID()%>">
                                    <%
                                        if ("unvote".equals(voteValue)) {
                                    %>
                                    <i class="fas fa-vote-yea" style="color: black;"></i>
                                    <%
                                    } else {
                                    %>
                                    <i class="fas fa-vote-yea" style="color: #0CC;"></i>
                                    <%
                                        }
                                    %>
                                </a>
                                <a><%= blogDetail.getNumberOfVotes()%></a>

                            </div>  
                            <%
                                if (loginUser.getUserID() == blogDetail.getUserID()) {
                            %>
                            <div class="form-inline button-blog-detail">
                                <button type="button" class="btn btn-primary">
                                    <a href="MainController?action=EditBlog&blogID=<%=blogDetail.getBlogID()%>&userID=<%=loginUser.getUserID()%>&subjectID=<%=blogDetail.getSubjectID()%>">Edit</a>
                                </button>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">Delete</button>   
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <%
                        } else {
                        %>
                        <div id="vote-part" class="form-inline number-blog-detail row">
                            <div class="col-sm-6">
                                <a href="MainController?action=Vote&blogID=<%= blogDetail.getBlogID()%>&numberOfVotes=<%= blogDetail.getNumberOfVotes()%>&userID=<%= loginUser.getUserID()%>">
                                    <%
                                        if ("unvote".equals(voteValue)) {
                                    %>
                                    <i class="fas fa-vote-yea" style="color: black;"></i>
                                    <%
                                    } else {
                                    %>
                                    <i class="fas fa-vote-yea" style="color: #0CC;"></i>
                                    <%
                                        }
                                    %>

                                </a>
                                <a><%= blogDetail.getNumberOfVotes()%></a>
                            </div>
                            <%
                                if (loginUser.getUserID() == blogDetail.getUserID()) {
                            %>
                            <div class="form-inline button-blog-detail">
                                <button type="button" class="btn btn-primary">
                                    <a href="MainController?action=EditBlog&blogID=<%=blogDetail.getBlogID()%>&userID=<%=loginUser.getUserID()%>&subjectID=<%=blogDetail.getSubjectID()%>">Edit</a>
                                </button>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">Delete</button>   
                            </div>
                            <%
                                }
                            %>
                        </div>
                        <%
                            }
                        %>  
                        <!-- Post share-->
                        <!-- <div class="d-flex align-items-center flex-column flex-sm-row mb-5 p-4 bg-light">
                             <h3 class="h4 mb-3 mb-sm-0">Share this post</h3>
                             <ul class="list-inline mb-0 ms-0 ms-sm-3">
                                 <li class="list-inline-item me-1 my-1"><a class="social-link-share facebook" href="#!"><i class="fab me-2 fa-facebook-f"></i>Share</a></li>
                                 <li class="list-inline-item me-1 my-1"><a class="social-link-share twitter" href="#!"><i class="fab me-2 fa-twitter"></i>Tweet</a></li>
                                 <li class="list-inline-item me-1 my-1"><a class="social-link-share instagram" href="#!"><i class="fab me-2 fa-instagram"></i>Share</a></li>
                             </ul>
                         </div>
                        <!-- Leave comment-->
                        <h3 class="h4 mb-4">Leave a comment</h3>
                        <form class="comment-form" action="MainController" method="POST" class="mb-5">
                            <input type="text" name="content" style="width: 100%;height: 40px" ></br>
                            <input type="hidden" name="userID" value="<%=loginUser.getUserID()%>">                                 
                            <input type="hidden" name="blogID" value="<%=blogDetail.getBlogID()%>">
                            <input type="hidden" name="subjectID" value="<%=blogDetail.getSubjectID()%>">
                            <input type="submit" name="action" value="Comment">
                        </form>
                        <!-- Post comments-->
                        <h3 class="h4 mb-4">Comments</h3>
                        <ul class="list-unstyled comments">
                            <%
                                List<CommentDTO> commentList = (List<CommentDTO>) request.getAttribute("COMMENT_LIST");
                                List<UserDTO> userList = (List<UserDTO>) request.getAttribute("USER_COMMENT_LIST");
                                if (commentList != null) {
                                    if (commentList.size() > 0) {
                                        for (CommentDTO comment : commentList) {
                                            UserDTO userComment = new UserDTO();
                                            for (UserDTO user : userList) {
                                                if (comment.getUserID() == user.getUserID()) {
                                                    userComment = user;
                                                }
                                            }
                                            String userImage = userComment.getImage();
                                            if (userImage == null || "".equals(userImage)) {
                                                userImage = "image/0c3b3adb1a7530892e55ef36d3be6cb8 (1).png";
                                            }
                            %>
                            <li>
                                <div class="d-flex mb-4">
                                    <div class="flex-shrink-0"><img class="rounded-circle shadow-sm img-fluid" src="<%= userImage%>" alt="Jimmy Roy" width="60"/></div>
                                    <div class="ms-3">
                                        <p class="small mb-0 text-primary fw-normal"><%= comment.getDate()%></p>
                                        <h5><%= userComment.getFullName()%></h5>
                                        <p class="text-muted text-sm mb-2"><%= comment.getContent()%></p>
                                        <!--<a class="reset-anchor text-sm" href="#!"><i class="fas fa-share me-2 text-primary"></i><strong>Reply</strong></a>-->
                                    </div>
                                </div>
                                <!--<ul class="list-unstyled ms-5">
                                    <li> 
                                        <div class="d-flex mb-4">
                                            <div class="flex-shrink-0"><img class="rounded-circle shadow-sm img-fluid" src="img/person-2.jpg" alt="Melissa Johanson" width="60"/></div>
                                            <div class="ms-3">
                                                <p class="small mb-0 text-primary fw-normal">15 Sep 2019</p>
                                                <h5>Melissa Johanson</h5>
                                                <p class="text-muted text-sm mb-2">Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At.</p><a class="reset-anchor text-sm" href="#!"><i class="fas fa-share me-2 text-primary"></i><strong>Reply</strong></a>
                                            </div>
                                        </div>
                                    </li>
                                </ul>-->
                            </li>
                            <%
                                        }
                                    }
                                }
                            } else {
                                if (loginUser.getUserID() == blogDetail.getUserID()) {
                            %>
                            <div class="form-inline button-blog-detail">
                                <button type="button" class="btn btn-primary">
                                    <a href="MainController?action=EditBlog&blogID=<%=blogDetail.getBlogID()%>&userID=<%=loginUser.getUserID()%>&subjectID=<%=blogDetail.getSubjectID()%>">Edit</a>
                                </button>
                                <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter">Delete</button>   
                            </div>
                            <%
                                    }
                                }
                            %>
                        </ul>
                    </div>
                    <div style="top: 5rem;" class="menu">
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
                    <!-- Blog sidebar-->
                    <div class="col-lg-3">
                        <!-- About category-->
                        <!--<div class="card bg-light mb-4 py-lg-4">
                          <div class="card-body text-center">
                            <h2 class="h3 mb-3">About me</h2><img class="rounded-circle mb-3" src="img/author.jpg" alt="..." width="100">
                            <p class="text-sm text-muted">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt.</p>
                            <ul class="list-inline small mb-0 text-dark">
                              <li class="list-inline-item"><a class="reset-anchor" href="#!"><i class="fab fa-facebook-f"></i></a></li>
                              <li class="list-inline-item"><a class="reset-anchor" href="#!"><i class="fab fa-twitter"></i></a></li>
                              <li class="list-inline-item"><a class="reset-anchor" href="#!"><i class="fab fa-instagram"></i></a></li>
                              <li class="list-inline-item"><a class="reset-anchor" href="#!"><i class="fab fa-linkedin"></i></a></li>
                              <li class="list-inline-item"><a class="reset-anchor" href="#!"><i class="fab fa-youtube"></i></a></li>
                            </ul>
                          </div>
                        </div>-->
                        <!-- Recent posts-->
                        <!--<div class="card mb-4">
                          <div class="card-body p-0">
                            <h2 class="h5 mb-3">Recent posts</h2>
                            <div class="d-flex mb-3"><a class="flex-shrink-0" href="post.html"><img class="img-fluid" src="img/recent-post-1.jpg" alt="" width="70"></a>
                              <div class="ms-3">
                                <h6> <a class="reset-anchor" href="post.html">Crazy goodness</a></h6>
                                <p class="text-sm text-muted lh-sm mb-0">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                              </div>
                            </div>
                            <div class="d-flex mb-3"><a class="flex-shrink-0" href="post.html"><img class="img-fluid" src="img/recent-post-2.jpg" alt="" width="70"></a>
                              <div class="ms-3">
                                <h6> <a class="reset-anchor" href="post.html">Black hat</a></h6>
                                <p class="text-sm text-muted lh-sm mb-0">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                              </div>
                            </div>
                            <div class="d-flex mb-3"><a class="flex-shrink-0" href="post.html"><img class="img-fluid" src="img/recent-post-3.jpg" alt="" width="70"></a>
                              <div class="ms-3">
                                <h6> <a class="reset-anchor" href="post.html">My office makeover</a></h6>
                                <p class="text-sm text-muted lh-sm mb-0">Lorem ipsum dolor sit amet, consectetur adipisicing elit.</p>
                              </div>
                            </div>
                          </div>
                        </div>-->
                        <!-- Categories-->
                        <!--<div class="card mb-4">
                          <div class="card-body p-0">
                            <h2 class="h5 mb-3">Trending categories</h2><a class="category-block category-block-sm bg-center bg-cover mb-2" style="background: url(img/category-bg-1.jpg)" href="#!"><span class="category-block-title">Interior Design</span></a><a class="category-block category-block-sm bg-center bg-cover mb-2" style="background: url(img/category-bg-2.jpg)" href="#!"><span class="category-block-title">Fashion</span></a><a class="category-block category-block-sm bg-center bg-cover mb-2" style="background: url(img/category-bg-3.jpg)" href="#!"><span class="category-block-title">Tips &amp; Tricks</span></a>
                          </div>
                        </div>-->
                        <!-- Tags-->
                        <!--<div class="card mb-4">
                          <div class="card-body p-0">
                            <h2 class="h5 mb-3">Tags cloud</h2>
                            <ul class="list-inline">
                              <li class="list-inline-item my-1 me-2"><a class="sidebar-tag-link" href="#!">Art</a></li>
                              <li class="list-inline-item my-1 me-2"><a class="sidebar-tag-link" href="#!">Events</a></li>
                              <li class="list-inline-item my-1 me-2"><a class="sidebar-tag-link" href="#!">Make up</a></li>
                              <li class="list-inline-item my-1 me-2"><a class="sidebar-tag-link" href="#!">Design</a></li>
                              <li class="list-inline-item my-1 me-2"><a class="sidebar-tag-link" href="#!">Fashion</a></li>
                              <li class="list-inline-item my-1 me-2"><a class="sidebar-tag-link" href="#!">Inspiration</a></li>
                              <li class="list-inline-item my-1 me-2"><a class="sidebar-tag-link" href="#!">Business</a></li>
                            </ul>
                          </div>
                        </div>-->
                        <!-- Ad-->
                        <!--<div class="card mb-4">
                          <div class="card-body p-0"><a class="d-block" href="#!"><img class="img-fluid" src="img/banner.jpg" alt=""></a></div>
                        </div>
                      </div>
                    </div>
                  </div>-->
                        </section>
                        <div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalCenterTitle">Delete</h5>
                                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">&times;</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <p>Are you sure you want to delete?</p>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" data-dismiss="modal">Cancel</button>
                                        <a href="MainController?action=DeleteBlog&blogID=<%= blogDetail.getBlogID()%>&userID=<%= loginUser.getUserID()%>" type="button" class="btn btn-danger">Delete</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <%
                            }
                        %>
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
                        <!--                        <script>
                                                    var loc = window.location.href;
                                                    window.location.href = loc + "#vote-part";
                                                </script>-->
                        <script src="js/jquery.min.js"></script>
                        <script src="js/templatemo-script.js"></script>
                        <script>
                                function menuToggle() {
                                    const toggleMenu = document.querySelector(".menu");
                                    toggleMenu.classList.toggle("active2");
                                }
                                function openNav() {
                                    if (document.getElementById('header').style.height === '19rem') {
                                        document.getElementById('header').style.height = '4rem'
                                    } else {
                                        document.getElementById('header').style.height = '19rem'
                                    }

                                }
                        </script>   
                        </body>

                        </html>
