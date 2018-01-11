<%@page import="java.io.PrintWriter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width" />
        <title>Administrator Page</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
    </head>
    <body>
        <% if (session.getAttribute("isAdmin") == null) {
                response.sendRedirect("AdminLogin.jsp");
            }
        %>


        <div class="card container focused">
            <h3>Operations</h3>
            <div class="options">
                <ul>
                    <li> <a href="add_department.jsp">Add a department</a>	</li>
                    <li> <a href="add_subject.jsp">Add a new Subject</a>	</li>
                    <li> <a href="add_admin.jsp">Add another admin</a>     </li>
                    <li> <a href="reset">Reset the Whole Database</a>     </li>
                </ul>
            </div>
        </div>

        <nav>
            <ul>
                <li><a href="logout.jsp">Logout</a></li>   
            </ul>
        </nav> 
    </body>
</html>
