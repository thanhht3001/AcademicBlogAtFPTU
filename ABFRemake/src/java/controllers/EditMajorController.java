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
@WebServlet(name = "EditMajorController", urlPatterns = {"/EditMajorController"})
public class EditMajorController extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            int check = 0;
            int majorID = Integer.parseInt(request.getParameter("majorID"));
            String majorName = request.getParameter("majorName");
            MajorDAO dao = new MajorDAO();
            List<MajorDTO> list = dao.getAllMajors();
            MajorDTO ma = dao.getMajorByID(majorID);
            boolean validate = true;
            int i = 0;
            for(MajorDTO major : list)
                if(major.getMajorName() != ma.getMajorName()){
                if(major.getMajorName().trim().equalsIgnoreCase(majorName.trim())){
                    i++;}}
            if(i != 0){
                request.setAttribute("DOUBLE_MAJOR", "Major Name is exist!");
                validate = false;
            }
            if(majorName.trim().length() == 0){
                request.setAttribute("MAJOR_INVALID", "Major Name is invalid!");
                validate= false;
            }
            if(validate){
            check = dao.editMajor(majorID, majorName);
            }else{
                request.setAttribute("MAJORID", majorID);
                request.setAttribute("MAJORNAME", majorName);
            }
            if ( check != 0 ){
                request.getRequestDispatcher("MainController?action=GetMajorList").forward(request, response);
            }else{
                request.getRequestDispatcher("editmajorfail.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(EditMajorController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EditMajorController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(EditMajorController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(EditMajorController.class.getName()).log(Level.SEVERE, null, ex);
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
