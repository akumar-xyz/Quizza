<%-- 
    Document   : check_scores
    Created on : 23-Nov-2017, 10:44:53
    Author     : akumar
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Scores</title>
        <link rel="stylesheet" href="css/style.css" type="text/css" media="all" />
        <script type="text/javascript">
            function PrintElem(elem)
            {
                Popup($(elem).html());
            }

            function Popup(data)
            {
                var mywindow = window.open('', 'my div', 'height=400,width=600');
                mywindow.document.write('<html><head><title></title>');
                /*optional stylesheet*/ //mywindow.document.write('<link rel="stylesheet" href="main.css" type="text/css" />');
                mywindow.document.write('</head><body style="direction:rtl;"><pre>');
                mywindow.document.write(data);
                mywindow.document.write('</pre></body></html>');
                mywindow.document.close();
                mywindow.print();
                return true;
            }
        </script>
        <script type="text/javascript">
            function printData()
            {
                var divToPrint = document.getElementById("printTable");
                newWin = window.open("");
                newWin.document.write(divToPrint.outerHTML);
                newWin.print();
                newWin.close();
            }
        </script>

    </head>
    <body>
        <%
            String subCode = session.getAttribute("sub_code").toString();
            Integer quizNO = Integer.parseInt(request.getParameter("qno"));
            java.sql.Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza", "root", "root");
            String query = "SELECT sc.usn, st.name, sc.score"
                    + " from scores sc, students st"
                    + " where subject_code=? and quiz_no = ?"
                    + " and sc.usn = st.usn "
                    + " order by usn";

            PreparedStatement st = con.prepareStatement(query);
            st.setString(1, subCode);
            st.setInt(2, quizNO);
            ResultSet rs = st.executeQuery();


        %>
        <div class="container card focused">
            <%                if (rs.next()) {
                    int i = 1;
            %>

            <h3>
                The students' scores for quiz <%= quizNO%> : 
            </h3>
            <table id="printTable">
                <tr>
                    <th>
                        Sl. No
                    </th>
                    <th>
                        USN
                    </th>
                    <th>
                        Name
                    </th>
                    <th>
                        Score
                    </th>
                </tr>
                <%
                    do {
                        String usn = rs.getString("USN");
                        String name = rs.getString("name");
                        Integer Score = rs.getInt("score");
                %>
                <tr>
                    <td>
                        <%= i%>
                    </td>
                    <td>
                        <%= usn%> 
                    </td>
                    <td>
                        <%= name%>
                    </td>
                    <td>
                        <%= Score%>
                    </td>
                </tr>
                <%
                        i++;
                    } while (rs.next());
                %>
            </table>

            <button onclick="PrintElem(printTable);">
                Print
            </button>
            <%
            } else {
            %>
            <h3>
                No scores added
            </h3>
            <%
                }

                rs.close();
                st.close();
                con.close();
            %>

        </div>


        <nav>
            <ul>
                <li><a href="logout.jsp">Logout</a></li>   
                <li><a href="FacultyDashboard.jsp">Back</a></li>   
            </ul>
        </nav> 
        <!--<h1>Hello World!</h1>-->
    </body>
</html>
