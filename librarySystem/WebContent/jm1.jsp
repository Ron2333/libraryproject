<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<%@page import="util.MyUtil"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="refresh" content="60">
<title>新物流管理系统</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.idTabs.min.js"></script>
<style>
 html, body

        {

            margin: 0px 0px;

            width: 100%;

            height: 100%;

        }

        iframe

        {

            margin: 0px 0px;

            width: 100%;

            height: 100%;

        }
</style>





</head>

<body  style="background-color: black;margin:0px;">
<iframe src="jms.jsp" name="iframeId" id="iframeId" scrolling="no" frameborder="0" 
width="100%"   ></iframe>

</body>

<script type="text/javascript">



/* function initReload(){
	//ifrmid.window.location.reload()
	window.frames('iframeId').location.reload()
} 

setTimeout('initReload()',1000);  //指定1秒刷新一次  */
window.setInterval("document.frames('iframeId').location.reload()",3000)

</script>
</html>
