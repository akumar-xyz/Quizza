
<%
    String qno = request.getParameter("qno");
    response.sendRedirect("addq.jsp?quizID=" + qno + "");

%>