<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<%@page import="java.io.*,java.util.*"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%
Properties properties = new Properties();
properties.load(this.getClass().getResourceAsStream("/db.properties"));

String titleName = new String(properties.getProperty("titleName"));
String logoImage = new String(properties.getProperty("logoImage"));
%>
<title><%=titleName %></title>
<link href="<%=path %>/css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=path %>/js/jquery.js"></script>
<style>
	.systemlogo{background:url(images/<%=logoImage%>) no-repeat center;width:100%; height:71px; margin-top:75px;}
</style>
<script language="javascript">
	$(function(){
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
	$(window).resize(function(){  
    $('.loginbox').css({'position':'absolute','left':($(window).width()-692)/2});
    })  
});  
	
	function login(){
		var loginName = document.getElementById('loginName').value;
		if(loginName==null||loginName==""){alert("用户名不能为空!");return false;}
		var loginPWD = document.getElementById('loginPWD').value;
		if(loginPWD==null||loginPWD==""){alert("用户密码不能为空!");return false;}
		document.getElementById("search_form").submit();
	}
	function on_return(){
		 if(window.event.keyCode == 13){
		  if (document.all('loginbtn')!=null){
		   document.all('loginbtn').click();
		   }
		 }	
	}
</script> 

</head>
<body onkeydown="on_return();" style="background-color:#1c77ac; background-image:url(images/light.png); background-repeat:no-repeat; background-position:center top; overflow:hidden;">
<%
        //使session失效
        session.invalidate();
    %>
<%
 if (request.getAttribute("loginNameMessage")=="error") {
 %>
 <script>
 alert("用户名不存在!");
 </script>
 <%
 }
 %>
<%
 if (request.getAttribute("loginPWDMessage")=="error") {
 %>
 <script>
 alert("密码错误!");
 </script>
 <%
 }
 %>
 <%
 if (request.getAttribute("loginMessage")=="flag1") {
 %>
 <script>
 alert("使用过期!");
 </script>
 <%
 }
 %>
    <div id="mainBody">
      <div id="cloud1" class="cloud"></div>
      <div id="cloud2" class="cloud"></div>
    </div>  


<div class="logintop">    
    <span>欢迎登录<%=titleName %></span>    
    <ul>
    
    
    <li><a href="#">关于系统</a></li>
    </ul>    
    </div>
    
    <div class="loginbody">
    
    <span class="systemlogo">
    <%-- <img src="images/<%=logoImage %>" title="系统首页" /> --%>
    </span> 
       
    <div class="loginbox" >
    <form  method="post" action="indexlogin.jsp" id="search_form" name="search_form">
    <ul>
     <li><input id="loginName" name="loginName" type="text" class="loginuser" value=""/></li>
    <li><input id="loginPWD" name="loginPWD" type="password" class="loginpwd" value=""/></li>
    <li><input id="loginbtn" name="loginbtn" type="button" class="loginbtn" value="登录"  onclick="login();"  /><label>
  
    </ul>
    </form> 
    
    </div>
    
    </div>
    <%
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentTime = new java.util.Date();
    //PreparedStatement pstmt=null;
    //Statement
    String today = formatter.format(currentTime);
    %>
    
    
    <div class="loginbm">版权所有 @2020-<%=today.substring(0, 4) %>    </div>
	
    
</body>

</html>
