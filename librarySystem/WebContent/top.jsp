
<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ include file="conn.jsp"%>
<%@page import="java.io.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
Properties properties = new Properties();
properties.load(this.getClass().getResourceAsStream("/db.properties"));
String logoImage = new String(properties.getProperty("logoImage"));
String titleName = new String(properties.getProperty("titleName"));
%>
<title><%=titleName %></title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="js/jquery.js"></script>
<script type="text/javascript">
$(function(){	
	//顶部导航切换
	$(".nav li a").click(function(){
		$(".nav li a.selected").removeClass("selected")
		$(this).addClass("selected");
	})	
})	
</script>
</head>
<%
String var_userID = "";
String var_userName = "";
PreparedStatement pstmt = null;
ResultSet rs = null;

HttpSession hs= request.getSession();
var_userName = hs.getAttribute("userName").toString();

%>
<body style="background:url(images/topbg.gif) repeat-x;">

    <div class="topleft">
    <a href="main.jsp?userID=<%=var_userID %>" target="_parent"><img src="images/<%=logoImage %>" title="系统首页" /></a>
    </div>
	
            
    <div class="topright">    
    <ul>
    <li><span><img src="images/help.png" title="帮助"  class="helpimg"/></span><a href="#">帮助</a></li>
    <li><a href="#">关于</a></li>
    <li><a href="passModify.jsp?loginName=<%=session.getAttribute("loginName") %>"  target="rightFrame">修改密码</a></li>
    <li><a href="logout.jsp" target="_parent">退出系统</a></li>
    </ul>
     
    <div class="user">
    <span><%=var_userName %></span>
    
    <i><div id="Clock" align="center" style="font-size: 15px; color:#fff"></div></i>
<script runat="server" language="javascript">
   function tick() {
   var hours, minutes, seconds, xfile;
   var intHours, intMinutes, intSeconds;
   var today, theday;
   today = new Date();
   function initArray(){
   this.length=initArray.arguments.length
   for(var i=0;i<this.length;i++)
   this[i+1]=initArray.arguments[i] }
   var d=new initArray(
   " 星期日",
   " 星期一",
   " 星期二",
   " 星期三",
   " 星期四",
   " 星期五",
   " 星期六");
   theday = today.getFullYear()+"年" + [today.getMonth()+1]+"月" +today.getDate()+"日" + d[today.getDay()+1];
   intHours = today.getHours();
   intMinutes = today.getMinutes();
   intSeconds = today.getSeconds();   
   if (intHours == 0) { hours = "24:"; 
   } else {
   hours = intHours + ":";
   }
   if (intMinutes < 10) {
   minutes = "0"+intMinutes+":";
   } else {
   minutes = intMinutes+":";
   }
   if (intSeconds < 10) {
   seconds = "0"+intSeconds+" ";
   } else {
   seconds = intSeconds+" ";
   }
   timeString = theday+" "+hours+minutes+seconds;
   Clock.innerHTML = timeString;
   window.setTimeout("tick();", 100);
   }
   window.onload = tick;
</script>
    </div>    
    
    </div>

</body>
</html>


