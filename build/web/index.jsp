<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width" />
        <title>Login Page</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
    </head>

    <body>
        <%
            if (session.getAttribute("isStudent") != null) {
                response.sendRedirect("StudentDashboard.jsp");
            }
            
            if (session.getAttribute("isAdmin") != null) {
                response.sendRedirect("adminpage.jsp");
            }
            
            if (session.getAttribute("isFaculty") != null) {
                response.sendRedirect("FacultyDashboard.jsp");
            }
        %>
        <form action="student_login_submit.jsp" method="post" accept-charset="utf-8">
            <div class="container card focused" >

                <input type="text" placeholder="Enter USN" name="USN" pattern="[0-9][A-Za-z]{2}[0-9]{2}[A-Za-z]{2}[0-9]{3}" required>

                <input type="password" placeholder="Enter Password" name="password" required>

                <button type="submit">Login</button>

                <div class="focused">
                    Or, <a href="register.jsp">click here</a> to register
                </div>

            </div>
            <nav>
                <ul>
                    <li><a href="FacultyLogin.jsp">Faculty Login</a></li>   
                    <li><a href="AdminLogin.jsp">Admin Page</a></li>
                </ul>
            </nav>
        </form>
    </body>
</html>
