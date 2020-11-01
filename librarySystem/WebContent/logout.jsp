<%@ page contentType="text/html; charset=utf-8" language="java"
	 errorPage=""%>
<html>
  <head>
    <title>注销登录</title>
  </head>
    
  <body>
    <%
        //使session失效
        session.invalidate();
    %>
    <center>
        <h1>注销成功！</h1>
        3秒后跳转到登录页面
        <p>
        如果没有跳转，请点<a href="index.jsp">这里</a>
    <%
        response.sendRedirect("index.jsp");
    %>
    </center>
  </body>
</html>