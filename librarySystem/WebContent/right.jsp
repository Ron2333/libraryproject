<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*,java.util.*" errorPage=""%>
<%@ include file="conn.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>角色管理</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="js/jquery.js"></script>
<style> 
</style>
<script type="text/javascript">
$(function(){	
	//导航切换
	$(".menuson li").click(function(){
		$(".menuson li.active").removeClass("active")
		$(this).addClass("active");
	});
	
	$('.title').click(function(){
		var $ul = $(this).next('ul');
		$('dd').find('ul').slideUp();
		if($ul.is(':visible')){
			$(this).next('ul').slideUp();
		}else{
			$(this).next('ul').slideDown();
		}
	});
})	

</script>
<%
Properties properties = new Properties();
properties.load(this.getClass().getResourceAsStream("/db.properties"));

String titleName = new String(properties.getProperty("titleName"));
%>
</head>
	<%
String var_userID = "";
String var_userName = "";
PreparedStatement pstmt = null;
ResultSet rs = null;

HttpSession hs= request.getSession();
var_userName = hs.getAttribute("userName").toString();
var_userID = hs.getAttribute("userID").toString();
%>
<script type="text/javascript">

</script>
<body>

    <div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#"><%=titleName %>首页</a></li>
    </ul>
    </div>
    
    <div class="mainindex">
    
   
    <div class="welinfo">
    <span></span>
    <b>您好！<%=var_userName %>，欢迎使用<%=titleName %></b>
    </div>

    <div class="xline"></div>
<br />
<br />
<ul class="iconlist">
     <%
	String s_userID = "";
	PreparedStatement pstmt1 = null;
	Statement ps=null;
	ResultSet rs1 = null;
	var_userID = hs.getAttribute("userID").toString();
	String loginname="";
	try{
		String sql="select loginname from t_user where userid="+var_userID+"";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		if(rs.next()){
			loginname=rs.getString("loginname");
		}
		
		rs.close();
		conn.close();
		
	}catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
    
    %>
    
    </ul>
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
  
</div>
	<%
int day1 = 0;
if(null!=hs.getAttribute("day1")){
	day1 = Integer.parseInt(hs.getAttribute("day1").toString());
}
	

if(day1>0&&day1<30){
	System.out.println("少于３０天进行提示信息！");
%>
<SCRIPT language=javascript>
//more javascript from http://www.alixixi.com
window.onload = enetgetMsg;
window.onresize = enetresizeDiv;
window.onerror = function(){}
var enetdivTop,enetdivLeft,enetdivWidth,enetdivHeight,enetdocHeight,enetdocWidth,enetobjTimer,i = 0;
function enetgetMsg()
{//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
try{
enetdivTop = parseInt(document.getElementById("enetMeng").style.top,10)
enetdivLeft = parseInt(document.getElementById("enetMeng").style.left,10)
enetdivHeight = parseInt(document.getElementById("enetMeng").offsetHeight,10)
enetdivWidth = parseInt(document.getElementById("enetMeng").offsetWidth,10)
enetdocWidth = document.body.clientWidth;
enetdocHeight = document.body.clientHeight;
document.getElementById("enetMeng").style.top = parseInt(document.body.scrollTop,10) + enetdocHeight + 10;// enetdivHeight
document.getElementById("enetMeng").style.left = parseInt(document.body.scrollLeft,10) + enetdocWidth - enetdivWidth;
document.getElementById("enetMeng").style.visibility="visible";
enetobjTimer = window.setInterval("enetmoveDiv()",10)
}
catch(e){}
}
　
function enetresizeDiv()
{
i+=1
if(i>600) enetcloseDiv()
try{
enetdivHeight = parseInt(document.getElementById("enetMeng").offsetHeight,10)
enetdivWidth = parseInt(document.getElementById("enetMeng").offsetWidth,10)
enetdocWidth = document.body.clientWidth;
enetdocHeight = document.body.clientHeight;
document.getElementById("enetMeng").style.top = enetdocHeight - enetdivHeight + parseInt(document.body.scrollTop,10)
document.getElementById("enetMeng").style.left = enetdocWidth - enetdivWidth + parseInt(document.body.scrollLeft,10)
}//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
catch(e){}
}
function enetmoveDiv()
{
try
{
if(parseInt(document.getElementById("enetMeng").style.top,10) <= (enetdocHeight - enetdivHeight + parseInt(document.body.scrollTop,10)))
{
window.clearInterval(enetobjTimer)
enetobjTimer = window.setInterval("enetresizeDiv()",1)
}
enetdivTop = parseInt(document.getElementById("enetMeng").style.top,10)
document.getElementById("enetMeng").style.top = enetdivTop - 1
}
catch(e){}
}
function enetcloseDiv()
{
document.getElementById('enetMeng').style.visibility='hidden';
if(enetobjTimer) window.clearInterval(enetobjTimer)
}//欢迎来到站长特效网，我们的网址是www.zzjs.net，很好记，zz站长，js就是js特效，本站收集大量高质量js代码，还有许多广告代码下载。
</SCRIPT>
<!--把下列代码加到BODY区域内-->
<DIV id=enetMeng style="BORDER-RIGHT: #455690 1px solid; BORDER-TOP: #a6b4cf 1px solid; Z-INDEX: 99999; LEFT: 0px; VISIBILITY: visible; BORDER-LEFT: #a6b4cf 1px solid; WIDTH: 241px; BORDER-BOTTOM: #455690 1px solid; POSITION: absolute; TOP: -200px; HEIGHT: 130px">
<TABLE WIDTH=255 BORDER=1 CELLPADDING=0 CELLSPACING=0 bgcolor="#DAE6FC">
<TR>
<TD height="30" valign="top" background="qqimages/heihei_1.jpg">
<table width="255" height="19" border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="212" valign="bottom"><strong><font size="2">　<font color="#FF6600">消息框</font></font></strong></td>
<td width="43" style="cursor:hand" onClick="enetcloseDiv()">X</td>
</tr>
</table> </TD>
</TR>
<TR>
<TD height="100" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="1">
<tr>
<td width="95%"><table align="center" width="98%"><tr><td>
使用期限　<%=day1 %>　天</td><tr></table></td>
</tr>
</table> </TD>
</TR>
</TABLE>
</div>
<%} %>
</body>

</html>
