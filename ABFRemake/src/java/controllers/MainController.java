/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dto.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author To Quyen Phan
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String LOGIN = "Login";
    private static final String LOGIN_WITH_GOOGLE = "LoginWithGoogle";
    private static final String GETLIST = "GetList";
    private static final String GETFEEDBACKTYPELIST = "GetFeedbackTypeList";
    private static final String SEND = "Send";
    private static final String SEARCH = "Search";
    private static final String SORT_BY_DATE = "Sort";
    private static final String VIEW_BLOG_DETAIL = "ViewBlogDetails";
    private static final String POST = "Post";
    private static final String UPLOAD = "Upload";
    private static final String COMMENT = "Comment";
    private static final String GET_ACTIVITY_LIST = "GetActivityList";
    private static final String DELETE_ACTIVITY = "DeleteActivity";
    private static final String VOTE = "Vote";
    private static final String GET_APPROVE_LIST = "GetApproveList";
    private static final String SORT_APPROVE_LIST = "Sort Blog";
    private static final String VIEW_APPROVE_BLOG_DETAIL = "ViewApproveBlogDetails";
    private static final String DELETE_BLOG = "DeleteBlog";
    private static final String EDIT_BLOG = "EditBlog";
    private static final String EDIT = "Edit";
    private static final String GET_MAJOR_LIST = "GetMajorList";
    private static final String DELETE_MAJOR = "DeleteMajor";
    private static final String GET_SUBJECT_LIST = "GetSubjectList";
    private static final String DELETE_SUBJECT = "DeleteSubject";
    private static final String APPROVE_BLOG = "Approve";
    private static final String REJECT_BLOG = "Reject";
    private static final String FEEDBACK_LIST = "GetFeedbackList";
    private static final String FEEDBACK_DETAIL = "FeedbackDetail";
    private static final String GO_TO_WELCOME_PAGE = "GoToWelcomePage";
    private static final String GO_TO_POST_BLOG = "GoToPostBlogPage";
    private static final String VIEW_PERSONAL_PAGE = "ViewPersonalPage";
    private static final String SAVE_DRAFT_BLOG = "SaveDraftBlog";
    private static final String LOGOUT = "Logout";
    private static final String SEARCH_ACTIVITY_BY_NAME = "PersonalSearch";
    private static final String CANCEL = "Cancel";
    private static final String SEARCH_MAJOR = "SearchMajor";
    private static final String SEARCH_SUBJECT = "SearchSubject";
    private static final String SEARCH_FEEDBACK_BY_NAME = "SearchFeedbackByName";
    private static final String SEARCH_MAJOR_BY_NAME = "SearchMajorByName";
    private static final String SEARCH_SUBJECT_BY_NAME = "SearchSubjectByName";
    private static final String UPDATE_STATUS_USER = "UpdateStatusUser";
    private static final String CREATE_MAJOR = "CreateMajor";
    private static final String CREATE_SUBJECT = "CreateSubject";
    private static final String GO_TO_EDIT_SUBJECT = "GoToEditSubject";
    private static final String SAVE_SUBJECT = "Save Subject";
    private static final String GO_TO_EDIT_MAJOR = "GoToEditMajor";
    private static final String SAVE_MAJOR = "Save Major";
    private static final String MENTOR_REGISTER = "MentorRegisterPage";
    private static final String REGISTER = "Register";
    private static final String MANAGE_REGISTRATION = "ManageRegistration";
    private static final String REGISTRATION_DETAIL = "RegistrationDetail";
    private static final String APPROVE_REGISTRATION = "ApproveRegis";
    private static final String REJECT_REGISTRATION = "RejectRegis";
    private static final String VIEW_PROFILE = "ViewProfile";
    private static final String SEARCH_APPROVE_BLOG_BY_SUBJECT = "SearchApproveBlogBySubject";
    private static final String VIEW_TOP_VOTE = "ViewTopVote";
    private static final String GIVE_AWARD = "GiveAward";
    private static final String SEARCH_SUBJECT_BY_MAJOR = "SearchSubjectByMajorID";

    private static final String LOGIN_WITH_GOOGLE_CONTROLLER = "LoginWithGoogleController";
    private static final String LOGIN_CONTROLLER = "LoginController";
    private static final String GET_BLOG_LIST_CONTROLLER = "GetBlogListController";
    private static final String GET_FEEDBACK_TYPE_LIST_CONTROLLER = "GetFeedbackTypeListController";
    private static final String SEND_FEEDBACK_CONTROLLER = "SendFeedbackController";
    private static final String SEARCH_CONTROLLER = "SearchController";
    private static final String SORT_BY_DATE_PAGE = "MainController?action=GetList";
    private static final String BLOG_DETAIL_CONTROLLER = "BlogDetailController";
    private static final String POST_BLOG_CONTROLLER = "PostBlogController";
    private static final String UPLOAD_FILE_CONTROLLER = "UploadFileController";
    private static final String COMMENT_CONTROLLER = "CommentController";
    private static final String GET_ACTIVITY_LIST_CONTROLLER = "GetActivityListController";
    private static final String DELETE_ACTIVITY_CONTROLLER = "DeleteActivityController";
    private static final String VOTE_CONTROLLER = "VoteController";
    private static final String GET_APPROVE_BLOG_CONTROLLER = "GetApproveBlogListController";
    private static final String APPROVE_BLOG_DETAIL_CONTROLLER = "ApproveBlogDetailController";
    private static final String DELETE_BLOG_CONTROLLER = "DeleteBlogController";
    private static final String GO_TO_EDIT_BLOG_PAGE_CONTROLLER = "GoToEditBlogPageController";
    private static final String EDIT_BLOG_CONTROLLER = "EditBlogController";
    private static final String GET_MAJOR_LIST_CONTROLLER = "GetMajorListController";
    private static final String DELETE_MAJOR_CONTROLLER = "DeleteMajorController";
    private static final String GET_SUBJECT_LIST_CONTROLLER = "GetSubjectListController";
    private static final String DELETE_SUBJECT_CONTROLLER = "DeleteSubjectController";
    private static final String APPROVE_BLOG_CONTROLLER = "ApproveBlogController";
    private static final String REJECT_BLOG_CONTROLLER = "RejectBlogController";
    private static final String FEEDBACK_LIST_CONTROLLER = "GetFeedbackListController";
    private static final String FEEDBACK_DETAIL_CONTROLLER = "FeedbackDetailController";
    private static final String WELCOME_PAGE = "index.jsp";
    private static final String POST_BLOG_PAGE = "postblog.jsp";
    private static final String VIEW_PERSONAL_PAGE_CONTROLLER = "ViewPersonalPageController";
    private static final String SAVE_DRAFT_BLOG_CONTROLLER = "SaveDraftBlogController";
    private static final String LOGOUT_CONTROLLER = "LogoutController";
    private static final String SEARCH_ACTIVITY_BY_NAME_CONTROLLER = "SearchActivitiesByNameController";
    private static final String CANCEL_CONTROLLER = "CancelController";
    private static final String SEARCH_BY_MAJOR_CONTROLLER = "SearchByMajorController";
    private static final String SEARCH_BY_SUBJECT_CONTROLLER = "SearchBySubjectController";
    private static final String SEARCH_FEEDBACK_BY_NAME_CONTROLLER = "SearchFeedbackByNameController";
    private static final String SEARCH_MAJOR_BY_NAME_CONTROLLER = "SearchMajorByNameController";
    private static final String SEARCH_SUBJECT_BY_NAME_CONTROLLER = "SearchSubjectByNameController";
    private static final String BAN_OR_UNBAN_CONTROLLER = "BanOrUnBanUserController";
    private static final String CREATE_MAJOR_CONTROLLER = "CreateMajorController";
    private static final String CREATE_SUBJECT_CONTROLLER = "CreateSubjectController";
    private static final String GO_TO_EDIT_SUBJECT_CONTROLLER = "GoToEditSubjectController";
    private static final String EDIT_SUBJECT_CONTROLLER = "EditSubjectController";
    private static final String GO_TO_EDIT_MAJOR_CONTROLLER = "GoToEditMajorController";
    private static final String EDIT_MAJOR_CONTROLLER = "EditMajorController"; 
    private static final String MENTOR_REGISTER_PAGE = "mentorregister.jsp";
    private static final String REGISTRATION_CONTROLLER = "RegistrationController";
    private static final String GET_LIST_REGISTRATION_CONTROLLER = "GetListRegistrationController";
    private static final String REGISTRATION_DETAIL_CONTROLLER = "RegistrationDetailController";
    private static final String APPROVE_REGISTRATION_CONTROLLER = "ApproveRegistrationController";
    private static final String REJECT_REGISTRATION_CONTROLLER = "RejectRegistrationController";
    private static final String PROFILE_PAGE = "profile.jsp";
    private static final String SEARCH_APPROVE_BLOG_CONTROLLER = "SearchApproveBlogController";
    private static final String TOP_VOTE_PAGE = "voteratings.jsp";
    private static final String GIVE_AWARD_CONTROLLER = "GiveAwardController";
    private static final String SEARCH_SUBJECT_BY_MAJOR_CONTROLLER = "SearchSubjectByMajorIDController";

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (LOGIN_WITH_GOOGLE.equals(action)) {
                url = LOGIN_WITH_GOOGLE_CONTROLLER;
            } else if (LOGIN.equals(action)) {
                url = LOGIN_CONTROLLER;
            } else if (GETLIST.equals(action)) {
                url = GET_BLOG_LIST_CONTROLLER;
            } else if (GETFEEDBACKTYPELIST.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = GET_FEEDBACK_TYPE_LIST_CONTROLLER;
            } else if (SEND.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SEND_FEEDBACK_CONTROLLER;
            } else if (SEARCH.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SEARCH_CONTROLLER;
            } else if (SORT_BY_DATE.equals(action)) {
                url = SORT_BY_DATE_PAGE;
            } else if (VIEW_BLOG_DETAIL.equals(action)) {
                url = BLOG_DETAIL_CONTROLLER;
            } else if (POST.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = POST_BLOG_CONTROLLER;
            } else if (UPLOAD.equals(action)) {
                url = UPLOAD_FILE_CONTROLLER;
            } else if (COMMENT.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = COMMENT_CONTROLLER;
            } else if (GET_ACTIVITY_LIST.equals(action)) {
                url = GET_ACTIVITY_LIST_CONTROLLER;
            } else if (DELETE_ACTIVITY.equals(action)) {
                url = DELETE_ACTIVITY_CONTROLLER;
            } else if (VOTE.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = VOTE_CONTROLLER;
            } else if (GET_APPROVE_LIST.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = GET_APPROVE_BLOG_CONTROLLER;
            } else if (SORT_APPROVE_LIST.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = GET_APPROVE_BLOG_CONTROLLER;
            } else if (DELETE_BLOG.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = DELETE_BLOG_CONTROLLER;
            } else if (EDIT_BLOG.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = GO_TO_EDIT_BLOG_PAGE_CONTROLLER;
            } else if (EDIT.equals(action)) {
                url = EDIT_BLOG_CONTROLLER;
            } else if (GET_MAJOR_LIST.equals(action)) {
                url = GET_MAJOR_LIST_CONTROLLER;
            } else if (DELETE_MAJOR.equals(action)) {
                url = DELETE_MAJOR_CONTROLLER;
            } else if (GET_SUBJECT_LIST.equals(action)) {
                url = GET_SUBJECT_LIST_CONTROLLER;
            } else if (DELETE_SUBJECT.equals(action)) {
                url = DELETE_SUBJECT_CONTROLLER;
            } else if (VIEW_APPROVE_BLOG_DETAIL.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = APPROVE_BLOG_DETAIL_CONTROLLER;
            } else if (APPROVE_BLOG.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = APPROVE_BLOG_CONTROLLER;
            } else if (REJECT_BLOG.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = REJECT_BLOG_CONTROLLER;
            } else if (FEEDBACK_LIST.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = FEEDBACK_LIST_CONTROLLER;
            } else if (FEEDBACK_DETAIL.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = FEEDBACK_DETAIL_CONTROLLER;
            } else if (GO_TO_WELCOME_PAGE.equals(action)) {
                url = WELCOME_PAGE;
            } else if (GO_TO_POST_BLOG.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = POST_BLOG_PAGE;
            } else if (VIEW_PERSONAL_PAGE.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = VIEW_PERSONAL_PAGE_CONTROLLER;
            } else if (SAVE_DRAFT_BLOG.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SAVE_DRAFT_BLOG_CONTROLLER;
            } else if (LOGOUT.equals(action)) {
                url = LOGOUT_CONTROLLER;
            } else if (SEARCH_ACTIVITY_BY_NAME.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SEARCH_ACTIVITY_BY_NAME_CONTROLLER;
            } else if (CANCEL.equals(action)) {
                url = CANCEL_CONTROLLER;
            } else if (SEARCH_MAJOR.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SEARCH_BY_MAJOR_CONTROLLER;
            } else if (SEARCH_SUBJECT.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SEARCH_BY_SUBJECT_CONTROLLER;
            } else if (SEARCH_FEEDBACK_BY_NAME.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SEARCH_FEEDBACK_BY_NAME_CONTROLLER;
            } else if (SEARCH_MAJOR_BY_NAME.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SEARCH_MAJOR_BY_NAME_CONTROLLER;
            } else if (SEARCH_SUBJECT_BY_NAME.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SEARCH_SUBJECT_BY_NAME_CONTROLLER;
            } else if (UPDATE_STATUS_USER.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = BAN_OR_UNBAN_CONTROLLER;
            } else if (CREATE_MAJOR.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = CREATE_MAJOR_CONTROLLER;
            } else if (CREATE_SUBJECT.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = CREATE_SUBJECT_CONTROLLER;
            } else if (GO_TO_EDIT_SUBJECT.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = GO_TO_EDIT_SUBJECT_CONTROLLER;
            } else if (SAVE_SUBJECT.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = EDIT_SUBJECT_CONTROLLER;
            } else if (GO_TO_EDIT_MAJOR.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = GO_TO_EDIT_MAJOR_CONTROLLER;
            } else if (SAVE_MAJOR.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = EDIT_MAJOR_CONTROLLER;
            }else if (MENTOR_REGISTER.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = MENTOR_REGISTER_PAGE;
            }else if (REGISTER.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = REGISTRATION_CONTROLLER;
            }else if (MANAGE_REGISTRATION.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = GET_LIST_REGISTRATION_CONTROLLER;
            }else if (REGISTRATION_DETAIL.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = REGISTRATION_DETAIL_CONTROLLER;
            }else if (APPROVE_REGISTRATION.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = APPROVE_REGISTRATION_CONTROLLER;
            }else if (REJECT_REGISTRATION.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = REJECT_REGISTRATION_CONTROLLER;
            }else if (VIEW_PROFILE.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = PROFILE_PAGE;
            }else if (SEARCH_APPROVE_BLOG_BY_SUBJECT.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SEARCH_APPROVE_BLOG_CONTROLLER;
            }else if (VIEW_TOP_VOTE.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = TOP_VOTE_PAGE;
            }else if (GIVE_AWARD.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = GIVE_AWARD_CONTROLLER;
            }else if (SEARCH_SUBJECT_BY_MAJOR.equals(action)) {
                if (loginUser == null) {
                    response.sendRedirect("MainController?action=GoToWelcomePage");   
                }
                url = SEARCH_SUBJECT_BY_MAJOR_CONTROLLER;
            }else{
                request.setAttribute("ERROR_MESSAGE", "Function is not available!");
            }
        } catch (Exception e) {
            log("Error at Main Controller: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
