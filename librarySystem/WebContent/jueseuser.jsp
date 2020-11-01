<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
	<%@ page language="java" import="java.util.*" %>
<%@ include file="conn.jsp"%>

<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户角色管理</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="js/select-ui.min.js"></script>
<script type="text/javascript" src="editor/kindeditor.js"></script>
<script type="text/javascript">
	$(document).ready(function(e) {
		$(".select1").uedSelect({ width : 345 });
		$(".select2").uedSelect({ width : 167 });
		$(".select3").uedSelect({ width : 100 });
	});
</script>
<script type="text/javascript">
	function FormSubmit(num) {
		document.getElementById("ipage").value = num;
		//document.getElementById("UpBankSN").value=num;
		document.search_form.submit();
	}
	function t1(t1,t2){
		var c1 = document.getElementById(t1);
		var c2 = document.getElementsByName(t2);
		
		if(c1.checked==true){
			for(var i=0;i<c2.length;i++){
				c2[i].checked=true;
			}
		}
		if(c1.checked==false){
			for(var i=0;i<c2.length;i++){
				c2[i].checked=false;
			}
		}
	}
	
	function t2(t1,t2){
		var c1 = document.getElementById(t1);
		var c2 = document.getElementsByName(t2);
		var a=-1;
		for(var i=0;i<c2.length;i++){
			if(c2[i].checked==true){
				a=i;
			}
		}
		if(a>=0){
			c1.checked=true;
		}else{
			c1.checked=false;
		}
	}
</script>

</head>
<%
	
	String var_roleID = "";
	String s_roleID = "";
	
	String var_userID = "";
	String s_userID = "";
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	if (request.getParameter("roleID") != null&&!request.getParameter("roleID").equals("")
			&& request.getParameter("roleID") != "") {
		var_roleID = (String) request.getParameter("roleID");
		s_roleID = " and ROLEID='" +var_roleID+ "'";
	}
	if (request.getParameter("userID") != null&&!request.getParameter("userID").equals("")
			&& request.getParameter("userID") != "") {
		var_userID = (String) request.getParameter("userID");
		s_userID = " and USERID='" +var_userID+ "'";
	}
%>
<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">系统设置</a></li>
			<li><a href="#">用户角色</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div id="usual1" class="usual">
			<div id="tab1" class="tabson">
    <form  method="post" action="jueseuseradd.jsp?userID=<%=var_userID %>" id="search_form" name="search_form">
    <table align="center" width="900" style="margin-left:60px; margin-top:40px;">
    	<%
    		List<String> fList = new ArrayList<String>();
    		String sq = "select distinct USERID,ROLEID from T_USERROLE where USERID="+var_userID+" order by USERID asc";
    		pstmt = conn.prepareStatement(sq);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String roleID = rs.getString("ROLEID");
				String userID = rs.getString("USERID");
				fList.add(roleID);
			}
			
			String sql = "select ROLEID,ROLENAME from T_ROLE order by ROLEID asc ";
			//out.write(sql);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				String roleID = rs.getString("ROLEID");
				String roleName = rs.getString("ROLENAME");
			%>
        	<tr>
        	<td height="28" width="900" align="left" style="background-color:#F1FDFE; font-weight:600;">
        	<%=roleName%>：<input id="roleID" name="roleID" type="checkbox"  value="<%=roleID %>"
        	 <%if(fList.contains(roleID)){ %>checked<%} %> />
        	</td>
        	</tr>
      		<%} %>
        <tr>
        <td height="28" width="900" align="left" style=" text-align:center;"><label>&nbsp;</label>
        <input name="add" type="hidden" id="add" value="1">
        <input name="" type="submit" class="btn" value="授权" />
        </td>
        </tr>
    </table>
        </form>
    </div>

		</div>

		<script type="text/javascript">
			$("#usual1 ul").idTabs();
		</script>

		<script type="text/javascript">
			$('.tablelist tbody tr:odd').addClass('odd');
		</script>

	</div>


</body>
<%
	try {
		rs.close();
		pstmt.close();
		conn.close();
	} catch (Exception e) {
		//System.out.println(e);  
	}
%>
</html>
