<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width" />
		<title>Adding a new Department</title>
		<link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
	</head>
	<body>
		<%
		if(session.getAttribute("isAdmin") == null)
		response.sendRedirect("AdminLogin.jsp");
		%>

		<form action="Add_Department_submit.jsp" method="post" accept-charset="utf-8">
			<div class="card container focused" >

				<h3>Add a new department</h3>
				<input type="text" placeholder="Department Name" name="dept_name" required/>
				<input type="text" placeholder="Department Code" name="dept_code" required>

				<button type="submit">Add</button>
			</div>
		</form>
		<nav>
			<ul>
				<li><a href="AdminLogin.jsp">Back</a></li>
			</ul>
		</nav>
	</body>
</html>
