
import com.mysql.jdbc.PreparedStatement;
import static java.lang.System.out;
import javax.sql.*;
import java.sql.*;

public class Register_student
{
  public static void main(String[] args) throws ClassNotFoundException, InstantiationException, IllegalAccessException, SQLException {
//   String USN=request.getParameter("usn");
//		String password=request.getParameter("Password");
//		String Name=request.getParameter("sname");
//		String department=request.getParameter("department");
//		String Semester = request.getParameter("semester");
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		java.sql.Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza","root","root");
		String query="INSERT INTO students values(?,?,?,?,?)";
                PreparedStatement st=(PreparedStatement) con.prepareStatement(query);
                st.setString(1, "Abc");
                st.setString(2, "BCS");
                st.setString(3, ":HH");
                st.setString(4, "gvg");
//                st.setInt(5,Integer.parseInt(Semester));
                st.setInt(5,2);
                
//		PrintWriter out1=response.getWriter();
                out.print("Count :"+st.executeUpdate());
}
  
}