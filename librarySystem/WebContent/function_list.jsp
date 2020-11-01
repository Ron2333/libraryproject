<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ include file="conn.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>功能管理</title>
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
</script>

</head>
<%
	String var_functionName = "";
	String s_functionName = "";
	
	String var_functionID="";
	String s_functionID="";
	String var_ipage = "1";
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	if (request.getParameter("functionName") != null&&!request.getParameter("functionName").equals("")
			&& request.getParameter("functionName") != "") {
		var_functionName = (String) request.getParameter("functionName");
		s_functionName = " and FUNCTIONNAME like '%" +new String(var_functionName.getBytes("ISO-8859-1"), "utf-8") + "%'";
	}
	if (request.getParameter("functionID") != null&&!request.getParameter("functionID").equals("")
			&& request.getParameter("functionID") != "") {
		var_functionID = (String) request.getParameter("functionID");
		s_functionID = " and FUNCTIONID='" +var_functionID + "'";
	}
	if (request.getParameter("ipage") != null&&!request.getParameter("ipage").equals("")) {
		var_ipage = (String) request.getParameter("ipage");
	}
%>
<body>
	<div class="place">
		<span>位置：</span>
		<ul class="placeul">
			<li><a href="#">首页</a></li>
			<li><a href="#">系统设置</a></li>
			<li><a href="#">功能管理</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div id="usual1" class="usual">
			<div class="itab">
				<ul>
					<li><a href="#tab1" class="selected">功能列表</a></li>
					<li><a href="tjgn.jsp">增加功能</a></li>
				</ul>
			</div>
			<div id="tab1" class="tabson">
				<ul class="seachform">
					<form method="post" action="function_list.jsp" id="search_form" name="search_form">
						<li><label>功能名称</label>
						<input name="functionName" type="text" class="scinput" id="functionName" value="<%=new String(var_functionName.getBytes("ISO-8859-1"), "utf-8")%>" /></li>
						<input name="ipage" type="hidden" id="ipage" value="<%=var_ipage%>">
						<li><label>&nbsp;</label><input type="submit" class="scbtn" value="查询" /></li>
					</form>
				</ul>
				<%
					try {
						int pageSize = 20;//每页显示条数
						int pageNow = 1;//默认显示第一页  
						int rowCount = 0;//总笔数  
						int pageCount = 0; //总页数
						String s_pageNow = var_ipage;
						if (s_pageNow != null) {
							pageNow = Integer.parseInt(s_pageNow);
						}
						if (pageNow < 1) {
							pageNow = 1;
						}
						String sql1 = "select count(*) from T_FUNCTION where FUNCTIONNAME is not null "
								+ s_functionName ;
						//out.write(sql1);
						pstmt = conn.prepareStatement(sql1);
						rs = pstmt.executeQuery();
						if (rs.next()) {
							rowCount = rs.getInt(1);
						}
						if (rowCount % pageSize == 0) {
							pageCount = rowCount / pageSize;
						} else {
							pageCount = rowCount / pageSize + 1;
						}
						if (pageNow > pageCount) {
							pageNow = pageCount;
						}
				%>
				<table class="tablelist">
					<thead>
						<tr>
							<th>功能代码</th>
							<th>功能名称</th>
							<th>功能地址</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<%
							String sql = "SELECT * FROM (select t.*,rownum rn from (select FUNCTIONID,FUNCTIONNAME,FUNCTIONURL from T_FUNCTION where FUNCTIONNAME is not null "
										+ s_functionName
										+ s_functionID
										+ " order by FUNCTIONID desc ) t  WHERE  rownum<="
										+ pageSize
										* pageNow
										+ ") where  rn>="
										+ ((pageNow - 1) * pageSize + 1);
								//out.write(sql);
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery();
								while (rs.next()) {
									String functionID = rs.getString("FUNCTIONID");
									String functionName = rs.getString("FUNCTIONNAME");
									String functionUrl = rs.getString("FUNCTIONURL");
						%>
						<tr>
							<td><%=functionID%></td>
							<td><a href="function_list.jsp?functionName=<%=functionName%>"><%=functionName%></a></td>
							<td><%=functionUrl%></td>
							<td><a href="functionxg.jsp?functionID=<%=functionID%>" class="tablelink">修改</a></td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				<div class="pagin">
					<div class="message">
						共&nbsp;<i class="blue"><%=rowCount%></i>&nbsp;条记录，分&nbsp;<i
							class="blue"><%=pageCount%></i>&nbsp;页显示，当前显示第&nbsp;<i
							class="blue"><%=pageNow%></i>&nbsp;页
					</div>
					<ul class="paginList">
						<li class="paginItem"><a href="javascript:FormSubmit(1);"
							title="第一页"><b>&lt;&lt;</b></a></li>
						<li class="paginItem"><a
							href="javascript:FormSubmit(<%=pageNow - 10%>);" title="上10页"><b>&lt;</b></a></li>
						<%
							int zjMinPage = 1; //中间最小页码
								int zjMaxPage = 1; //中间最大页码
								zjMinPage = pageNow - 5;
								if (zjMinPage <= 1) {
									zjMinPage = 1;
								}
								zjMaxPage = pageNow + 5;
								if (zjMaxPage >= pageCount) {
									zjMaxPage = pageCount;
								}
								for (int i = zjMinPage; i <= zjMaxPage; i++) {
						%>
						<li
							class="paginItem<%if (i == pageNow) {
						out.write(" current");
					}%>"><a
							href="javascript:FormSubmit(<%=i%>);"><%=i%></a></li>
						<%
							}
						%>
						<li class="paginItem"><a
							href="javascript:FormSubmit(<%=pageNow + 10%>);" title="下10页"><b>&gt;</b></a></li>
						<li class="paginItem"><a
							href="javascript:FormSubmit(<%=pageCount%>);" title="最末页"><b>&gt;&gt;</b></a></li>
					</ul>
				</div>
				<%
					} catch (Exception e) {
						out.println(e);
					}
				%>


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
