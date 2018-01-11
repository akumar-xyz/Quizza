/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package quizza;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author akumar
 */
@WebServlet(name = "reset", urlPatterns = {"/reset"})
public class reset extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet reset</title>");
            out.println("<link rel=\"stylesheet\" href=\"css/style.css\" type=\"text/css\" media=\"all\" />");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet resetting </h1>");
            out.println("</body>");
            out.println("</html>");
            HttpSession session = request.getSession();

            if (session.getAttribute("isAdmin") != null) {
                Class.forName("com.mysql.jdbc.Driver").newInstance();

                try (java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root")) {
                    String query;
                    PreparedStatement st;

                    query = "DELETE FROM ";

                    st = con.prepareStatement(query + "scores");
                    st.executeUpdate();
                    st = con.prepareStatement(query + "questions");
                    st.executeUpdate();
                    st = con.prepareStatement(query + "students");
                    st.executeUpdate();
                    st = con.prepareStatement(query + "quiz");
                    st.executeUpdate();
                    st = con.prepareStatement(query + "subjects");
                    st.executeUpdate();
                    st = con.prepareStatement(query + "departments");
                    st.executeUpdate();                 
                    st = con.prepareStatement(query + "admins");
                    st.executeUpdate();

                    st = con.prepareStatement("INSERT INTO admins values( 'admin' , 'admin')");
                    st.executeUpdate();
                    st.close();
                    con.close();
                    session.invalidate();
                }
                response.setHeader("Refresh", "3; URL=index.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
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
