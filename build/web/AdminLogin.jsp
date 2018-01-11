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
		if(session.getAttribute("isAdmin") != null)
		response.sendRedirect("adminpage.jsp");
		%>

		<form action="admin_login.jsp" method="post" accept-charset="utf-8">
			<div class="card container focused" >


				<input type="text" placeholder="Enter Admin username" name="admin_usename" required/>
				<input type="password" placeholder="Enter Password" name="password" required>

				<button type="submit">Login</button>

			</div>
			<nav>
				<ul>
					<li><a href="index.jsp">Back to login</a></li>   
				</ul>
			</nav>
		</form>
	</body>
</html>
