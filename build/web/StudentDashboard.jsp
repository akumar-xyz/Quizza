<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Dashboard</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
    </head>
    <body>
        <%
            if (session.getAttribute("isAdmin") != null) {
                response.sendRedirect("adminpage.jsp");
            }
            if (session.getAttribute("isFaculty") != null) {
                response.sendRedirect("FacultyDashboard.jsp");
            }
            if (session.getAttribute("isStudent") == null) {
                response.sendRedirect("index.jsp");
            }
        %>
        <div class="container card focused">

            <%
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
                String query = "call spGetQuizzes(?);";
                String usn = session.getAttribute("USN").toString();
                PreparedStatement st = con.prepareStatement(query);
                st.setString(1, usn);
                ResultSet rs = st.executeQuery();
            %>
            <h3>
                Hello <%= usn%>!
            </h3>
            <h3>
                The quizzes available to you are : 
            </h3>


            <%
                if (rs.next() == false) {
                    out.print("Well.. none. Try again later..");
                } else {
            %>
            <div class="container information">
                <table>
                    <%
                        do {
                            String subCode = rs.getString("subject_code");
                            String subName = rs.getString("subject_name");
                            Integer quizNo = rs.getInt("quiz_no");
                    %>
                    <tr>
                        <td>
                            <%= subCode%>
                        </td>
                        <td>
                            <%= subName%>
                        </td>
                        <td>
                            Quiz - <%= quizNo%>
                        </td>
                        <td>
                            <form action="allthebest" method="post">
                                <input type="hidden" value="<%= subCode%>" name="sub_code" />
                                <input type="hidden" value="<%= quizNo%>" name="quiz_no" />
                                <div class="container">
                                    <button type="submit">
                                        Take quiz
                                    </button>
                                </div>
                            </form>
                        </td>
                    </tr>
                    <%
                        } while (rs.next());
                    %>  
                </table>
            </div>
            <%
                rs.close();
                st.close();
                con.close();
                }

            %>
        </div>
        <nav>
            <ul>
                <li><a href="logout.jsp">Logout</a></li>   
            </ul>
        </nav> 

    </body>
</html>
