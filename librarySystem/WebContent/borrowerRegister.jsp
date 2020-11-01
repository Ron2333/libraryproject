<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>借阅登记</title>
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
function checkNull(){
	var IDCARD = document.getElementById('IDCARD').value;
	if(IDCARD==null||IDCARD==""){alert("借书码不能为空!");return false;}
	var BOOKBARCODE = document.getElementById('BOOKBARCODE').value;
	if(BOOKBARCODE==null||BOOKBARCODE==""){alert("条形码不能为空!");return false;}
	
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
	<li><a href="#">业务管理</a></li>
	<li><a href="#">借阅登记</a></li>
    </ul>
    </div>
    
    <div class="formbody">
    
    
    <div id="usual1" class="usual"> 
    
    <div class="itab">
  	<ul> 
  	<li><a  href="booksborrowlist.jsp"  >借书列表</a></li> 
    <li><a href="#tab2" class="selected" >登记借书</a></li> 
  	</ul>
    </div> 
    	<div id="tab2" class="tabson">
				<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;
				String var_BOOKBARCODE="";
				String var_IDCARD="";
				String var_BORROWTIME="";
				String var_EXPIRETIME= "";
				String var_ISUSE= "";
				String message="";
				if(request.getParameter("add") != null&&!request.getParameter("add").equals("")
						&& Integer.parseInt(request.getParameter("add")) == 1){
					if (request.getParameter("BOOKBARCODE") != null&&!request.getParameter("BOOKBARCODE").equals("")
							&& request.getParameter("BOOKBARCODE") != "") {
						var_BOOKBARCODE = (String) request.getParameter("BOOKBARCODE");
					}
					
					if (request.getParameter("IDCARD") != null&&!request.getParameter("IDCARD").equals("")
							&& request.getParameter("IDCARD") != "") {
						var_IDCARD = (String) request.getParameter("IDCARD");
					}
					if (request.getParameter("BORROWTIME") != null&&!request.getParameter("BORROWTIME").equals("")
							&& request.getParameter("BORROWTIME") != "") {
						var_BORROWTIME = (String) request.getParameter("BORROWTIME");
					}
					if (request.getParameter("EXPIRETIME") != null&&!request.getParameter("EXPIRETIME").equals("")
							&& request.getParameter("EXPIRETIME") != "") {
						var_EXPIRETIME = (String) request.getParameter("EXPIRETIME");
					}
					if (request.getParameter("ISUSE") != null&&!request.getParameter("ISUSE").equals("")
							&& request.getParameter("ISUSE") != "") {
						var_ISUSE = (String) request.getParameter("ISUSE");
					}

					int num=0;
					
					try{
					
					String fsql = "select count(*) num from T_BOOKSBORROW where BOOKBARCODE='"+var_BOOKBARCODE+"'";
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
						String insql = "insert into T_BOOKSBORROW (BOOKBARCODE,IDCARD，ISUSE)  VALUES('"
						
						+var_BOOKBARCODE+"','"
						+var_IDCARD+"','"
					  	+var_ISUSE+"')";
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
				<form method="post" action="borrowerRegister.jsp" id="edit_form" name="edit_form">
				<ul class="forminfo">
					<li><label>图书码<b>*</b></label> <input name="BOOKBARCODE"
							type="text" class="dfinput" id="BOOKBARCODE" style="width: 218px;"
							  /></li>
						<li><label>借书码<b>*</b></label><input name="IDCARD"
							type="text" class="dfinput" id="IDCARD" style="width: 518px;"
							 /></li>
						<li><label>是否启用<b>*</b></label><input name="ISUSE"
							type="text" class="dfinput" id="ISUSE" style="width: 218px;"
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