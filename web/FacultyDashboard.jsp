<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
    </head>
    <body>
        <%
            if (session.getAttribute("isFaculty") == null) {
                response.sendRedirect("index.jsp");
            }

            if (session.getAttribute("isAdmin") != null) {
                response.sendRedirect("adminpage.jsp");
            }

            if (session.getAttribute("isStudent") != null) {
                response.sendRedirect("StudentDashboard.jsp");
            }

            String subCode = session.getAttribute("sub_code").toString();
        %>
        <div class="container card focused">
            <h3>
                <%= subCode%>
            </h3>
            <div class="options">
                <ul>
                    <li> <a href="addquestions.jsp">Add Questions</a>	</li>
                    <li> <a href="studentscores.jsp">Check the Students' Scores</a>     </li>
                    <li> <a href="addquiz.jsp">Add a new Quiz</a>	</li>
                </ul>
            </div>
        </form>
    </div>
    <nav>
        <ul>
            <li><a href="logout.jsp">Logout</a></li>   
            <li><a href="faculty_change_password.jsp">Change Password</a></li>
        </ul>
    </nav> 

</body>
</html>
