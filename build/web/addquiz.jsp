<%-- 
    Document   : addquiz
    Created on : 16-Nov-2017, 16:49:52
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
        <title>Adding a new Quiz...</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />

    </head>
    <body>
        <%
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
            String subcode = session.getAttribute("sub_code").toString();
            String query = "SELECT no_of_quizzes from subjects where subject_code=?";
            Integer noOfQuizzes;
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, subcode);
            ResultSet rs = st.executeQuery();
            rs.next();
            noOfQuizzes = rs.getInt("no_of_quizzes");
            query = "UPDATE subjects set no_of_quizzes=no_of_quizzes+1 where subject_code=?";
            st = con.prepareStatement(query);
            st.setString(1, subcode);
            st.executeUpdate();
            noOfQuizzes++;
//            query = "INSERT INTO quiz VALUES (?,?)";
//            st = con.prepareStatement(query);
//            st.setString(1, subcode);
//            st.setInt(2, noOfQuizzes);
//            st.executeUpdate();
            request.setAttribute("quizNo", noOfQuizzes);
            rs.close();
            st.close();
            con.close();
            response.sendRedirect("addq.jsp?quizID=" + noOfQuizzes + "");
        %>
        <h1>No of Quizzes = <%=noOfQuizzes%></h1>
    </body>
</html>
