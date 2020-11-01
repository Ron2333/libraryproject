
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>学生管理</title>
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
	var studentName = document.getElementById('studentName').value;
	if(studentName==null||studentName==""){alert("姓名不能为空!");return false;}
	var IDCard = document.getElementById('IDCard').value;
	if(IDCard==null||IDCard==""){alert("证件号不能为空!");return false;}
	var StuAge = document.getElementById('StuAge').value;
	if(StuAge==null||StuAge==""){alert("年龄不能为空!");return false;}
	
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
	<li><a href="#">系统管理</a></li>
	<li><a href="#">借书卡注册</a></li>
	
    </ul>
    </div>
    
    <div class="formbody">
    
    
    <div id="usual1" class="usual"> 
    
    <div class="itab">
  	<ul> 
    <li><a href="#tab2" class="selected">借书卡注册</a></li>
  	</ul>
    </div> 
    
	
  	<div id="tab2" class="tabson">
				<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String var_studentName="";
				String var_IDCard="";
				String var_StuAge="";
				String var_StuSex= "";
				String var_StuTel= "";
				String var_StuGrade= "";
				String message="";
				if(request.getParameter("add") != null&&!request.getParameter("add").equals("")
						&& Integer.parseInt(request.getParameter("add")) == 1){
					if (request.getParameter("studentName") != null&&!request.getParameter("studentName").equals("")
							&& request.getParameter("studentName") != "") {
						var_studentName = (String) request.getParameter("studentName");
					}
					
					if (request.getParameter("IDCard") != null&&!request.getParameter("IDCard").equals("")
							&& request.getParameter("IDCard") != "") {
						var_IDCard = (String) request.getParameter("IDCard");
					}
					if (request.getParameter("StuAge") != null&&!request.getParameter("StuAge").equals("")
							&& request.getParameter("StuAge") != "") {
						var_StuAge = (String) request.getParameter("StuAge");
					}
					if (request.getParameter("StuSex") != null&&!request.getParameter("StuSex").equals("")
							&& request.getParameter("StuSex") != "") {
						var_StuSex = (String) request.getParameter("StuSex");
					}
					if (request.getParameter("StuTel") != null&&!request.getParameter("StuTel").equals("")
							&& request.getParameter("StuTel") != "") {
						var_StuTel = (String) request.getParameter("StuTel");
					}
					if (request.getParameter("StuGrade") != null&&!request.getParameter("StuGrade").equals("")
							&& request.getParameter("StuGrade") != "") {
						var_StuGrade = (String) request.getParameter("StuGrade");
					}
					int num=0;
					
					try{
					
					String fsql = "select count(*) num from T_STUDENT where IDCARD='"+var_IDCard+"'";
					pstmt = conn.prepareStatement(fsql);
					
					System.out.println(">>>>bookList.jsp>>"+fsql);
					rs = pstmt.executeQuery();
					while (rs.next()) {
						num = rs.getInt("num");
					}
					}catch(Exception e){
						e.printStackTrace();
					}
					
					if(num>=1){
						message="条形码已经存在!";
					}else{
						String insql = "insert into T_STUDENT (STUNAME,IDCARD,STUAGE,STUSEX，STUTEL，STUGRADE)  VALUES('"
						
						+var_studentName+"','"
						+var_IDCard+"','"
						+var_StuAge+ "','"
						+var_StuSex+  "','"
						+var_StuTel+ "','"
						+var_StuGrade+"')";
						//out.write(insql);
						pstmt = conn.prepareStatement(insql);
						//out.write("提交数据!");
						try{
						pstmt.execute(insql);
						message="完成添加!";
						/* OneBarcodeUtil  obu = new OneBarcodeUtil();
						obu.printBarcode(var_IDCard+":"+var_StuAge); */
						
						
						}catch(Exception e){
							message="添加错误!";
							e.printStackTrace();
						}
					}
				}
				%>
				<div class="formtext" style="color: blue;"><%=message %></div>
				<form method="post" action="studentList.jsp" id="edit_form" name="edit_form">
				<ul class="forminfo">
					<li><label>姓名<b>*</b></label> <input name="studentName"
							type="text" class="dfinput" id="studentName" style="width: 218px;"
							  /></li>
						<li><label>证件号<b>*</b></label><input name="IDCard"
							type="text" class="dfinput" id="IDCard" style="width: 518px;"
							 /></li>
						<li><label>年龄<b>*</b></label><input name="StuAge"
							type="text" class="dfinput" id="StuAge" style="width: 218px;"
							 /></li>
						<li><label>性别<b>*</b></label><input name="StuSex"
							type="text" class="dfinput" id="StuSex" style="width: 218px;"
							 /></li>
						<li><label>电话号码<b>*</b></label><input name="StuTel"
							type="text" class="dfinput" id="StuTel" style="width: 218px;"
							 /></li>
						<li><label>年级<b>*</b></label><input name="StuGrade"
							type="text" class="dfinput" id="StuGrade" style="width: 218px;"
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
