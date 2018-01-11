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
            jsp connection
        </title>
    </head>
    <body>
        <%@ page import="java.sql.*"%>
        <%@ page import="javax.sql.*"%>

        <%
            String USN = request.getParameter("usn");
            String Password = request.getParameter("Spassword");
            String Name = request.getParameter("stname");
            String Department = request.getParameter("department");
            String Semester = request.getParameter("semester");
            Integer sem = Integer.parseInt(Semester, 10);
            USN = USN.toUpperCase();
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
            String query = "INSERT INTO students values(?,?,?,?,?)";
//		out.print("name : " + Name);
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, USN);
            st.setString(2, Name);
            st.setString(3, Password);
            st.setString(4, Department);
            //                st.setInt(5,Integer.parseInt(Semester));
            st.setInt(5, sem);

//		PrintWriter out1=response.getWriter();
            if (st.executeUpdate() == 1) {
                out.println("You have been registered successfully");
                st.close();
                con.close();
                response.sendRedirect("index.jsp");
            } else {
                st.close();
                con.close();
                out.println("Error: Have you already been registered?");
            }
        %>
    </body>
</html>
