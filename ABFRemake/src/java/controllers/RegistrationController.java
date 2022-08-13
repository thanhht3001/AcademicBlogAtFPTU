/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.RegistrationDAO;
import dto.RegistrationDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
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
 * @author Bat
 */
@WebServlet(name = "RegistrationController", urlPatterns = {"/RegistrationController"})
public class RegistrationController extends HttpServlet {

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
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            Date dateFormat = new Date();           
            int userID = Integer.parseInt(request.getParameter("userID"));
            int subjectID = Integer.parseInt(request.getParameter("subjectID"));
            String certificate = request.getParameter("certificate");
            String date = sdf.format(dateFormat);
            List <RegistrationDTO> listRE = RegistrationDAO.getRegistrationByUserid(userID);
            boolean validate = true;
            int i=0;
            for(RegistrationDTO r : listRE){
            if(r.getSubjectID() == subjectID){
            i++;
            }
            }
            if(i != 0){
                validate = false;
                request.setAttribute("DOUBLE_REGISTRATRION", "Registration is already!");
            }
            if(certificate.trim().length() == 0){
                validate= false;
                request.setAttribute("CERTIFICATE_ERROR","Certificate is invalid!");
            }            
            if(validate){
            boolean check = RegistrationDAO.createRegistration(userID, subjectID, certificate, date);
            if (check) {
                request.setAttribute("REGIS_SUCCESS","You registered successfully! Please waif for admin to approve!");
                request.getRequestDispatcher("mentorregister.jsp").forward(request, response);
            }
        }else{
                request.getRequestDispatcher("mentorregister.jsp").forward(request, response);
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
            Logger.getLogger(RegistrationController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RegistrationController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(RegistrationController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(RegistrationController.class.getName()).log(Level.SEVERE, null, ex);
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
