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
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
    </head>
    <body>
        <%
            String usn = request.getParameter("USN");
            usn = usn.toUpperCase();
            String password = request.getParameter("password");

            if (usn == null || password == null) {

                out.print("Invalid parameters ");
            }

            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");

            String query = "SELECT * from students where usn=? and password=?";
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, usn);
            st.setString(2, password);

            ResultSet rs = null;

            rs = st.executeQuery();

            if (rs.next()) {
//                out.println("Succesful");
                rs.close();
                con.close();
                session.setAttribute("isStudent", "true");
                session.setAttribute("USN", usn);
                response.sendRedirect("StudentDashboard.jsp");
            } else {
                out.println("<h1>:(</h1>"
                        + "<h2>Oops!</h2>"
                        + "<h2>Something went wrong.. </h2>"
                        + "<a href=\"index.jsp\">Click here</a> to go back");
                rs.close();
                st.close();
                con.close();

            }
        %>

    </body>
</html>
