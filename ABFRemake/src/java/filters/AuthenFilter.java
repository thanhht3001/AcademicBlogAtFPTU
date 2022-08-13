/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package filters;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import dao.UserDAO;
import dto.UserDTO;

/**
 *
 * @author To Quyen Phan
 */
@WebFilter(filterName = "AuthenFilter", urlPatterns = {"/*"})
public class AuthenFilter implements Filter {

    private static List<String> STUDENT_RESOURCES;
    private static List<String> ADMIN_RESOURCES;
    private static List<String> MENTOR_RESOURCES;
    private static List<String> NON_AUTHEN_RESOURCES;

    private static final String ADMIN = "Admin";
    private static final String STUDENT = "Student";
    private static final String MENTOR = "Mentor";

    private static final String WELCOME = "index.jsp";
    private static final String ERROR = "error.jsp";
    private static final String HOME_PAGE = "homepage.jsp";
    private static final String ADMIN_PAGE = "admin.jsp";
    private static final String FEEDBACK_PAGE = "feedback.jsp";
    private static final String PROFILE_PAGE = "profile.jsp";
    private static final String POST_BLOG_PAGE = "postblog.jsp";
    private static final String BLOG_DETAIL_PAGE = "blogdetail.jsp";
    private static final String ACTIVITY_PAGE = "activity.jsp";
    private static final String APPROVE_BLOG_PAGE = "approveblog.jsp";
    private static final String APPROVE_BLOG_DETAIL_PAGE = "approveblogdetail.jsp";
    private static final String MAJOR_PAGE = "major.jsp";
    private static final String SUBJECT_PAGE = "subject.jsp";
    private static final String MANAGEACCOUNT_PAGE = "manageaccount.jsp";
    private static final String VOTE_RATINGS_PAGE = "voteratings.jsp";
    private static final String CREATE_MAJOR_PAGE = "createmajor.jsp";
    private static final String CREATE_SUBJECT_PAGE = "createsubject.jsp";
    private static final String MENTOR_REGISTER_PAGE = "mentorregister.jsp";

    private static final boolean debug = true;

    // The filter configuration object we are associated with.  If
    // this value is null, this filter instance is not currently
    // configured. 
    private FilterConfig filterConfig = null;

    public AuthenFilter() {
        //Khai báo các Resource Admin được phép truy cập
        ADMIN_RESOURCES = new ArrayList<>();
        ADMIN_RESOURCES.add(ADMIN_PAGE);
        ADMIN_RESOURCES.add(PROFILE_PAGE);
        ADMIN_RESOURCES.add(MAJOR_PAGE);
        ADMIN_RESOURCES.add(SUBJECT_PAGE);
        ADMIN_RESOURCES.add(MANAGEACCOUNT_PAGE);
        ADMIN_RESOURCES.add(CREATE_MAJOR_PAGE);
        ADMIN_RESOURCES.add(CREATE_SUBJECT_PAGE);

        //Khai báo các Resource Student được phép truy cập
        STUDENT_RESOURCES = new ArrayList<>();
        STUDENT_RESOURCES.add(HOME_PAGE);
        STUDENT_RESOURCES.add(FEEDBACK_PAGE);
        STUDENT_RESOURCES.add(PROFILE_PAGE);
        STUDENT_RESOURCES.add(POST_BLOG_PAGE);
        STUDENT_RESOURCES.add(BLOG_DETAIL_PAGE);
        STUDENT_RESOURCES.add(ACTIVITY_PAGE);
        STUDENT_RESOURCES.add(MENTOR_REGISTER_PAGE);
        STUDENT_RESOURCES.add("SearchController");
        STUDENT_RESOURCES.add("PostBlogController");

        //Khai báo các Resource Mentor được phép truy cập
        MENTOR_RESOURCES = new ArrayList<>();
        MENTOR_RESOURCES.add(HOME_PAGE);
        MENTOR_RESOURCES.add(FEEDBACK_PAGE);
        MENTOR_RESOURCES.add(PROFILE_PAGE);
        MENTOR_RESOURCES.add(POST_BLOG_PAGE);
        MENTOR_RESOURCES.add(BLOG_DETAIL_PAGE);
        MENTOR_RESOURCES.add(APPROVE_BLOG_PAGE);
        MENTOR_RESOURCES.add(APPROVE_BLOG_DETAIL_PAGE);
        MENTOR_RESOURCES.add(ACTIVITY_PAGE);
        MENTOR_RESOURCES.add(VOTE_RATINGS_PAGE);
        MENTOR_RESOURCES.add(MENTOR_REGISTER_PAGE);
        MENTOR_RESOURCES.add("SearchController");
        MENTOR_RESOURCES.add("PostBlogController");

        //Khai báo các Resource ko cần xác thực, phân quyền 
        NON_AUTHEN_RESOURCES = new ArrayList<>();
        NON_AUTHEN_RESOURCES.add(WELCOME);
        NON_AUTHEN_RESOURCES.add("MainController");
        NON_AUTHEN_RESOURCES.add("LoginWithGoogleController");
        NON_AUTHEN_RESOURCES.add(".css");
        NON_AUTHEN_RESOURCES.add(".jpg");
        NON_AUTHEN_RESOURCES.add(".gif");
        NON_AUTHEN_RESOURCES.add(".png");
        NON_AUTHEN_RESOURCES.add(".jpeg");
        NON_AUTHEN_RESOURCES.add(".js");

    }

    private void doBeforeProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoBeforeProcessing");
        }

        // Write code here to process the request and/or response before
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log items on the request object,
        // such as the parameters.
        /*
	for (Enumeration en = request.getParameterNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    String values[] = request.getParameterValues(name);
	    int n = values.length;
	    StringBuffer buf = new StringBuffer();
	    buf.append(name);
	    buf.append("=");
	    for(int i=0; i < n; i++) {
	        buf.append(values[i]);
	        if (i < n-1)
	            buf.append(",");
	    }
	    log(buf.toString());
	}
         */
    }

    private void doAfterProcessing(ServletRequest request, ServletResponse response)
            throws IOException, ServletException {
        if (debug) {
            log("AuthenFilter:DoAfterProcessing");
        }

        // Write code here to process the request and/or response after
        // the rest of the filter chain is invoked.
        // For example, a logging filter might log the attributes on the
        // request object after the request has been processed. 
        /*
	for (Enumeration en = request.getAttributeNames(); en.hasMoreElements(); ) {
	    String name = (String)en.nextElement();
	    Object value = request.getAttribute(name);
	    log("attribute: " + name + "=" + value.toString());

	}
         */
        // For example, a filter might append something to the response.
        /*
	PrintWriter respOut = new PrintWriter(response.getWriter());
	respOut.println("<P><B>This has been appended by an intrusive filter.</B>");
         */
    }

    /**
     *
     * @param request The servlet request we are processing
     * @param response The servlet response we are creating
     * @param chain The filter chain we are processing
     *
     * @exception IOException if an input/output error occurs
     * @exception ServletException if a servlet error occurs
     */
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;
            String uri = req.getRequestURI();
            int index = uri.lastIndexOf("/");
            String requestResource = uri.substring(index + 1);
            for (String resource : NON_AUTHEN_RESOURCES) {
                if (uri.contains(resource)) {
                    chain.doFilter(request, response);
                    return;
                }
            }
            HttpSession session = req.getSession();
            //Xác thực
            if (session == null || session.getAttribute("LOGIN_USER") == null) {
                res.sendRedirect(WELCOME);
            } else {
                //Phân quyền
                UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
                UserDAO dao = new UserDAO();
                if (ADMIN.equals(dao.checkRole(loginUser.getRoleID())) && ADMIN_RESOURCES.contains(requestResource)) {
                    chain.doFilter(request, response);
                } else {
                    if (STUDENT.equals(dao.checkRole(loginUser.getRoleID())) && STUDENT_RESOURCES.contains(requestResource)) {
                        chain.doFilter(request, response);
                    } else {
                        if (MENTOR.equals(dao.checkRole(loginUser.getRoleID())) && MENTOR_RESOURCES.contains(requestResource)) {
                            chain.doFilter(request, response);
                        }else{
                            res.sendRedirect(WELCOME);
                        }
                    }
                }
            }
        } catch (Exception e) {

        }
    }

    /**
     * Return the filter configuration object for this filter.
     */
    public FilterConfig getFilterConfig() {
        return (this.filterConfig);
    }

    /**
     * Set the filter configuration object for this filter.
     *
     * @param filterConfig The filter configuration object
     */
    public void setFilterConfig(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) {
        this.filterConfig = filterConfig;
        if (filterConfig != null) {
            if (debug) {
                log("AuthenFilter:Initializing filter");
            }
        }
    }

    /**
     * Return a String representation of this object.
     */
    @Override
    public String toString() {
        if (filterConfig == null) {
            return ("AuthenFilter()");
        }
        StringBuffer sb = new StringBuffer("AuthenFilter(");
        sb.append(filterConfig);
        sb.append(")");
        return (sb.toString());
    }

    private void sendProcessingError(Throwable t, ServletResponse response) {
        String stackTrace = getStackTrace(t);

        if (stackTrace != null && !stackTrace.equals("")) {
            try {
                response.setContentType("text/html");
                PrintStream ps = new PrintStream(response.getOutputStream());
                PrintWriter pw = new PrintWriter(ps);
                pw.print("<html>\n<head>\n<title>Error</title>\n</head>\n<body>\n"); //NOI18N

                // PENDING! Localize this for next official release
                pw.print("<h1>The resource did not process correctly</h1>\n<pre>\n");
                pw.print(stackTrace);
                pw.print("</pre></body>\n</html>"); //NOI18N
                pw.close();
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        } else {
            try {
                PrintStream ps = new PrintStream(response.getOutputStream());
                t.printStackTrace(ps);
                ps.close();
                response.getOutputStream().close();
            } catch (Exception ex) {
            }
        }
    }

    public static String getStackTrace(Throwable t) {
        String stackTrace = null;
        try {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            t.printStackTrace(pw);
            pw.close();
            sw.close();
            stackTrace = sw.getBuffer().toString();
        } catch (Exception ex) {
        }
        return stackTrace;
    }

    public void log(String msg) {
        filterConfig.getServletContext().log(msg);
    }

}
