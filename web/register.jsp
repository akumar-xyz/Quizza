<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width" />
        <title>Student Registration</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />

        <script>

            function show_password() {
                var x = document.getElementById("Spassword");
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
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
        %>
        <form action="registration_submit.jsp" method="post"  accept-charset="utf-8">

            <div class="container card focused">
                <h3>Registration</h3>
                <input type="text" name="usn" id="usn" value="" placeholder="Enter your USN" pattern="[0-9][A-Za-z]{2}[0-9]{2}[A-Za-z]{2}[0-9]{3}" required/>

                <input type="text" name="stname" placeholder="Enter your Name" id="stname" required/>

                <select name="department" id="department" required>
                    <option value="" disabled selected>Select your Branch here</option>

                    <%
                        String query = "select * from departments";
                        PreparedStatement st = con.prepareStatement(query);
                        ResultSet rs = st.executeQuery();
                        while (rs.next()) {
                    %>
                    <option value="<%=rs.getString("dept_code")%>"><%=rs.getString("dept_name")%></option>
                    <% } %>

                </select>

                <select name="semester" id="semester" required>
                    <option value="" disabled selected>Select your Semester</option>
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                    <option>6</option>
                    <option>7</option>
                    <option>8</option>
                </select>

                <input type="password" name="Spassword" id="Spassword" placeholder="Please enter your password"  required/>
                <a href="#" onclick="show_password()">Show Password</a>

                <button type="submit">Register</button>

            </div>
        </form>
        <%
                rs.close();
                st.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <nav>
            <ul>
                <li><a href="index.jsp">Back to login</a></li>   
            </ul>
        </nav>
    </body>
</html>
