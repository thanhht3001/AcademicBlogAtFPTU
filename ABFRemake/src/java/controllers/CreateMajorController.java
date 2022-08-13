/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.MajorDAO;
import dto.MajorDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author To Quyen Phan
 */
@WebServlet(name = "CreateMajorController", urlPatterns = {"/CreateMajorController"})
public class CreateMajorController extends HttpServlet {
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
        try {
            String majorName = request.getParameter("majorName");          
            MajorDAO dao = new MajorDAO();
            List<MajorDTO> list = dao.getAllMajors();
            boolean validate = true;
            int i = 0;
            for(MajorDTO major : list)
                if(major.getMajorName().trim().equalsIgnoreCase(majorName.trim())){
                    i++;}
            if(i != 0){
                request.setAttribute("DOUBLE_MAJOR", "Major Name is exist!");
                validate = false;
            }
            if(majorName.trim().length() == 0){
                request.setAttribute("MAJOR_INVALID", "Major Name is invalid!");
                validate= false;
            }
            boolean check = false;
            if(validate){
            check = dao.createMajor( majorName);
            }else{
                request.setAttribute("MAJORNAME", majorName);
            }
            if ( check ){
                request.getRequestDispatcher("MainController?action=GetMajorList").forward(request, response);
            }else{
                request.getRequestDispatcher("createmajor.jsp").forward(request, response);
            }
        } catch (Exception e) {
            log("Error at Create Major Controller: " + e.toString());
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
