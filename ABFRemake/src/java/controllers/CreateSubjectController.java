/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.SubjectDAO;
import dto.SubjectDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author To Quyen Phan
 */
@WebServlet(name = "CreateSubjectController", urlPatterns = {"/CreateSubjectController"})
public class CreateSubjectController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private static final String ERROR = "subject.jsp";
    private static final String SUCCESS = "MainController?action=GetSubjectList";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String subjectName = request.getParameter("subjectName");
            int majorID = Integer.parseInt(request.getParameter("majorID"));
            SubjectDAO dao = new SubjectDAO();
            List<SubjectDTO> list = dao.getSubjectByMajorID(majorID);
            boolean validate = true;
            int i = 0;
            for(SubjectDTO subject: list )
                if(subject.getSubjectName().trim().equalsIgnoreCase(subjectName.trim()))
                    i++;              
            if(i != 0){
                validate = false;
                request.setAttribute("DOUBLE_SUBJECT","Subject Name is exist!");
            }
            if(subjectName.trim().length() == 0){
                validate= false;
                request.setAttribute("SUBJECT_INVALID","Subject Name is invalid!");
            } 
            boolean check = false;
            if(validate){
            check = dao.createSubject(subjectName, majorID);
            }else{
                request.setAttribute("SUBJECTNAME", subjectName);
                request.setAttribute("MAJORID", majorID);
            }
            if ( check ){
                request.getRequestDispatcher("MainController?action=GetSubjectList&majorID="+majorID).forward(request, response);
            }else{
                request.getRequestDispatcher("createsubject.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreateSubjectController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CreateSubjectController.class.getName()).log(Level.SEVERE, null, ex);
        }
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
