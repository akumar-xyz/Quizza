<%-- 
    Document   : admin_login
    Created on : 08-Nov-2017, 00:44:21
    Author     : akumar
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Verifying your credentials</title>
    </head>
    <body>
        <%
            String username = request.getParameter("Subject_Code");
            String password = request.getParameter("password");
            
            out.println("Checking login<br>");
            if (username == null || password == null) {

                out.print("Invalid parameters ");
            }

            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");

            String query = "SELECT * from subjects where subject_code=? and subject_passkey=?";
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, username.toUpperCase().trim());
            st.setString(2, password);

            ResultSet rs = null;

            rs = st.executeQuery();

            if (rs.next()) {
                out.println("Succesful");
                rs.close();
                st.close();
                con.close();
                session.setAttribute("isFaculty", "true");
                session.setAttribute("sub_code", username.toUpperCase().trim());
                response.sendRedirect("FacultyDashboard.jsp");
            } else {
                rs.close();
                st.close();
                con.close();
                out.println("failed");
            }

            // Here you put the check on the username and password
//                if (username.toLowerCase().trim().equals("admin") && password.toLowerCase().trim().equals("admin")) {
//                    out.println("Welcome " + username + " <a href=\"index.jsp\">Back to main</a>");
//                    session.setAttribute("username", username);
//                } else {
//                    out.println("Invalid username and password");
//                }
%>

    </body>
</html>
