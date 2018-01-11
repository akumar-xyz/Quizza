/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import quizza.Question;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Collections;
import javax.servlet.RequestDispatcher;
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
@WebServlet(urlPatterns = {"/allthebest"})
public class allthebest extends HttpServlet {

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
            out.println("<title>Allthebest</title>");
            out.println("<link rel=\"stylesheet\" href=\"css/style.css\" type=\"text/css\" media=\"all\" />");
            out.println("</head>");
            out.println("<body>");
//            out.println("<h1>Servlet allthebest at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        try {
            PrintWriter out = response.getWriter();

            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
            HttpSession session = request.getSession();
            String usn = session.getAttribute("USN").toString();
            String subCode = request.getParameter("sub_code");
            Integer quizNo = Integer.parseInt(request.getParameter("quiz_no"));
            ResultSet rs;
//            out.println("<h1>Challo, 10 marks baksheesh</h1>");
            String query = "SELECT * FROM scores where usn = ? and subject_code = ? and quiz_no = ?";
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, usn);
            st.setString(2, subCode);
            st.setInt(3, quizNo);
            rs = st.executeQuery();
            if (rs.next() != false) {
                out.println("<h3>Looks like you've already taken this test...</h3>");
                response.setHeader("Refresh", "3; URL=StudentDashboard.jsp");

            } else {
                query = "INSERT into scores values(?,?,?,?)";
                st = con.prepareStatement(query);
                st.setString(1, usn);
                st.setString(2, subCode);
                st.setInt(3, quizNo);
                st.setInt(4, 0);
                int i = st.executeUpdate();
                out.println(i);
                query = "SELECT * FROM questions WHERE sub_code = ? and quiz_number = ? order by rand() limit 10 ";
                st = con.prepareStatement(query);
                st.setString(1, subCode);
                st.setInt(2, quizNo);
                rs = st.executeQuery();

                ArrayList<Question> qlist = new ArrayList<Question>();

                while (rs.next()) {
                    Question q = new Question(rs.getString("question_id"));
                    q.setQuestionStatement(rs.getString("question"));
                    q.addOption(rs.getString("answer"));
                    q.addOption(rs.getString("option_2"));
                    q.addOption(rs.getString("option_3"));
                    q.addOption(rs.getString("option_4"));
                    qlist.add(q);

                }
                
                Collections.shuffle(qlist);

                request.setAttribute("qlist", qlist);
                out.println("test");
                RequestDispatcher rd = request.getRequestDispatcher("takequiz.jsp");

//                out.println("<div class=\"container card focused\"><h3>All the best!</h3></div>");
//                out.println("<form method=\"post\" action=\"evaluate\">");
//                out.println("</form>");
                rd.forward(request, response);
            }
            rs.close();
            st.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
//        processRequest(request, response);

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
