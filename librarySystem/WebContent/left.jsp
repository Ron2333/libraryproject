<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ include file="conn.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>角色管理</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="js/jquery.js"></script>

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

</head>
	
<body style="background:#f0f9fd;width:20px;">

	<div class="lefttop"><span></span>系统功能</div>
    
    <dl class="leftmenu">

    
    <%
    String var_userID = "";
	String s_userID = "";
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	PreparedStatement pstmt1 = null;
	ResultSet rs1 = null;
	HttpSession hs = request.getSession();
	var_userID = hs.getAttribute("userID").toString();
	try{
		String fsql = "select FUNCTIONID,FUNCTIONNAME,FUNCTIONURL,UPFUNCTIONID from t_function f where f.FUNCTIONID in ("
				+" select r.FUNCTIONID from T_ROLEFUNCTION r where r.ROLEID in ("
				+"		select ROLEID from T_USERROLE t where t.USERID="+var_userID+") and f.UPFUNCTIONID=0) order by f.FUNCTIONID asc";
		pstmt = conn.prepareStatement(fsql);
		System.out.println("left.jsp>>>"+fsql);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			String functionID = rs.getString("FUNCTIONID");
			String functionName = rs.getString("FUNCTIONNAME");
			String functionUrl = rs.getString("FUNCTIONURL");
			String upfunctionID = rs.getString("UPFUNCTIONID");
			%>
			<dd>
			 <%if(upfunctionID.equals("0")&&functionName.equals("查询分析")){%>
			    <div class="title">
			    <span><img src="images/leftico02.png" /></span><%=functionName %>
			    </div>
		    <%} %>
			<%if(upfunctionID.equals("0")&&functionName.equals("业务操作")){%>
			    <div class="title">
			    <span><img src="images/leftico03.png" /></span><%=functionName %>
			    </div>
		    <%} %>
			
		    <%if(upfunctionID.equals("0")&&functionName.equals("系统管理")){%>
			    <div class="title">
			    <span><img src="images/leftico01.png" /></span><%=functionName %>
			    </div>
		    <%} %>
		    <ul class="menuson">
		    <% String dsql = "select FUNCTIONID,FUNCTIONNAME,FUNCTIONURL,UPFUNCTIONID from t_function f where f.FUNCTIONID in ("
						+" select r.FUNCTIONID from T_ROLEFUNCTION r where r.ROLEID in ("
						+"		select ROLEID from T_USERROLE t where t.USERID="+var_userID+") and f.UPFUNCTIONID="+functionID+") order by f.FUNCTIONID asc";
			pstmt1 = conn.prepareStatement(dsql);
			System.out.println("left.jsp>>>"+dsql);
			rs1 = pstmt1.executeQuery();
			
			while (rs1.next()) {
				String dfunctionID = rs1.getString("FUNCTIONID");
				String dfunctionName = rs1.getString("FUNCTIONNAME");
				String dfunctionUrl = rs1.getString("FUNCTIONURL");
				String dupfunctionID = rs1.getString("UPFUNCTIONID");%>
		        <li><cite></cite><a href="<%=dfunctionUrl %>" target="rightFrame"><%=dfunctionName %></a><i></i></li>
			    <%} %>
			    </ul>
			    </dd>
			<%}
		pstmt.close();
		rs.close();
		pstmt1.close();
		rs1.close();
		conn.close();
		
	}catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
    
    %>
    <dd>
	<div class="title" onclick="javascript:top.location.href='index.jsp';"><span><img src="images/leftico04.png" /></span>退出系统</div>
    </dd> 
    </dl>
    
</body>
</html>
