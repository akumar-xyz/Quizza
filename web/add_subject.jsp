<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width" />
        <title>Adding a new Subject</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />

        <script>

            function show_password() {
                var x = document.getElementById("sub_password");
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
        <form action="add_subject_submit.jsp" method="post"  accept-charset="utf-8">

            <div class="container card focused">
                <h3>Registration</h3>
                <input type="text" name="sub_code" id="sub_code" value="" placeholder="Enter the Subject Code" required/>

                <input type="text" name="subname" placeholder="Enter the subject Name" id="subname" required/>

                <select name="department" id="department" required>
                    <option value="" disabled selected>Select the Branch here</option>

                    <%
                        String query = "select * from departments";
                        PreparedStatement st = con.prepareStatement(query);
                        ResultSet rs = st.executeQuery();
                        while (rs.next()) {
                    %>
                    <option value="<%=rs.getString("dept_code")%>"><%=rs.getString("dept_name")%></option>
                    <% } %>

                </select>

                <input type="text" name="semester" placeholder="Semester Number" id="stname" required/>

                <input type="password" name="sub_password" id="sub_password" placeholder="Password for the Subject"  required/>
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
                <li><a href="index.jsp">Back</a></li>   
            </ul>
        </nav>
    </body>
</html>
