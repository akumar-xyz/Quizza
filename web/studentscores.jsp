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
            try {
        %>
        <%
            String sub = session.getAttribute("sub_code").toString();

            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
            String query = "SELECT * from subjects where subject_code=?";

            PreparedStatement st = con.prepareStatement(query);

            st.setString(1, sub);
            ResultSet rs = st.executeQuery();

            Integer noOfQuizzes;

            rs.next();

            noOfQuizzes = rs.getInt("no_of_quizzes");

            if (noOfQuizzes < 1) {
                out.println("<h2>No quiz has beed added..</h2>");
                response.setHeader("Refresh", "3; URL=addquiz.jsp");
            } else {

        %>
        <form action="check_scores.jsp" method="post">
            <div class="container card focused">
                <h3>Cheking the scores</h3>
                <select name="qno">
                    <option value="" disabled selected>Select the quiz number</option>
                    <%                        
                        int i = 1;
                        while (i <= noOfQuizzes) {
                    %>
                    <option value="<%=i%>" > <%=i%> </option>
                    <%
                            i++;
                        }
                    %>
                </select>
                <button type="submit">Check Scores</button>
            </div>

        </form>

        <nav>
            <ul>
                <!--<a href="#home" studentscoresclass="active">Home</a>-->    
                <!--<li><a href="logout.jsp">Logout</a></li>-->
                <li><a href="logout.jsp">Logout</a></li>   
                <li><a href="FacultyDashboard.jsp">Done</a></li>
            </ul>
        </nav>
        <%
                    rs.close();
                    st.close();
                    con.close();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </body>
</html>
