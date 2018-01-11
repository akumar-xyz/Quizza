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
            Adding the new subject...
        </title>
    </head>
    <body>
        <%@ page import="java.sql.*"%>
        <%@ page import="javax.sql.*"%>

        <%
            String subCode = request.getParameter("sub_code");
            String subName = request.getParameter("subname");
            String department = request.getParameter("department");
            String semester = request.getParameter("semester");
            String Password = request.getParameter("sub_password");
            Integer sem = Integer.parseInt(semester, 10);
            Integer numberOfQuizzes = 0; //number of subjects is always 0 at the beginning
            subCode = subCode.toUpperCase();
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
            String query = "INSERT INTO subjects values(?,?,?,?,?,?)";

//		out.print("name : " + Name);
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, subCode);
            st.setString(2, subName);
            st.setString(3, department);
            st.setInt(4, sem);
            st.setString(5, Password);
            st.setInt(6, numberOfQuizzes);

//		PrintWriter out1=response.getWriter();
            if (st.executeUpdate() == 1) {
                out.println("The subject has been registered successfully");
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
