<%@page import="quizza.Question"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Taking the quiz</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
        <style type="text/css" media="all">
            #questionpaper {
                width: 50%;
            }

        </style>
    </head>
    <body>
        <div class="container card focused">
            <h3>
                All the best!
            </h3>
        </div>
        <form action="evaluate" method="post">
            <div id="questionpaper" class="container card focused">
                <%
                    String quizNo = request.getParameter("quiz_no");
                    String subCode = request.getParameter("sub_code");
                %>
                <input type="hidden" value="<%= subCode%>" name="sub_code" />
                <input type="hidden" value="<%= quizNo%>" name="quiz_no" />

                <%

                    ArrayList<Question> questions = (ArrayList<Question>) request.getAttribute("qlist");
                    if (questions != null) {
                        int i = 1;
                        for (Question q : questions) {
                            String qStatement = q.getQuestionsStatement();
                            String[] optionList = q.getOptions();
                %>
                <div class="information">
                    <div class="container">
                        <em> <%= i%>. </em><%= qStatement%>
                    </div>
                    <%
                        int j = 1;
                        for (String op : optionList) {
                            String ans = op.split("@", 2)[1];
                    %>
                    <div class="container">
                        <label for="op<%= i%><%= j%>">
                            <input type="radio" name="q<%= i%>" value="<%= op%>" id="op<%= i%><%= j%>"/>
                            <%= ans%>
                        </label>
                    </div>
                        
                    <%
                            j++;
                        }
                    %>
                    <hr>
                </div>
                <%
                            i++;
                        }

                    }

                %>
                <button type="submit">
                    Submit
                </button>
            </div>

        </form>
    </body>
</html>
