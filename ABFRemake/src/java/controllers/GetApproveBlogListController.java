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
@WebServlet(name = "GetApproveBlogListController", urlPatterns = {"/GetApproveBlogListController"})
public class GetApproveBlogListController extends HttpServlet {

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
        String url = ERROR;
        try {
            BlogDAO dao = new BlogDAO();
            RegistrationDAO regisDao = new RegistrationDAO();
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            int loginUserID = loginUser.getUserID();
            List<BlogDTO> listApproveBlogs2 = new ArrayList<>();
            List<BlogDTO> listApproveBlogs1 = new ArrayList<>();
            List<RegistrationDTO> listsub = regisDao.getRegistrationByUserid(loginUserID);
            if (listsub.size() > 0) {
                for (RegistrationDTO regis : listsub) {
                    listApproveBlogs2 = dao.getAllApproveBlogs(loginUserID, regis.getSubjectID());//Lấy hết các blog
                    listApproveBlogs1.addAll(listApproveBlogs2);
                }
                if (listApproveBlogs1.size() > 0) {
                    Collections.sort(listApproveBlogs1, BlogDTO.compareDate);
                    request.setAttribute("LIST_ALL_BLOGS", listApproveBlogs1);
                    request.setAttribute("MENTOR_REGIS", listsub);
                }
            }
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at Get Approve Blog List Controller: " + e.toString());
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
