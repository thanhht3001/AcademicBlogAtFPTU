/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.BlogDAO;
import dao.MajorDAO;
import dao.SubjectDAO;
import dto.BlogDTO;
import dto.MajorDTO;
import dto.SubjectDTO;
import java.io.IOException;
import java.io.Serializable;
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
 * @author To Quyen Phan
 */
@WebServlet(name = "GetBlogListController", urlPatterns = {"/GetBlogListController"})
public class GetBlogListController extends HttpServlet implements Serializable {

    private static final String ERROR = "error.jsp";
    private static final String SUCCESS = "homepage.jsp";

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
            List<BlogDTO> listAllBlogs = dao.getAllBlogs();//Lấy hết các blog
            List<BlogDTO> listNewestBlogs = dao.getAllBlogs();
            List<BlogDTO> listPopularBlogs = dao.getAllBlogs();
            Collections.sort(listPopularBlogs, new Comparator<BlogDTO>() {
                @Override
                public int compare(BlogDTO o1, BlogDTO o2) {
                    return o2.getNumberOfVotes() - o1.getNumberOfVotes();
                }
            });
            MajorDAO majorDAO = new MajorDAO();
            List<MajorDTO> listMajor = majorDAO.getAllMajors();//Lay ten major
            List<SubjectDTO> listSubject = SubjectDAO.getSubject();
            Collections.sort(listNewestBlogs, BlogDTO.compareDate);
            HttpSession session = request.getSession();
            if (listAllBlogs.size() > 0) {
//                String value = request.getParameter("sortBy");
//                String orderValue = request.getParameter("sortOrder");
//                if ("date".equals(value)) {//Nếu người dùng chọn sort by date
//                    if ("descending".equals(orderValue)) {//Sắp xếp theo giảm dần
//                        Collections.sort(listAllBlogs, BlogDTO.compareDate);
//                        request.setAttribute("ORDER_OPTION", "Descending");
//                    } else if ("ascending".equals(orderValue)) {//Sắp xếp tang dần
//                        Collections.sort(listAllBlogs, BlogDTO.compareDate);
//                        Collections.reverse(listAllBlogs);
//                        request.setAttribute("ORDER_OPTION", "Ascending");
//                    } else {
//                        request.setAttribute("ORDER_OPTION", "None");
//                    }
//                    request.setAttribute("OPTION", "Date");
//                } else if ("vote".equals(value)) {//Nếu người dùng chọn sort by vote
//                    if ("descending".equals(orderValue)) {//Sắp xếp giảm dần
//                        Collections.sort(listAllBlogs, new Comparator<BlogDTO>() {
//                            @Override
//                            public int compare(BlogDTO o1, BlogDTO o2) {
//                                return o2.getNumberOfVotes() - o1.getNumberOfVotes();
//                            }
//                        });
//                        request.setAttribute("ORDER_OPTION", "Descending");
//                    } else if ("ascending".equals(orderValue)) {//Sắp xếp tăng dần
//                        Collections.sort(listAllBlogs, new Comparator<BlogDTO>() {
//                            @Override
//                            public int compare(BlogDTO o1, BlogDTO o2) {
//                                return o1.getNumberOfVotes() - o2.getNumberOfVotes();
//                            }
//                        });
//                        request.setAttribute("ORDER_OPTION", "Ascending");
//                    } else {
//                        request.setAttribute("ORDER_OPTION", "None");
//                    }
//                    request.setAttribute("OPTION", "Vote");
//                } else {
//                    request.setAttribute("OPTION", "None");
//                }
                session.setAttribute("LIST_ALL_BLOGS", listAllBlogs);
                request.setAttribute("LIST_NEWEST_BLOGS", listNewestBlogs);
                session.setAttribute("LIST_POPULAR_BLOGS", listPopularBlogs);
                session.setAttribute("LIST_MAJOR", listMajor);
                session.setAttribute("LIST_SUBJECT", listSubject);
            }
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at Get List Controller: " + e.toString());
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
