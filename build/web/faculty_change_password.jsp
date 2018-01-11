<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width" />
        <title>Adding new Questions</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
    </head>
    <body>
        <%
            String sub = session.getAttribute("sub_code").toString();
        %>
        <form action="changePassword" method="post">
            <div class="container card focused">
                <h3>Changing your password</h3>
                <input type="hidden" name="sub_code" value="<%= sub%>"/>
                <input type="password" name="new_password" id="Opassword" placeholder="Please enter your current password"  required/>
                <input type="password" name="old_password" id="Npassword" placeholder="Please enter your new password"  required/>
                <a href="#" onclick="show_password()">Show New Password</a>

                <button type="submit">Change</button>
            </div>
        </form>

        <nav>
            <ul>
                <li><a href="logout.jsp">Logout</a></li>   
                <li><a href="FacultyDashboard.jsp">Back</a></li>
            </ul>
        </nav>
    </body>
</html>
