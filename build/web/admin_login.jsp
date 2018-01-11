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
            String username = request.getParameter("admin_usename");
            String password = request.getParameter("password");
            username.trim();
            
            if (username == null || password == null) {
                out.print("Invalid parameters ");
            }

            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");

            String query = "SELECT * from admins where name=? and pass=?";
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, username);
            st.setString(2, password);

            ResultSet rs = null;

            rs = st.executeQuery();

            if (rs.next()) {
                out.println("Succesful");
                
                session.setAttribute("isAdmin", "true");
                rs.close();
                con.close();
                response.sendRedirect("adminpage.jsp");
            } else {
                out.println("failed");
                rs.close();
                st.close();
                con.close();
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
