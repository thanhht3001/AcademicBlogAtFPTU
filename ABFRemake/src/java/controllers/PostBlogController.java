/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.BlogDAO;
import dto.BlogError;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author To Quyen Phan
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "PostBlogController", urlPatterns = {"/PostBlogController"})
public class PostBlogController extends HttpServlet {

    private static final String ERROR = "postblog.jsp";
    private static final String SUCCESS = "MainController?action=ViewPersonalPage";
    public static final String UPLOAD_DIR = "uploads";//local save image
    public String dbFileName = "";

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
        BlogError blogError = new BlogError();
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        Date dateFormat = new Date();

        String applicationPath = getServletContext().getRealPath("");
        String uploadPath = applicationPath + File.separator + UPLOAD_DIR;

        try {
            int userID = Integer.parseInt(request.getParameter("userID"));
            int subjectID = Integer.parseInt(request.getParameter("subjectID"));
            String title = request.getParameter("title").trim();
            String content = request.getParameter("content").trim();
            String date = sdf.format(dateFormat);
            boolean checkValidation = false;
            Part part = request.getPart("file");
            String image = "";
            String fileName = extractFileName(part);//file name
            if ("".equals(fileName)) {
                blogError.setImageError("Please choose an image!");
                checkValidation = true;
            } else {
                image = UPLOAD_DIR + File.separator + fileName;
                File fileUploadDirectory = new File(uploadPath);
                if (!fileUploadDirectory.exists()) {
                    fileUploadDirectory.mkdirs();
                }
                String savePath = uploadPath + File.separator + fileName;
                part.write(savePath + File.separator);
                File fileSaveDir1 = new File(savePath);
                part.write(savePath + File.separator);
            }
            BlogDAO dao = new BlogDAO();
            if (title.length() < 10 || title.length() > 50) {
                blogError.setTitleError("Title must be in [10,50]!");
                checkValidation = true;
            }
            if (content.length() < 50) {
                blogError.setContentError("Content must be greater than 50!");
                checkValidation = true;
            }

            if (!checkValidation) {
                boolean check = dao.postBlog(userID, subjectID, title, content, date, image);
                if (check) {
                    url = SUCCESS;
                }
            } else {
                request.setAttribute("BLOG_ERROR", blogError);
                request.setAttribute("TITLE", title);
                request.setAttribute("CONTENT", content);
            }
        } catch (Exception e) {
            log("Error at Post Blog Controller: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    private String extractFileName(Part part) {//This method will print the file name.
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return "";
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
