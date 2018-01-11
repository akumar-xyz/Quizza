<%-- 
Document   : registration_submit.jsp
Created on : 04-Nov-2017, 15:40:57
Author     : akumar
--%>

<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>
            Adding the department
        </title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />

    </head>
    <body>
        <%@ page import="java.sql.*"%>
        <%@ page import="javax.sql.*"%>

        <%
            if (session.getAttribute("isAdmin") != null || session.getAttribute("isAdmin").equals("true")) {
                String adminUser = request.getParameter("admin_user");
                String adminPass = request.getParameter("admin_pass");

                Class.forName("com.mysql.jdbc.Driver").newInstance();
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
                String query = "INSERT INTO admins values(?,?)";
//		out.print("name : " + Name);
                PreparedStatement st = con.prepareStatement(query);
                st.setString(1, adminUser);
                st.setString(2, adminPass);

                if (st.executeUpdate() == 1) {
                    st.close();
                    con.close();
                    out.println("<h1>The admin " + adminUser + " was added</h1>");
                    response.setHeader("Refresh", "3; URL=adminpage.jsp");
                } else {
                    st.close();
                    con.close();
                    out.println("<h1>Error: Does the department already exist?</h1>");
                }
            }
        %>
    </body>
</html>
