<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
<%@ include file="conn.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户管理</title>
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
	function useStop(num,val) {
		document.getElementById("usn").value = num;
		document.getElementById("userID").value = val;
		//alert(document.getElementById("userID").value );
		document.list_form.submit();
	}
</script>

</head>
<%
	String var_userName = "";
	String var_bankSN = "";
	String var_loginName = "";
	String s_userName = "";

	String s_loginName = "";
	String var_ipage = "1";
	String var_isUse ="";
	String s_isUse = "";
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	if (request.getParameter("flag") != null&&request.getParameter("flag").equals("true")){
		out.println("<script type='text/javascript'>alert('已删除!');</script>");
		}
		
	if (request.getParameter("userName") != null&&!request.getParameter("userName").equals("")
			&& request.getParameter("userName") != "") {
		var_userName = (String) request.getParameter("userName");
		s_userName = " and USERNAME like '%" +new String(var_userName.getBytes("ISO-8859-1"), "utf-8")  + "%'";
	}
	
	if (request.getParameter("loginName") != null&&!request.getParameter("loginName").equals("")
			&& request.getParameter("loginName") != "") {
		var_loginName = (String) request.getParameter("loginName");
		s_loginName = " and LOGINNAME like '%" + var_loginName + "%'";
	}
	if (request.getParameter("isUse")!= null&&!request.getParameter("isUse").equals("")
			&& request.getParameter("isUse") != "") {
		var_isUse = (String) request.getParameter("isUse");
		s_isUse = " and ISUSE='" + var_isUse + "'";
	}
	if (request.getParameter("ipage") != null&&!request.getParameter("ipage").equals("")) {
		var_ipage = (String) request.getParameter("ipage");
	}
	
	
	String us = "";
	String var_userID = "";
	if (request.getParameter("userID") != null&&!request.getParameter("userID").equals("")&& request.getParameter("userID") != "") {
		var_userID = (String) request.getParameter("userID");
		System.out.println("var_userID>>>>>>>>>>"+var_userID);
	}
	if (request.getParameter("us") != null&&!request.getParameter("us").equals("")&& request.getParameter("us") != "") {
		us = (String) request.getParameter("us");
		
	}
	String usn ="";
	if (request.getParameter("usn") != null&&!request.getParameter("usn").equals("")&& request.getParameter("usn") != "") {
		usn = (String) request.getParameter("usn");
		System.out.println("usn>>>>>>>>>>"+usn);
	}
	if(us.equals("1")){
		
	 	String	sql = "update T_USER SET ISUSE="+usn+" where USERID=" +var_userID;
	 	System.out.println("usergl.jsp>>>>>>>>"+sql);
		pstmt = conn.prepareStatement(sql);
		try{
			pstmt.executeUpdate(sql);
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			pstmt.close();
		}
	}
%>
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
					<li><a href="#tab1" class="selected">用户列表</a></li>
					<li><a href="useradd.jsp">增加用户</a></li>
				</ul>
			</div>
			<div id="tab1" class="tabson">
				<ul class="seachform">
					<form method="post" action="usergl.jsp" id="search_form" name="search_form">
						<li><label>姓名</label>
						<input name="userName" type="text" class="scinput" id="userName" value="<%=new String(var_userName.getBytes("ISO-8859-1"), "utf-8") %>" /></li>
						
						<li><label>登陆用户名</label>
						
						<input name="loginName" type="text"class="scinput" id="loginName" value="<%=var_loginName%>" /></li> 
						<li><label>用户状态</label>  
					    <div class="vocation">
					    <select class="select3" id="isUse" name="isUse">
					    <option value="1" <%if("1".equals(var_isUse)){ %>selected<%} %>>启用</option>
					    <option value="2" <%if("2".equals(var_isUse)){ %>selected<%} %>>停用</option>
					    </select>
					    </div>
					    </li>
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
						String sql1 = "select count(*) from T_USER where USERNAME is not null "
							
								+ s_userName  + s_loginName+s_isUse;
						//out.write(sql1);
						System.out.println(">>>usergl.jsp>>>"+sql1);
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
				<form method="post" action="usergl.jsp" id="list_form" name="list_form">
				<table class="tablelist">
					<thead>
						<tr>
							
							<th>用户编号</th>
							<th>姓名</th>
							<th>登录名</th>
							<th>是否启用</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<%
						
							String sql = "SELECT * FROM (select t.*,rownum rn from (select USERID,USERNAME,LOGINNAME,ISUSE from T_USER where USERNAME is not null "
									
										+ s_userName
										
										+ s_loginName
										+ s_isUse
										+ " order by USERID desc ) t  WHERE  rownum<="
										+ pageSize
										* pageNow
										+ ") where  rn>="
										+ ((pageNow - 1) * pageSize + 1);
								System.out.println(">>>usergl.jsp>>>"+sql);
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery();
								while (rs.next()) {
									String userID = rs.getString("USERID");
									String userName = rs.getString("USERNAME");
									String loginName = rs.getString("LOGINNAME");
									String isUse = rs.getString("ISUSE");
						%>
						<tr>
							<td><%=userID %></td>
							<td><a href="usergl.jsp?userName=<%=userName%>"><%=userName%></a></td>
							<td><a href="usergl.jsp?loginName=<%=loginName%>"><%=loginName%></a></td>
							<td align="center">
							<input type="hidden" id="us" name="us" value="1" />
							<input type="hidden" id="usn" name="usn" value="" />
							<input type="hidden" id="userID" name="userID" value="" />
							<%if(isUse.equals("1")){%>
							<input type="button" id="use2" name="use2" onClick="useStop(2,<%=userID%>)" value="停用" />
							<input type="button" id="use1" name="use1" disabled="disabled" value="启用" />
							<%}else{ %>
							<input type="button" id="use1"  name="use1" onClick="useStop(1,<%=userID%>)" value="启用" />
							<input type="button" id="use2" name="use2" disabled="disabled" value="停用" />
							<%} %></td>
							<td><a href="userglxg.jsp?loginName=<%=loginName%>" class="tablelink">修改</a>
							<a href="jueseuser.jsp?userID=<%=userID%>" class="tablelink">授权</a>
							<a href="userDel.jsp?userID=<%=userID%>" class="tablelink">删除</a>
							</td>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				</form>
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
