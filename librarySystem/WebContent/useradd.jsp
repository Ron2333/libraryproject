
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
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
	var userName = document.getElementById('userName').value;
	if(userName==null||userName==""){alert("人员名称不能为空!");return false;}
	var loginName = document.getElementById('loginName').value;
	if(loginName==null||loginName==""){alert("登陆用户名不能为空!");return false;}
	var loginPWD = document.getElementById('loginPWD').value;
	if(loginPWD==null||loginPWD==""){alert("登陆密码不能为空!");return false;}
	
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
	<li><a href="#">设备管理</a></li>
    </ul>
    </div>
    
    <div class="formbody">
    
    
    <div id="usual1" class="usual"> 
    
    <div class="itab">
  	<ul> 
    <li><a href="usergl.jsp" >用户列表</a></li> 
    <li><a href="#tab2" class="selected">增加用户</a></li>
  	</ul>
    </div> 
    
	
  	<div id="tab2" class="tabson">
				<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String var_userName="";
				String var_loginName="";
				String var_loginPWD="";
				String message="";
				if(request.getParameter("add") != null&&!request.getParameter("add").equals("")
						&& Integer.parseInt(request.getParameter("add")) == 1){
					if (request.getParameter("userName") != null&&!request.getParameter("userName").equals("")
							&& request.getParameter("userName") != "") {
						var_userName = (String) request.getParameter("userName");
					}
					
					if (request.getParameter("loginName") != null&&!request.getParameter("loginName").equals("")
							&& request.getParameter("loginName") != "") {
						var_loginName = (String) request.getParameter("loginName");
					}
					if (request.getParameter("loginPWD") != null&&!request.getParameter("loginPWD").equals("")
							&& request.getParameter("loginPWD") != "") {
						var_loginPWD = (String) request.getParameter("loginPWD");
					}
					
					int num=0;
					
					try{
					
					String fsql = "select count(*) num from T_USER where LOGINNAME='"+var_loginName+"'";
					pstmt = conn.prepareStatement(fsql);
					
					System.out.println(">>>>useradd.jsp>>"+fsql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						num = rs.getInt("num");
					}
					}catch(Exception e){
						e.printStackTrace();
					}
					
					if(num>=1){
						message="登录名已经存在!";
					}else{
						String insql = "insert into T_USER (USERNAME,LOGINNAME,LOGINPWD)  VALUES('"
						
						+var_userName+"','"
						+var_loginName+"','"
						+var_loginPWD+"')";
						//out.write(insql);
						pstmt = conn.prepareStatement(insql);
						//out.write("提交数据!");
						try{
						pstmt.execute(insql);
						message="完成添加!";
						/* OneBarcodeUtil  obu = new OneBarcodeUtil();
						obu.printBarcode(var_loginName+":"+var_loginPWD); */
						
						
						}catch(Exception e){
							message="添加错误!";
							e.printStackTrace();
						}
					}
				}
				%>
				<div class="formtext" style="color: blue;"><%=message %></div>
				<form method="post" action="useradd.jsp" id="edit_form" name="edit_form">
				<ul class="forminfo">
					<li><label>人员名称<b>*</b></label> <input name="userName"
							type="text" class="dfinput" id="userName" style="width: 218px;"
							  /></li>
						<li><label>登陆用户名<b>*</b></label><input name="loginName"
							type="text" class="dfinput" id="loginName" style="width: 518px;"
							 /></li>
						<li><label>登陆密码<b>*</b></label><input name="loginPWD"
							type="password" class="dfinput" id="loginPWD" style="width: 218px;"
							 /></li>
						
						
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
