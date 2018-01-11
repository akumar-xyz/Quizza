
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
    </head>
    <body>
        <%
            String qid = request.getParameter("quizID");
            String subCode = session.getAttribute("sub_code").toString();
            String question = request.getParameter("Questions");
            String option1 = request.getParameter("correctAnswer");
            String option2 = request.getParameter("option2");
            String option3 = request.getParameter("option3");
            String option4 = request.getParameter("option4");
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
            String query = "INSERT INTO questions (sub_code, quiz_number, question, answer, option_2, option_3, option_4) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, subCode);
            st.setInt(2, Integer.parseInt(qid));
            st.setString(3, question);
            st.setString(4, option1);
            st.setString(5, option2);
            st.setString(6, option3);
            st.setString(7, option4);
            
            if(st.executeUpdate() == 1)
            {
                response.sendRedirect("addq.jsp?quizID=" + qid + "");
                out.println("Question was successfully added!");
            }
        
            st.close();
            con.close();
        %>

        <h1>Hello World!</h1>
    </body>
</html>
