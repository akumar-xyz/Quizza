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
            String deptName = request.getParameter("dept_name");
            String deptCode = request.getParameter("dept_code");
            deptName.trim();
            deptCode.trim().toUpperCase();
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
            String query = "INSERT INTO departments values(?,?)";
//		out.print("name : " + Name);
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, deptCode);
            st.setString(2, deptName);

            if (st.executeUpdate() == 1) {
                out.println("<h1>Department : " + deptName + " was added</h1>");
                out.println("<h2>The department code is " + deptCode + " </h2>");
                st.close();
                con.close();
                response.setHeader("Refresh", "3; URL=adminpage.jsp");
            } else {
                st.close();
                con.close();
                out.println("<h1>Error: Does the department already exist?</h1>");
            }
        %>
    </body>
</html>
