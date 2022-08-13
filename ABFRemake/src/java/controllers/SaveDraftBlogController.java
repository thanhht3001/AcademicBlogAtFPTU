/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.BlogDAO;
import dto.BlogError;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author To Quyen Phan
 */
@WebServlet(name = "SaveDraftBlogController", urlPatterns = {"/SaveDraftBlogController"})
public class SaveDraftBlogController extends HttpServlet {
    private static final String ERROR = "postblog.jsp";
    private static final String SUCCESS = "MainController?action=GetList";
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
        BlogError blogError = new BlogError();
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date dateFormat = new Date();
        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            int subjectID = Integer.parseInt(request.getParameter("subjectID"));
            String title = request.getParameter("title");
            String content = request.getParameter("content");
            String date = sdf.format(dateFormat);
            String image = request.getParameter("image");
            boolean checkValidation = false;
            BlogDAO dao = new BlogDAO();
            if (title.length() < 10 || title.length() > 50) {
                blogError.setTitleError("Title must be in [10,50]");
                checkValidation = true;
            }
            if (content.length() < 50) {
                blogError.setContentError("Content must be greater than 50");
                checkValidation = true;
            }
            if (!checkValidation) {
                boolean check = dao.draftBlog(userID, subjectID, title, content, date, image);
                if (check) {
                    url = SUCCESS;
                }
            } else {
                request.setAttribute("BLOG_ERROR", blogError);
                request.setAttribute("TITLE", title);
            }

        } catch (Exception e) {
            log("Error at Post Blog Controller: " + e.toString());
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
