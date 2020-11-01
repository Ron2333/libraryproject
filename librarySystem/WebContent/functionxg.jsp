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
					String var_functionID = "";
					String var_functionName = "";
					String var_functionUrl = "";
					String var_upfunctionID = "";
					String s_functionID = "";
					String s_functionName = "";
					String s_functionUrl = "";
					String s_upfunctionID = "";
					PreparedStatement pstmt = null;
					ResultSet rs = null;

					if (request.getParameter("edi") != null&&!request.getParameter("edi").equals("")
							&& Integer.parseInt(request.getParameter("edi")) == 1) {
						if (request.getParameter("functionID") != null&&!request.getParameter("functionID").equals("")
								&& request.getParameter("functionID") != "") {
							var_functionID = (String) request.getParameter("functionID");
							String sql = "update T_FUNCTION set FUNCTIONID='" + var_functionID + "'";
							if (request.getParameter("functionName") != null&&!request.getParameter("functionName").equals("")
									&& request.getParameter("functionName") != "") {
								var_functionName = (String) request
										.getParameter("functionName");
								sql = sql + ",FUNCTIONNAME='"+var_functionName + "'";
							}
							if (request.getParameter("functionUrl") != null&&!request.getParameter("functionUrl").equals("")
									&& request.getParameter("functionUrl") != "") {
								var_functionUrl = (String) request
										.getParameter("functionUrl");
								sql = sql + ",FUNCTIONURL='" + var_functionUrl + "'";
							}
							if (request.getParameter("upfunctionID") != null&&!request.getParameter("upfunctionID").equals("")
									&& request.getParameter("upfunctionID") != "") {
								var_upfunctionID = (String) request
										.getParameter("upfunctionID");
								sql = sql + ",UPFUNCTIONID='" + var_upfunctionID + "'";
							}
							sql = sql + " where FUNCTIONID='" + var_functionID + "'";
							//out.write(sql);
							pstmt = conn.prepareStatement(sql);
							//out.write("提交修改!");
							int UpLen = pstmt.executeUpdate(sql);
							//out.write(UpLen);
							out.write("完成修改!");
							if (UpLen == 1) {
								out.println("<div class='formtext'><b>信息已修改成功!</b><a href='function_list.jsp?functionID="
										+ var_functionID + "'> 点击查看</a></div>");
							}
						}
					} else {
						if (request.getParameter("functionID") != null&&!request.getParameter("functionID").equals("")
								&& request.getParameter("functionID") != "") {
							var_functionID = (String) request.getParameter("functionID");
							String sql = "select FUNCTIONID,FUNCTIONNAME,FUNCTIONURL,UPFUNCTIONID from T_FUNCTION where FUNCTIONID ='"
									+ var_functionID + "'";
							//out.print(sql);
							pstmt = conn.prepareStatement(sql);
							rs = pstmt.executeQuery();
							if (rs.next()) {
								var_functionID = rs.getString("FUNCTIONID");
								var_functionName = rs.getString("FUNCTIONNAME");
								var_functionUrl = rs.getString("FUNCTIONURL");
								var_upfunctionID = rs.getString("UPFUNCTIONID");
							}

						}

					}
				%>
				<form method="post" action="functionxg.jsp" id="edit_form"
					name="edit_form">
					<ul class="forminfo">
						<li><label>功能代码<b>*</b></label> <input name="functionID"
							type="text" class="dfinput" id="functionID" style="width: 218px;"
							value="<%=var_functionID%>"  readonly/></li>
						<li><label>功能名称<b>*</b></label><input name="functionName"
							type="text" class="dfinput" id="functionName" style="width: 518px;"
							value="<%=var_functionName%>" /></li>
						<li><label>上级功能名称<b>*</b></label>
					<div class="vocation">
					<select class="select3" id="upfunctionID" name="upfunctionID">
					    <option value="0">一级目录</option>
					    <%
							String fsql = "select FUNCTIONID,FUNCTIONNAME from T_FUNCTION where UPFUNCTIONID =0 " ; 
								//out.write(fsql);
								pstmt = conn.prepareStatement(fsql);
								rs = pstmt.executeQuery();
								while (rs.next()) {
									String functionID = rs.getString("FUNCTIONID");
									String functionName = rs.getString("FUNCTIONNAME");
						%>
					    <option value="<%=functionID%>" <%if(functionID.equals(var_upfunctionID)){ %>selected<%} %>><%=functionName%></option>
					    <%}
								pstmt.close();
								rs.close();
					    %> 
					    </select>
						</div>
					</li>
						<li><label>功能地址<b>*</b></label><input name="functionUrl"
							type="text" class="dfinput" id="functionUrl" style="width: 218px;"
							value="<%=var_functionUrl%>" /></li>
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
