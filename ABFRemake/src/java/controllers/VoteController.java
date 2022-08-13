/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.ActivityDAO;
import dao.BlogDAO;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
@WebServlet(name = "VoteController", urlPatterns = {"/VoteController"})
public class VoteController extends HttpServlet {

    private static final String ERROR = "MainController?action=ViewBlogDetails";
    private static final String SUCCESS = "MainController?action=ViewBlogDetails";

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
                String strUserID = request.getParameter("userID");
                if (strUserID != null) {
                    int userID = Integer.parseInt(strUserID);
                    String strNumberOfVotes = request.getParameter("numberOfVotes");
                    if (strNumberOfVotes != null) {
                        int numberOfVotes = Integer.parseInt(strNumberOfVotes);
                        ActivityDAO dao = new ActivityDAO();
                        //Kiểm tra xem người dùng đã vote blog này chưa
                        boolean check = dao.findVoteActivity(blogID, userID);
                        BlogDAO blogDAO = new BlogDAO();
                        boolean checkUpdateActivity = false;
                        if (check) {//Nếu người dùng đã vote blog
                            numberOfVotes -= 1;
                            checkUpdateActivity = dao.deleteUpdate(blogID, userID);
                            request.setAttribute("VOTE_VALUE", "unvote");
                        } else {//Nễu người dùng chưa vote blog
                            numberOfVotes += 1;
                            //Thêm hoạt động người dùng vào database
                            Date dateNow = Calendar.getInstance().getTime();
                            DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
                            checkUpdateActivity = dao.updateActivity(blogID, userID, dateFormat.format(dateNow));
                            request.setAttribute("VOTE_VALUE", "voted");
                        }
                        if (checkUpdateActivity) {//Update lại số lượng vote
                            boolean checkUpdate = blogDAO.updateVote(blogID, numberOfVotes);
                            if (checkUpdate) {
                                url = SUCCESS;
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            log("Error at Get Activity List Controller: " + e.toString());
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
