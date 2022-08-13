/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
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
@WebServlet(name = "CancelController", urlPatterns = {"/CancelController"})
public class CancelController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String HOMEPAGE = "homepage.jsp";
    private static final String APPROVEBLOG = "approveblog.jsp";
    private static final String EDITBLOG = "editblog.jsp";

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
            String position = request.getParameter("position");
            if (position != null) {
                HttpSession session = request.getSession();
                    UserDTO loginUser = (UserDTO)session.getAttribute("LOGIN_USER");
                    String userID = String.valueOf(loginUser.getUserID());
                if(HOMEPAGE.equals(position)){
                    url = "MainController?action=GetList";
                }else if(APPROVEBLOG.equals(position)){ 
                    url = "MainController?action=GetApproveList";
                }else if(EDITBLOG.equals(position)){ 
                    url = "MainController?action=ViewBlogDetails";
                }
            }
        } catch (Exception e) {
            log("Error at Cancel Controller: " + e.toString());
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
