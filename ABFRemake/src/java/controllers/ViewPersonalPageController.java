/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.BlogDAO;
import dto.BlogDTO;
import dto.SubjectDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author To DELL
 */
@WebServlet(name = "ViewPersonalPageController", urlPatterns = {"/ViewPersonalPageController"})
public class ViewPersonalPageController extends HttpServlet {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "personalpage.jsp";

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
            int userID = Integer.parseInt(request.getParameter("userID"));
            String strMajorID = request.getParameter("majorID");
            String strSubjectID = request.getParameter("subjectID");
            List<BlogDTO> listAllBlogs = dao.getAllPersonalBlogs(userID);//Lấy hết các blog
            if (listAllBlogs.size() > 0) {
                List<BlogDTO> listAllPopularBlogs = new ArrayList<>();
                for (BlogDTO blog : listAllBlogs) {
                    if (blog.getStatus().equals("approved")) {
                        listAllPopularBlogs.add(blog);
                    }
                }
                Collections.sort(listAllPopularBlogs, new Comparator<BlogDTO>() {
                    @Override
                    public int compare(BlogDTO o1, BlogDTO o2) {
                        return o2.getNumberOfVotes() - o1.getNumberOfVotes();
                    }
                });
                if (strMajorID != null) {
                    List<BlogDTO> listAllBlogsByMajor = new ArrayList<>();
                    int majorID = Integer.parseInt(strMajorID);
                    HttpSession session = request.getSession();
                    List<SubjectDTO> listSubject = (List<SubjectDTO>) session.getAttribute("LIST_SUBJECT");
                    for (BlogDTO blog : listAllBlogs) {
                        for (SubjectDTO subject : listSubject) {
                            if (blog.getSubjectID() == subject.getSubjectID()) {
                                if (majorID == subject.getMajorID()) {
                                    listAllBlogsByMajor.add(blog);
                                }
                            }
                        }
                    }
                    Collections.sort(listAllBlogsByMajor, BlogDTO.compareDate);
                    request.setAttribute("LIST_ALL_BLOGS_BY_MAJOR_OR_SUBJECT", listAllBlogsByMajor);
                } else if (strSubjectID != null) {
                    List<BlogDTO> listAllBlogsBySubject = new ArrayList<>();
                    int subjectID = Integer.parseInt(strSubjectID);
                    for (BlogDTO blog : listAllBlogs) {
                        if (blog.getSubjectID() == subjectID) {
                            listAllBlogsBySubject.add(blog);
                        }
                    }
                    Collections.sort(listAllBlogsBySubject, BlogDTO.compareDate);
                    request.setAttribute("LIST_ALL_BLOGS_BY_MAJOR_OR_SUBJECT", listAllBlogsBySubject);
                }
                Collections.sort(listAllBlogs, BlogDTO.compareDate);
                request.setAttribute("LIST_ALL_PERSONAL_BLOGS", listAllBlogs);
                request.setAttribute("LIST_ALL_POPULAR_BLOGS", listAllPopularBlogs);

            }
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at View Personal Page Controller: " + e.toString());
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
