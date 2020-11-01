<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
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
function checkNull(){
	var roleName = document.getElementById('roleName').value;
	if(roleName==null||roleName==""){alert("角色名称不能为空!");return false;}
	
	document.getElementById("edit_form").submit();
}
</script>
</head>

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
    <li><a href="juese.jsp" >角色列表</a></li> 
    <li><a href="#tab2" class="selected">增加角色</a></li>
  	</ul>
    </div> 
  	<div id="tab2" class="tabson">
				<%
				PreparedStatement pstmt = null;
				String var_roleName="";
				String var_upRoleID = "";
				String message="";
				if(request.getParameter("add") != null&&!request.getParameter("add").equals("")
						&& Integer.parseInt(request.getParameter("add")) == 1){
					if (request.getParameter("roleName") != null&&!request.getParameter("roleName").equals("")
							&& request.getParameter("roleName") != "") {
						var_roleName = (String) request.getParameter("roleName");
					}
					if (request.getParameter("upRoleID") != null&&!request.getParameter("upRoleID").equals("")
							&& request.getParameter("upRoleID") != "") {
						var_upRoleID = (String) request.getParameter("upRoleID");
					}
					String insql = "insert into T_ROLE (ROLENAME,UPROLEID) VALUES('"
					+var_roleName +"',"+var_upRoleID+")";
					//out.write(insql);
					pstmt = conn.prepareStatement(insql);
					//out.write("提交修改!");
					try{
					pstmt.execute(insql);
					message="完成添加!";
//					out.println("<div class='formtext'><b>信息已修改成功!</b><a href='function_list.jsp?functionName="
//							+ new String(var_functionName.getBytes("ISO-8859-1"), "utf-8") + "'> 点击查看</a></div>");
					}catch(Exception e){
						e.printStackTrace();
						message="添加错误!";
					}
				}
				%>
				<div class="formtext" style="color: blue;"><%=message %></div>
				<form method="post" action="jueseadd.jsp" id="edit_form" name="edit_form">
				<ul class="forminfo">
						<li><label>角色名称<b>*</b></label><input name="roleName"
							type="text" class="dfinput" id="roleName" style="width: 518px;"
							/></li>
				<li><label>上级角色</label>
					<div class="vocation">
						<select class="select3" id="upRoleID" name="upRoleID">
						    <option value="0">-请选择-</option>
						    <%
							ResultSet rs = null;
								String fsql = "select ROLEID,ROLENAME from T_ROLE " ; 
									//out.write(fsql);
									pstmt = conn.prepareStatement(fsql);
									rs = pstmt.executeQuery();
									while (rs.next()) {
										String roleID = rs.getString("ROLEID");
										String roleName = rs.getString("ROLENAME");
							%>
						    <option value="<%=roleID%>"><%=roleName%></option>
						    <%}
									pstmt.close();
									rs.close();
						    %> 
					    </select>
						</div>
					</li>
					<li><label>&nbsp;</label>
					<input name="add" type="hidden" id="add" value="1">
					<input name="" type="button" class="btn" value="确认提交" onClick="checkNull();"/></li>
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
		pstmt.close();
		conn.close();
	} catch (Exception e) {
		//System.out.println(e);  
	}
%>
</html>
