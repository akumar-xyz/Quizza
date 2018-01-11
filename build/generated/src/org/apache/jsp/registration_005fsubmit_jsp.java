package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.io.PrintWriter;
import java.sql.*;
import javax.sql.*;

public final class registration_005fsubmit_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html>\n");
      out.write("\t<head>\n");
      out.write("\t\t<title>\n");
      out.write("\t\t\tjsp connection\n");
      out.write("\t\t</title>\n");
      out.write("\t</head>\n");
      out.write("\t<body>\n");
      out.write("\t\t\n");
      out.write("\t\t\n");
      out.write("\n");
      out.write("\t\t");

		String USN=request.getParameter("usn");
		String password=request.getParameter("Password");
		String Name=request.getParameter("sname");
		String department=request.getParameter("department");
		String Semester = request.getParameter("semester");
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		java.sql.Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/quizza","root","root");
		String query="INSERT INTO students values(?,?,?,?,?)";
                PreparedStatement st=con.prepareStatement(query);
                st.setString(1, USN);
                st.setString(2, password);
                st.setString(3, Name);
                st.setString(4, department);
//                st.setInt(5,Integer.parseInt(Semester));
                st.setInt(5,2);
                
		PrintWriter out1=response.getWriter();
                out1.print("Count :"+st.executeUpdate());
                
//		if(rs.next())
//		{
//		out.println("Registered");
//		response.sendRedirect("index.html");
//		}
//		else
//		{
//		out.println("Error in registration");  
//		}
		
      out.write("\n");
      out.write("\t</body>\n");
      out.write("</html>\n");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
