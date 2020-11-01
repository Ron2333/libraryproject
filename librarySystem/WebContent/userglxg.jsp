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
					<li><a href="#tab2">修改用户</a></li>
				</ul>
			</div>
			<div id="tab2" class="tabson">
				<div class="formtext">请把信息填写正确，否则会造成系统数据无法对应！</div>
				<%
					String var_userName = "";
					String var_loginName = "";
					String var_loginPWD="";
					String s_userName = "";
					String s_loginName = "";
					String s_loginPWD = "";
					PreparedStatement pstmt = null;
					ResultSet rs = null;

					if (request.getParameter("edi") != null&&!request.getParameter("edi").equals("")
							&& Integer.parseInt(request.getParameter("edi")) == 1) {
						if (request.getParameter("userName") != null&&!request.getParameter("userName").equals("")
								&& request.getParameter("userName") != "") {
							var_userName = (String) request.getParameter("userName");
							String sql = "update T_USER set USERNAME='" + var_userName + "'";
							if (request.getParameter("loginName") != null&&!request.getParameter("loginName").equals("")
									&& request.getParameter("loginName") != "") {
								var_loginName = (String) request
										.getParameter("loginName");
								sql = sql + ",LOGINNAME='" + var_loginName + "'";
							}
							if (request.getParameter("loginPWD") != null&&!request.getParameter("loginPWD").equals("")
									&& request.getParameter("loginPWD") != "") {
								var_loginPWD = (String) request
										.getParameter("loginPWD");
								sql = sql + ",LOGINPWD='" + var_loginPWD + "'";
							}
							
							sql = sql + " where LOGINNAME='" + var_loginName + "'";
							//out.write(sql);
							pstmt = conn.prepareStatement(sql);
							//out.write("提交修改!");
							int UpLen = pstmt.executeUpdate(sql);
							//out.write(UpLen);
							out.write("完成修改!");
							if (UpLen == 1) {
								out.println("<div class='formtext'><b>信息已修改成功!</b><a href='usergl.jsp?loginName="
										+ var_loginName + "'> 点击查看</a></div>");
							}
						}
					} else {
						if (request.getParameter("loginName") != null&&!request.getParameter("loginName").equals("")
								&& request.getParameter("loginName") != "") {
							var_loginName = (String) request.getParameter("loginName");
							String sql = "select USERNAME,LOGINNAME,LOGINPWD from T_USER where LOGINNAME='"
									+ var_loginName + "'";
							//out.print(sql);
							pstmt = conn.prepareStatement(sql);
							rs = pstmt.executeQuery();
							if (rs.next()) {
								var_userName = rs.getString("userName");
								var_loginName = rs.getString("loginName");
								var_loginPWD = rs.getString("loginPWD");
							}

						}

					}
				%>
				<form method="post" action="userglxg.jsp" id="edit_form"
					name="edit_form">
					<ul class="forminfo">
						<li><label>人员名称<b>*</b></label> <input name="userName"
							type="text" class="dfinput" id="userName" style="width: 218px;"
							value="<%=var_userName%>"  /></li>
						<li><label>登陆用户名<b>*</b></label><input name="loginName"
							type="text" class="dfinput" id="loginName" style="width: 518px;"
							value="<%=var_loginName%>" readonly/></li>
						<li><label>登陆密码<b>*</b></label><input name="loginPWD"
							type="password" class="dfinput" id="loginPWD" style="width: 218px;"
							value="<%=var_loginPWD%>" /></li>
						
						
						<%-- <li><label>一维码:</label><img src="barcodeimage/<%=var_loginName %>.jpeg" width="179" height="60" /></li> --%>
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
