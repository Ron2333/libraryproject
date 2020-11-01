
<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*,java.util.*" errorPage=""%>
<%@ include file="conn.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"> 

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
Properties properties = new Properties();
properties.load(this.getClass().getResourceAsStream("/db.properties"));

String titleName = new String(properties.getProperty("titleName"));
%>
<title><%=titleName %></title>
</head>
<%
String var_userID = "";
String var_userName = "";

if (request.getParameter("userID") != null
		&& request.getParameter("userID") != "") {
	var_userID = (String) request.getParameter("userID");
}

%>
<frameset rows="88,*" cols="*" frameborder="no" border="0" framespacing="0">
  <frame src="top.jsp" name="topFrame" scrolling="no" noresize="noresize" id="topFrame" title="topFrame" />
  <frameset cols="187,*" frameborder="no" border="0" framespacing="0">
    <frame src="left.jsp" name="leftFrame"  noresize="noresize" id="leftFrame" title="leftFrame" />
    <frame src="right.jsp" name="rightFrame" id="rightFrame" title="rightFrame" />
  </frameset>
</frameset>
<noframes>

<body>
</body></noframes>
</html>
