<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width" />
        <title>Adding a new Department</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
        <script>

            function show_password() {
                var x = document.getElementById("admin_pass");
                if (x.type === "password") {
                    x.type = "text";
                } else {
                    x.type = "password";
                }
            }
        </script>
    </head>
    <body>
        <%
            if (session.getAttribute("isAdmin") == null) {
                response.sendRedirect("AdminLogin.jsp");
            }
        %>

        <form action="Add_Admin_submit.jsp" method="post" accept-charset="utf-8">
            <div class="card container focused" >

                <h3>Enter details for the new admin</h3>
                <input type="text" placeholder="Username" name="admin_user" required/>
                <input type="password" placeholder="Password" name="admin_pass" id="admin_pass" required>
                <a href="#" onclick="show_password()">Show Password</a>
		<button type="submit">Add</button>

            </div>
            <nav>
                <ul>
                    <li><a href="AdminLogin.jsp">Back</a></li>
                </ul>
            </nav>
        </form>
    </body>
</html>
