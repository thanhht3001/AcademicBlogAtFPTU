/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.ActivityDAO;
import dao.BlogDAO;
import dao.CommentDAO;
import dao.UserDAO;
import dto.BlogDTO;
import dto.CommentDTO;
import dto.UserDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author To Quyen Phan
 */
@WebServlet(name = "BlogDetailController", urlPatterns = {"/BlogDetailController"})
public class BlogDetailController extends HttpServlet {

    private static final String ERROR = "homepage.jsp";
    private static final String SUCCESS = "blogdetail.jsp";

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
            String strBlogID = request.getParameter("blogID");
            if (strBlogID != null) {
                int blogID = Integer.parseInt(strBlogID);
                BlogDAO dao = new BlogDAO();
                BlogDTO blogDetail = dao.BlogDetail(blogID);
                CommentDAO commentDAO = new CommentDAO();
                List<CommentDTO> commentList = commentDAO.getCommentbyBlogID(blogID);
                HttpSession session = request.getSession();
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                ActivityDAO activityDAO = new ActivityDAO();
                boolean check = activityDAO.findVoteActivity(blogID, loginUser.getUserID());
                if(check){
                    request.setAttribute("VOTE_VALUE", "voted");
                }else{
                    request.setAttribute("VOTE_VALUE", "unvote");
                }
                if (blogDetail != null) {
                    request.setAttribute("BLOG_DETAIL", blogDetail);
                    if(commentList.size() > 0){
                        request.setAttribute("COMMENT_LIST", commentList);
                        UserDAO userDAO = new UserDAO();
                        List<UserDTO> listAllUsers = userDAO.getAllUser();
                        if(listAllUsers.size() > 0){
                            request.setAttribute("USER_COMMENT_LIST", listAllUsers);
                        }
                    }
                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
            log("Error at SearchController: " + e.toString());
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
