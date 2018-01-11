<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Score</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />

    </head>
    <body>
        <div class="container card focused">
            <h3>
                Your score is : <em><% String Score = request.getAttribute("Score").toString();%> <%= Score%></em>

            </h3>
        </div>
        <%
            response.setHeader("Refresh", "3; URL=StudentDashboard.jsp");
        %>
    </body>
</html>
