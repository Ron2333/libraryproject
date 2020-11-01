<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
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
	var functionName = document.getElementById('functionName').value;
	if(functionName==null||functionName==""){alert("功能名称不能为空!");return false;}
	var functionUrl = document.getElementById('functionUrl').value;
	if(functionUrl==null||functionUrl==""){alert("功能地址不能为空!");return false;}
	
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
    <li><a href="function_list.jsp">功能列表</a></li> 
    <li><a href="#tab2"  class="selected">增加功能</a></li>
  	</ul>
    </div> 
    
	
  	<div id="tab2" class="tabson">

				<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String var_functionName="";
				String message="";
				long funID=0;
				if(request.getParameter("add") != null
						&& Integer.parseInt(request.getParameter("add")) == 1){
					if (request.getParameter("functionName") != null&&!request.getParameter("functionName").equals("")
							&& request.getParameter("functionName") != "") {
						var_functionName = (String) request.getParameter("functionName");
					}
					String var_functionUrl="";
					if (request.getParameter("functionUrl") != null&&!request.getParameter("functionUrl").equals("")
							&& request.getParameter("functionUrl") != "") {
						var_functionUrl = (String) request.getParameter("functionUrl");
					}
					String var_upfunctionID="";
					if (request.getParameter("upfunctionID") != null&&!request.getParameter("upfunctionID").equals("")
							&& request.getParameter("upfunctionID") != "") {
						var_upfunctionID = (String) request.getParameter("upfunctionID");
					}

					 String sqll="select FunctionID_SEQ.nextval functionID from dual";
					 pstmt=conn.prepareStatement(sqll);  
					 rs=pstmt.executeQuery(); 
					 if(rs.next()){funID=Long.parseLong(rs.getString("functionID")); }
					String insql = "insert into T_FUNCTION (functionID,FUNCTIONNAME,FUNCTIONURL,UPFUNCTIONID) VALUES("+funID+",'"
					+var_functionName+"','"
					+var_functionUrl +"',"+var_upfunctionID+")";
					//out.write(insql);
					System.out.println(insql);
					pstmt = conn.prepareStatement(insql);
					//out.write("提交修改!");
					try{
					pstmt.execute(insql);
					message="完成添加!";
//					out.println("<div class='formtext'><b>信息已修改成功!</b><a href='function_list.jsp?functionName="
//							+ new String(var_functionName.getBytes("ISO-8859-1"), "utf-8") + "'> 点击查看</a></div>");
					}catch(Exception e){
						message="添加错误!";
						e.printStackTrace();
					}
					pstmt.close();
				}
				%>
				<div class="formtext" style="color: blue;"><%=message %></div>
				<form method="post" action="tjgn.jsp" id="edit_form" name="edit_form">
				<ul class="forminfo">
					<li><label>功能名称<b>*</b></label>
					<input id="functionName" name="functionName" type="text" class="dfinput"  style="width: 218px;" /></li>
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
					    <option value="<%=functionID%>"><%=functionName%></option>
					    <%}
								pstmt.close();
								rs.close();
					    %> 
					    </select>
						</div>
					</li>
					<li><label>功能地址<b>*</b></label>
					<input id="functionUrl" name="functionUrl" type="text" class="dfinput"  style="width: 518px;" /></li>
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
