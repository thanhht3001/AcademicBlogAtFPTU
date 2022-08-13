/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.BlogDAO;
import dao.RegistrationDAO;
import dto.BlogDTO;
import dto.RegistrationDTO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
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
@WebServlet(name = "SearchApproveBlogController", urlPatterns = {"/SearchApproveBlogController"})
public class SearchApproveBlogController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "approveblog.jsp";

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String url = ERROR;
            try {
                BlogDAO dao = new BlogDAO();
                RegistrationDAO regisDao = new RegistrationDAO();
                int subjectID = Integer.parseInt(request.getParameter("subjectID"));
                HttpSession session = request.getSession();
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                int loginUserID = loginUser.getUserID();
                List<BlogDTO> listApproveBlogs = new ArrayList<>();
                List<RegistrationDTO> listsub = regisDao.getRegistrationByUserid(loginUserID);
                listApproveBlogs = dao.getAllApproveBlogs(loginUserID, subjectID);//Lấy hết các blog                                              
                if (listApproveBlogs.size() > 0) {
                    Collections.sort(listApproveBlogs, BlogDTO.compareDate);
                    request.setAttribute("LIST_ALL_BLOGS", listApproveBlogs);
                }
                request.setAttribute("MENTOR_REGIS", listsub);
                url = SUCCESS;
            } catch (Exception e) {
                log("Error at SearchApproveBlogController: " + e.toString());
            } finally {
                request.getRequestDispatcher(url).forward(request, response);
            }
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
