/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
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
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String ADMIN = "Admin";
    private static final String STUDENT = "Student";
    private static final String MENTOR = "Mentor";
    private static final String ADMIN_PAGE = "manageaccount.jsp";
    private static final String USER_CONTROLLER = "MainController?action=GetList";

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
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            UserDAO dao = new UserDAO();
            UserDTO loginUser = dao.checkLogin(email, password);
            if (loginUser != null) {
                if (loginUser.isStatus()) {//Kiểm tra xem tài khoản còn hoạt động ko
                    HttpSession session = request.getSession();
                    session.setAttribute("LOGIN_USER", loginUser);
                    String roleName = dao.checkRole(loginUser.getRoleID());
                    if (ADMIN.equals(roleName)) {
                        url = ADMIN_PAGE;
                    } else {
                        if (STUDENT.equals(roleName)){
                                url = USER_CONTROLLER;
                                session.setAttribute("ROLE", STUDENT);
                            }if(MENTOR.equals(roleName)){
                                url = USER_CONTROLLER;
                                session.setAttribute("ROLE", MENTOR);
                            } else {//Nhắc nhở nhẹ nhàng
                                request.setAttribute("ERROR", "Your role is invalid!");
                            }
                    }
                } else {//Nhắc nhở nhẹ nhàng
                    request.setAttribute("ERROR", "Your account is no longer active!");
                }
            } else {
                request.setAttribute("ERROR", "Invalid email or password!");
            }
        } catch (Exception e) {
            log("Error at Login Controller: " + e.toString());
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
