<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
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
            String qid = request.getParameter("quizID").toString();
            Integer quizID = Integer.parseInt(qid);
            String sub = session.getAttribute("sub_code").toString();
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
            String query = "SELECT * from subjects where subject_code=?";
            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, sub);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Integer noOfQuizzes = rs.getInt("no_of_quizzes");
                if (quizID > noOfQuizzes || quizID < 1) {
                    out.println("<h1> This quiz has not been created yet.. </h1>");
                    response.setHeader("Refresh", "3; URL=FacultyDashboard.jsp");
                } else {


        %>
        <form id="question" action="question_submit.jsp" method="post">
            <div class="container card focused">
                <input type="hidden" name="quizID" value="<%=qid%>"/>
                Entering Questions for quiz <em><%= qid%></em>
                <textarea name="Questions" rows="8" cols="60" placeholder="Enter the question here" id="question" required></textarea>
                <!--<div class="container">-->
                <input type="text" name="correctAnswer" id="correctAnswer" value="" placeholder="Correct Answer" required/>
                <input type="text" name="option2" id="option2" value="" placeholder="Option 2" required/>
                <input type="text" name="option3" id="option3" value="" placeholder="Option 3" required/>
                <input type="text" name="option4" id="option4" value="" placeholder="Option 4" required/>

                <!--</div>-->
                <button type="submit">Add Question</button>
                <div class="container">
                    <em>Note :</em> During the test, these options will be shuffled for the students
                </div>
            </div>

        </form>
        <div class="container card focused information">
            <%
                query = "SELECT * FROM questions WHERE sub_code=? and quiz_number=?";
                st = con.prepareStatement(query);
                st.setString(1, sub);
                st.setString(2, qid);
                rs = st.executeQuery();
                if (rs.next() == false) {
            %>
            <h1>No Question added</h1>        
            <%
            } else {
            %>
            <h3>The questions added are : </h3>
            <div class="information">
                <table>
                    <% int i = 1;
                        do {
                            String qu = rs.getString("question");
                            String o1 = rs.getString("answer");
                            String o2 = rs.getString("option_2");
                            String o3 = rs.getString("option_3");
                            String o4 = rs.getString("option_4");
                    %>
                    <tr>
                        <td colspan="4">
                            <b><%= i%>.</b>  <%= qu%>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Answer :</b> <%=o1%></td>
                        <td><%=o2%></td>
                        <td><%=o3%></td>
                        <td><%=o4%></td>
                    </tr>
                    <%
                            i++;
                        } while (rs.next());
                    %>
                </table>
            </div>
            <%
                if(i<=10){
                    %>
                    <h3>
                        Please add atleast 10 questions
                    </h3>
                    <%
                }
                }
            %>
        </div>
        <nav>
            <ul>
                <!--<a href="#home" class="active">Home</a>-->    
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

            } else {
                out.println("Error.. Quiz does not exist");
                rs.close();
                st.close();
                con.close();

            }
        %>
    </body>
</html>
