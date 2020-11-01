
<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>管理</title>
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
	var BOOKNAME = document.getElementById('BOOKNAME').value;
	if(BOOKNAME==null||BOOKNAME==""){alert("书名不能为空!");return false;}
	var BOOKBARCODE = document.getElementById('BOOKBARCODE').value;
	if(BOOKBARCODE==null||BOOKBARCODE==""){alert("条形码不能为空!");return false;}
	var BOOKAUTOR = document.getElementById('BOOKAUTOR').value;
	if(BOOKAUTOR==null||BOOKAUTOR==""){alert("作者不能为空!");return false;}
	
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
     <li><a  href="booksgl.jsp"  >书籍列表</a></li> 
    <li><a href="#tab2" class="selected" >增加书目</a></li>
  	</ul>
    </div> 
    
	
  	<div id="tab2" class="tabson">
				<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String var_BOOKBARCODE="";
				String var_BOOKNAME="";
				String var_BOOKAUTOR="";
				String var_BOOKSTATUS= "";
				String var_BOOKOPERATOR= "";
				String message="";
				if(request.getParameter("add") != null&&!request.getParameter("add").equals("")
						&& Integer.parseInt(request.getParameter("add")) == 1){
					if (request.getParameter("BOOKBARCODE") != null&&!request.getParameter("BOOKBARCODE").equals("")
							&& request.getParameter("BOOKBARCODE") != "") {
						var_BOOKBARCODE = (String) request.getParameter("BOOKBARCODE");
					}
					
					if (request.getParameter("BOOKNAME") != null&&!request.getParameter("BOOKNAME").equals("")
							&& request.getParameter("BOOKNAME") != "") {
						var_BOOKNAME = (String) request.getParameter("BOOKNAME");
					}
					if (request.getParameter("BOOKAUTOR") != null&&!request.getParameter("BOOKAUTOR").equals("")
							&& request.getParameter("BOOKAUTOR") != "") {
						var_BOOKAUTOR = (String) request.getParameter("BOOKAUTOR");
					}
					if (request.getParameter("BOOKSTATUS") != null&&!request.getParameter("BOOKSTATUS").equals("")
							&& request.getParameter("BOOKSTATUS") != "") {
						var_BOOKSTATUS = (String) request.getParameter("BOOKSTATUS");
					}
					if (request.getParameter("BOOKOPERATOR") != null&&!request.getParameter("BOOKOPERATOR").equals("")
							&& request.getParameter("BOOKOPERATOR") != "") {
						var_BOOKOPERATOR = (String) request.getParameter("BOOKOPERATOR");
					}

					int num=0;
					
					try{
					
					String fsql = "select count(*) num from T_BOOKBARCODE where BOOKBARCODE='"+var_BOOKBARCODE+"'";
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
						String insql = "insert into T_BOOKS (BOOKBARCODE,BOOKNAME,BOOKAUTOR,BOOKSTATUS，BOOKOPERATOR)  VALUES('"
						
						+var_BOOKBARCODE+"','"
						+var_BOOKNAME+"','"
						+var_BOOKAUTOR+ "','"
						+var_BOOKSTATUS+  "','"
					  	+var_BOOKOPERATOR+"')";
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
				<form method="post" action="booksList.jsp" id="edit_form" name="edit_form">
				<ul class="forminfo">
					<li><label>图书码<b>*</b></label> <input name="BOOKBARCODE"
							type="text" class="dfinput" id="BOOKBARCODE" style="width: 218px;"
							  /></li>
						<li><label>书名<b>*</b></label><input name="BOOKNAME"
							type="text" class="dfinput" id="BOOKNAME" style="width: 518px;"
							 /></li>
						<li><label>作者<b>*</b></label><input name="BOOKAUTOR"
							type="text" class="dfinput" id="BOOKAUTOR" style="width: 218px;"
							 /></li>
						<li><label>图书状态(0 或 1)<b>*</b></label><input name="BOOKSTATUS"
							type="text" class="dfinput" id="BOOKSTATUS" style="width: 218px;" min="0" max="1"
							 /></li>
						<li><label>图书管理员号<b>*</b></label><input name="BOOKOPERATOR"
							type="text" class="dfinput" id="BOOKOPERATOR" style="width: 218px;"
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
