<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
	<%@ page language="java" import="java.util.*" %>
<%@ include file="conn.jsp"%>

<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>设备管理</title>
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
		document.getElementsByName("test");
		if(c1.checked){
			for(var i=0;i<c2.length;i++){
				c2[i].checked=true;
			}
		}else{
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
	
	int i=0;
	String var_roleID = "";
	String s_roleID = "";
	
	String var_functionID = "";
	String s_functionID = "";
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	PreparedStatement pstmt1 = null;
	ResultSet rs1 = null;
	if (request.getParameter("roleID") != null&&!request.getParameter("roleID").equals("")
			&& request.getParameter("roleID") != "") {
		var_roleID = (String) request.getParameter("roleID");
		s_roleID = " and ROLEID='" +var_roleID+ "'";
	}
	if (request.getParameter("functionID") != null&&!request.getParameter("functionID").equals("")
			&& request.getParameter("functionID") != "") {
		var_functionID = (String) request.getParameter("functionID");
		s_functionID = " and FUNCTIONID='" + var_functionID + "'";
	}
%>
<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">系统设置</a></li>
			<li><a href="#">用户授权</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div id="usual1" class="usual">
			<div id="tab1" class="tabson">
    <form  method="post" action="quanxianadd.jsp?roleID=<%=var_roleID %>" id="search_form" name="search_form">
    <table align="center" width="900" style="margin-left:60px; margin-top:40px;">
    	<%
    		List<String> fList = new ArrayList<String>();
    		String sq = "select distinct ROLEID,FUNCTIONID from T_ROLEFUNCTION where ROLEID="+var_roleID+" order by FUNCTIONID asc";
    		pstmt = conn.prepareStatement(sq);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				String roleID = rs.getString("ROLEID");
				String functionID = rs.getString("FUNCTIONID");
				fList.add(functionID);
			}
			
			String sql = "select FUNCTIONID,FUNCTIONNAME,FUNCTIONURL,UPFUNCTIONID from T_FUNCTION where UPFUNCTIONID=0 "
					+ " order by FUNCTIONID asc ";
			//out.write(sql);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				i++;
				String functionID = rs.getString("FUNCTIONID");
				String functionName = rs.getString("FUNCTIONNAME");
				String functionUrl = rs.getString("FUNCTIONURL");
				String upfunctionID = rs.getString("UPFUNCTIONID");
			%>
        	<tr>
        	<td height="28" width="900" align="left" style="background-color:#F1FDFE; font-weight:600;">
        	<%=functionName%>：<input id="functionID<%=i %>" name="functionID<%=i %>" type="checkbox" onClick="t1('functionID<%=i %>','dupfunctionID<%=i %>');"
        	 value="<%=functionID %>"
        	 <%if(fList.contains(functionID)){ %>checked<%} %> />
        	</td>
        	</tr>
        	
        	<% String dsql = "select FUNCTIONID,FUNCTIONNAME,FUNCTIONURL,UPFUNCTIONID from T_FUNCTION where UPFUNCTIONID="+functionID
					+ " order by FUNCTIONID asc ";
			//out.write(dsql);
			System.out.println("quanxian.jsp>>>>>>"+dsql);
			pstmt1 = conn.prepareStatement(dsql);
			rs1 = pstmt1.executeQuery();
			while (rs1.next()) {
				String dfunctionID = rs1.getString("FUNCTIONID");
				String dfunctionName = rs1.getString("FUNCTIONNAME");
				String dfunctionUrl = rs1.getString("FUNCTIONURL");
				String dupfunctionID = rs1.getString("UPFUNCTIONID");%>
        	<tr>
	        <td height="35" width="900">
	        <table width="900">
	        <tr><td><%=dfunctionName%>：<input id="dupfunctionID<%=i %>" name="dupfunctionID<%=i %>" type="checkbox"  onClick="t2('functionID<%=i %>','dupfunctionID<%=i %>');"
	        value="<%=dfunctionID %>"
	         <%if(fList.contains(dfunctionID)){ %>checked<%} %>/></td></tr>
	        </table></td>
	        </tr>
      		<%} %>
        <%} %>
        <tr>
        <td height="28" width="900" align="left" style=" text-align:center;"><label>&nbsp;</label>
        <input name="add" type="hidden" id="add" value="1">
        <input id="count" name="count" type="hidden"  value="<%=i%>">
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
		rs1.close();
		pstmt1.close();
		pstmt.close();
		conn.close();
	} catch (Exception e) {
		//System.out.println(e);  
	}
%>
</html>
