<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ include file="conn.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>角色管理</title>
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
	String var_roleID = "";
	String var_roleName = "";
	String s_roleID = "";
	String s_roleName = "";
	String var_ipage = "1";
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	if (request.getParameter("roleName") != null&&!request.getParameter("roleName").equals("")
			&& request.getParameter("roleName") != "") {
		var_roleName = (String) request.getParameter("roleName");
		s_roleName = " and ROLENAME like '%" +new String(var_roleName.getBytes("ISO-8859-1"), "utf-8")  + "%'";
	}
	if (request.getParameter("roleID") != null&&!request.getParameter("roleID").equals("")
			&& request.getParameter("roleID") != "") {
		var_roleID = (String) request.getParameter("roleID");
		s_roleID = " and ROLEID='" +var_roleID + "'";
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
			<li><a href="#">角色管理</a></li>
		</ul>
	</div>
	<div class="formbody">
		<div id="usual1" class="usual">
			<div class="itab">
				<ul>
					<li><a href="#tab1" class="selected">角色列表</a></li>
					<li><a href="jueseadd.jsp">增加角色</a></li>
				</ul>
			</div>
			<div id="tab1" class="tabson">
				<ul class="seachform">
					<form method="post" action="juese.jsp" id="search_form" name="search_form">
						<li><label>角色名</label>
						<input name="roleName" type="text" class="scinput" id="roleName" value="<%=new String(var_roleName.getBytes("ISO-8859-1"), "utf-8")%>" /></li>
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
						String sql1 = "select count(*) from T_ROLE where ROLENAME is not null "
								+ s_roleName;
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
							<th>角色编号</th>
							<th>角色名称</th>
							<th>上级角色名称</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<%
							String sql = "SELECT * FROM (select t.*,rownum rn from (select ROLEID,ROLENAME,UPROLEID,nvl('',(select rolename from t_role t where t.roleid=T_ROLE.UPROLEID)) UPROLENAME from T_ROLE where ROLENAME is not null "
										+ s_roleName
										+ s_roleID
										+ " order by ROLEID desc ) t  WHERE  rownum<="
										+ pageSize
										* pageNow
										+ ") where  rn>="
										+ ((pageNow - 1) * pageSize + 1);
								//out.write(sql);
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery();
								while (rs.next()) {
									String roleID = rs.getString("ROLEID");
									String roleName = rs.getString("ROLENAME");
									String upRoleName = rs.getString("UPROLENAME");
						%>
						<tr>
							<td><%=roleID%></td>
							<td><%=roleName%></td>
							<td><%=upRoleName%></td>
							<td><a href="juesexg.jsp?roleID=<%=roleID%>" class="tablelink">修改</a>
								<a href="quanxian.jsp?roleID=<%=roleID%>" class="tablelink">授权</a></td>
							</td>
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
