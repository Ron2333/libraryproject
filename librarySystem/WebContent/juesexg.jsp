<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ include file="conn.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="js/select-ui.min.js"></script>
<script type="text/javascript" src="editor/kindeditor.js"></script>
<script type="text/javascript">
	$(document).ready(function(e) {
		$(".select1").uedSelect({
			width : 345
		});
		$(".select2").uedSelect({
			width : 167
		});
		$(".select3").uedSelect({
			width : 100
		});
	});
</script>
</head>
<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">系统设置</a></li>
			<li><a href="#">用户管理</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div id="usual1" class="usual">
			<div class="itab">
				<ul>
					<li><a href="#tab2">修改角色</a></li>
				</ul>
			</div>
			<div id="tab2" class="tabson">
				<div class="formtext">请把信息填写正确，否则会造成系统数据无法对应！</div>
				<%
					String var_roleID = "";
					String var_roleName = "";
					String s_roleID = "";
					String s_roleName = "";
					PreparedStatement pstmt = null;
					ResultSet rs = null;

					if (request.getParameter("edi") != null&&!request.getParameter("edi").equals("")
							&& Integer.parseInt(request.getParameter("edi")) == 1) {
						if (request.getParameter("roleID") != null&&!request.getParameter("roleID").equals("")
								&& request.getParameter("roleID") != "") {
							var_roleID = (String) request.getParameter("roleID");
							String sql = "update T_ROLE set ROLEID='" + var_roleID + "'";
							if (request.getParameter("roleName") != null&&!request.getParameter("roleName").equals("")
									&& request.getParameter("roleName") != "") {
								var_roleName = (String) request
										.getParameter("roleName");
								sql = sql + ",ROLENAME='" + var_roleName + "'";
							}
							sql = sql + " where ROLEID='" + var_roleID + "'";
							//out.write(sql);
							pstmt = conn.prepareStatement(sql);
							//out.write("提交修改!");
							int UpLen = pstmt.executeUpdate(sql);
							//out.write(UpLen);
							out.write("完成修改!");
							if (UpLen == 1) {
								out.println("<div class='formtext'><b>信息已修改成功!</b><a href='juese.jsp?roleID="
										+ var_roleID + "'> 点击查看</a></div>");
							}
						}
					} else {
						if (request.getParameter("roleID") != null&&!request.getParameter("roleID").equals("")
								&& request.getParameter("roleID") != "") {
							var_roleID = (String) request.getParameter("roleID");
							String sql = "select ROLEID,ROLENAME from T_ROLE where ROLEID='"
									+ var_roleID + "'";
							//out.print(sql);
							pstmt = conn.prepareStatement(sql);
							rs = pstmt.executeQuery();
							if (rs.next()) {
								var_roleID = rs.getString("roleID");
								var_roleName = rs.getString("roleName");
							}

						}

					}
				%>
				<form method="post" action="juesexg.jsp" id="edit_form"
					name="edit_form">
					<ul class="forminfo">
						<li><label>角色编号<b>*</b></label> <input name="roleID"
							type="text" class="dfinput" id="roleID" style="width: 218px;"
							value="<%=var_roleID%>"  readonly/></li>
						<li><label>角色名称<b>*</b></label><input name="roleName"
							type="text" class="dfinput" id="roleName" style="width: 518px;"
							value="<%=var_roleName%>" /></li>
						<li><label>&nbsp;
						<input name="edi" type="hidden" id="edi" value="1"></label> 
						<input type="submit" class="btn" value="确认修改" /></li>
					</ul>
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
