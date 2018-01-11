/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
@WebServlet(urlPatterns = {"/evaluate"})
public class evaluate extends HttpServlet {

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
            out.println("<title>Evaluate</title>");
            out.println("<link rel=\"stylesheet\" href=\"css/style.css\" type=\"text/css\" media=\"all\" />");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Evaluating you score..</h1>");
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
        try (PrintWriter out = response.getWriter()) {
//        processRequest(request, response);
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
            String query;
            PreparedStatement st;
            ResultSet rs = null;
            HttpSession session = request.getSession();
            String usn = session.getAttribute("USN").toString();
            String subCode = request.getParameter("sub_code");
            Integer quizNo = Integer.parseInt(request.getParameter("quiz_no"));
            out.println(usn + " " + subCode + " " + quizNo);
            int Score = 0;

            for (int i = 1; i <= 10; i++) {
                String qanswer = request.getParameter("q" + i);
                out.println(qanswer);
                if (qanswer != null) {
                    String[] answer = qanswer.split("@", 2);
                    Integer qid = Integer.parseInt(answer[0]);
                    String ans = answer[1];
                    query = "SELECT * FROM questions WHERE question_id = ? and answer = ?";
                    st = con.prepareStatement(query);
                    st.setInt(1, qid);
                    st.setString(2, ans);
                    rs = st.executeQuery();
                    if (rs.next()) {
                        Score++;
                    }
                }
            }

            query = "UPDATE scores SET score = ? where usn = ? and subject_code = ? and quiz_no = ?";
            st = con.prepareStatement(query);
            st.setInt(1, Score);
            st.setString(2, usn);
            st.setString(3, subCode);
            st.setInt(4, quizNo);
            st.executeUpdate();
            out.println("<h3>Your score : " + Score + "</h3>");

            request.setAttribute("Score", Score);

            RequestDispatcher rd = request.getRequestDispatcher("result.jsp");
            rd.forward(request, response);
            rs.close();
            st.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
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
