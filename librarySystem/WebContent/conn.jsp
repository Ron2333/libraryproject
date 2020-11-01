<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*,util.Dcon" errorPage="" %>
<%
	/* String DBDRIVER = "oracle.jdbc.driver.OracleDriver";
//String DBURL = "jdbc:oracle:thin:@172.31.210.67:1521:ORCL"; //127.0.0.1为数据服务器主机IP地址，1521是端口号，ORCL是数据库实例名
String DBURL = "jdbc:oracle:thin:@38.63.132.200:1521:rmbdb";
//String DBURL = "jdbc:oracle:thin:@localhost:1521:ORCL";
//String DBUSER = "system";                               //数据库用户名
String DBUSER = "kcrx";
String DBPASS = "kcrx8888";                             //数据库用户密码 */
Connection conn = null;
try {
   /*  Class.forName(DBDRIVER).newInstance();
    conn = DriverManager.getConnection(DBURL,DBUSER,DBPASS);  */
    Dcon dc = new Dcon();
    conn=dc.getCon();
	}
catch(Exception e) {
    e.printStackTrace();
	//out.write("数据库连接失败！");
	response.sendRedirect("hint.jsp?errCode=1&errStr="+e);	
	}
%>