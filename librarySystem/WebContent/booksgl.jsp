<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>图书登记</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="js/select-ui.min.js"></script>
<script type="text/javascript" src="editor/kindeditor.js"></script>
<script language="javascript" type="text/javascript" src= "datapicker/WdataPicker.js"></script>
  
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

<script type="text/javascript">
	function FormSubmit(num) {
		document.getElementById("ipage").value = num;
		//document.getElementById("UpBankSN").value=num;
		document.search_form.submit();
	}
	function useStop(num,val) {
		document.getElementById("usn").value = num;
		document.getElementById("BOOKBARCODE").value = val;
		//alert(document.getElementById("BOOKBARCODE").value );
		document.list_form.submit();
	}
</script>

</head>
<%
	String var_bookName = "";
	String var_bankSN = "";
	String var_BOOKAUTOR = "";
	String s_bookName = "";

	String s_BOOKAUTOR = "";
	String var_ipage = "1";
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	if (request.getParameter("flag") != null&&request.getParameter("flag").equals("true")){
		out.println("<script type='text/javascript'>alert('已删除!');</script>");
		}
		
	if (request.getParameter("bookName") != null&&!request.getParameter("bookName").equals("")
			&& request.getParameter("bookName") != "") {
		var_bookName = (String) request.getParameter("bookName");
		s_bookName = " and bookName like '%" +new String(var_bookName.getBytes("ISO-8859-1"), "utf-8")  + "%'";
	}
	
	if (request.getParameter("BOOKAUTOR") != null&&!request.getParameter("BOOKAUTOR").equals("")
			&& request.getParameter("BOOKAUTOR") != "") {
		var_BOOKAUTOR = (String) request.getParameter("BOOKAUTOR");
		s_BOOKAUTOR = " and BOOKAUTOR like '%" + var_BOOKAUTOR + "%'";
	}
	if (request.getParameter("ipage") != null&&!request.getParameter("ipage").equals("")) {
		var_ipage = (String) request.getParameter("ipage");
	}
	
	
	String us = "";
	String var_BOOKBARCODE = "";
	if (request.getParameter("BOOKBARCODE") != null&&!request.getParameter("BOOKBARCODE").equals("")&& request.getParameter("BOOKBARCODE") != "") {
		var_BOOKBARCODE = (String) request.getParameter("BOOKBARCODE");
		System.out.println("var_BOOKBARCODE>>>>>>>>>>"+var_BOOKBARCODE);
	}
	if (request.getParameter("us") != null&&!request.getParameter("us").equals("")&& request.getParameter("us") != "") {
		us = (String) request.getParameter("us");
		
	}
	String usn ="";
	if (request.getParameter("usn") != null&&!request.getParameter("usn").equals("")&& request.getParameter("usn") != "") {
		usn = (String) request.getParameter("usn");
		System.out.println("usn>>>>>>>>>>"+usn);
	
	}
%>
<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">系统设置</a></li>
	<li><a href="#">设备管理</a></li>
    </ul>
    </div>
    
    <div class="formbody">
    
    
    <div id="usual1" class="usual"> 
    
    <div class="itab">
  	<ul> 
    <li><a href="#tab2" class="selected" >书籍列表</a></li> 
    <li><a href="booksList.jsp"  >增加书目</a></li>
  	</ul>
    </div> 
			<div id="tab1" class="tabson">
				<ul class="seachform">
					<form method="post" action="bookgl.jsp" id="search_form" name="search_form">
						<li><label>书名</label>
						<input name="bookName" type="text" class="scinput" id="bookName" value="<%=new String(var_bookName.getBytes("ISO-8859-1"), "utf-8") %>" /></li>
						
						<li><label>作者</label>
						
						<input name="BOOKAUTOR" type="text"class="scinput" id="BOOKAUTOR" value="<%=var_BOOKAUTOR%>" /></li> 
						<li><label>用户状态</label>  
					    <div class="vocation">
					    <select class="select3" id="isUse" name="isUse">
					    <option value="1" <% %>>启用</option>
					    <option value="2" <% %>>停用</option>
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
						String sql1 = "select count(*) from T_BOOKS where bookName is not null "
							
								+ s_bookName  + s_BOOKAUTOR;
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
							
							<th>书名</th>
							<th>条形码</th>
							<th>作者</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<%
						
							String sql = "SELECT * FROM (select t.*,rownum rn from (select BOOKBARCODE,BOOKNAME,BOOKAUTOR from T_BOOKS where BOOKNAME is not null "
									
										+ s_bookName
										
										+ s_BOOKAUTOR
										+ " order by BOOKBARCODE desc ) t  WHERE  rownum<="
										+ pageSize
										* pageNow
										+ ") where  rn>="
										+ ((pageNow - 1) * pageSize + 1);
								System.out.println(">>>usergl.jsp>>>"+sql);
								pstmt = conn.prepareStatement(sql);
								rs = pstmt.executeQuery();
								while (rs.next()) {
									String BOOKBARCODE = rs.getString("BOOKBARCODE");
									String bookName = rs.getString("bookName");
									String BOOKAUTOR = rs.getString("BOOKAUTOR");
						%>
						<tr>
							<td><%=BOOKBARCODE %></td>
							<td><a href="bookgl.jsp?bookName=<%=bookName%>"><%=bookName%></a></td>
							<td><a href="bookgl.jsp?BOOKAUTOR=<%=BOOKAUTOR%>"><%=BOOKAUTOR%></a></td>
							<td><a href="bookgl.jsp?BOOKAUTOR=<%=BOOKAUTOR%>"><%=BOOKAUTOR%></a></td>
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