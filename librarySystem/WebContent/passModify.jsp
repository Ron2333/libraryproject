<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>密码修改</title>
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
function checkPass(){
	var loginPWD = document.getElementById('loginPWD').value;
	if(loginPWD==null||loginPWD==""){alert("旧密码不能为空!");return false;}
	var newloginPWD = document.getElementById('newloginPWD').value;
	if(newloginPWD==null||newloginPWD==""){alert("新密码不能为空!");return false;}
	var newloginPWD1 = document.getElementById('newloginPWD1').value;
	if(newloginPWD1==null||newloginPWD1==""){alert("新密码确认不能为空!");return false;}
	
	if(newloginPWD!=newloginPWD1){alert("新密码确认错误!");return false;}
	document.getElementById("edit_form").submit();
}
</script>
</head>
<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">密码修改</a></li>
    </ul>
    </div>
    
    <div class="formbody">
    
    <div id="usual1" class="usual"> 
    
    <div class="itab">
  	<ul> 
    <li><a href="#tab2" class="selected">密码修改</a></li>
  	</ul>
    </div> 
    
	
  	<div id="tab2" class="tabson">
				<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String var_loginName="";
				if (request.getParameter("loginName") != null
						&& request.getParameter("loginName") != "") {
					var_loginName = (String) request.getParameter("loginName");
				}
				String var_loginPWD="";
				String var_newloginPWD="";
				String s_loginPWD = "";
				String message="";
				if(request.getParameter("modify") != null
						&& Integer.parseInt(request.getParameter("modify")) == 1){
					
					if (request.getParameter("loginPWD") != null
							&& request.getParameter("loginPWD") != "") {
						var_loginPWD = (String) request.getParameter("loginPWD").trim();
					}
					if (request.getParameter("newloginPWD") != null
							&& request.getParameter("newloginPWD") != "") {
						var_newloginPWD = (String) request.getParameter("newloginPWD");
					}
					try{
					
					String fsql = "select LOGINNAME,LOGINPWD from T_USER where LOGINNAME='"+var_loginName+"'";
					
					pstmt = conn.prepareStatement(fsql);
					//out.write(fsql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						s_loginPWD = rs.getString("LOGINPWD").trim();
					}
					}catch(Exception e){
						e.printStackTrace();
					}
					//out.write("s_loginPWD:"+s_loginPWD+"--var_loginPWD:"+var_loginPWD);
					if(var_loginPWD.equals(s_loginPWD)){
						String insql = "update T_USER set LOGINPWD='"+var_newloginPWD+"' where LOGINNAME='"+var_loginName+"'";
						//out.write(insql);
						pstmt = conn.prepareStatement(insql);
						//out.write("提交数据!");
						try{
						pstmt.executeUpdate(insql);
						message="修改完成!";
						}catch(Exception e){
							message="修改错误!";
							e.printStackTrace();
						}
					}else{
						message="旧密码输入错误!";
					}
				}
				%>
				<div class="formtext" style="color: blue;"><%=message %></div>
				<form method="post" action="passModify.jsp" id="edit_form" name="edit_form">
				<ul class="forminfo">
						<li><label>登陆用户名</label><input name="loginName"
							type="text" class="dfinput" id="loginName" value="<%=var_loginName %>" style="width: 218px;" readonly
							 /></li>
						<li><label>旧密码<b>*</b></label><input name="loginPWD"
							type="text" class="dfinput" id="loginPWD" style="width: 218px;"
							 /></li>
						<li><label>新密码<b>*</b></label><input name="newloginPWD"
							type="text" class="dfinput" id="newloginPWD" style="width: 218px;"
							 /></li>
						 <li><label>确认新密码<b>*</b></label><input name="newloginPWD1"
						type="text" class="dfinput" id="newloginPWD1" style="width: 218px;"
						 /></li>
					<li><label>&nbsp;</label>
					<input name="modify" type="hidden" id="modify" value="1">
					<input name="" type="button" class="btn" value="确认提交" onClick="checkPass();"/></li>
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
