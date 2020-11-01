<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>无标题文档</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="js/select-ui.min.js"></script>
<script type="text/javascript" src="editor/kindeditor.js"></script>
<script language="javascript" type="text/javascript" src="datepicker/WdatePicker.js"></script>
<script type="text/javascript">
 function FormSubmit(num)   
  {
   document.getElementById("ipage").value=num;
   //document.getElementById("UpBankSN").value=num;
   document.search_form.submit();
  }
</script>
  
<script type="text/javascript">
$(document).ready(function(e) {
    $(".select1").uedSelect({
		width : 345			  
	});
	$(".select2").uedSelect({
		width : 167  
	});
	$(".select3").uedSelect({
		width : 150
	});
});
</script>
</head>

<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">业务操作</a></li>
	<li><a href="#">调剂出库</a></li>
    </ul>
    </div>
    
    <div class="formbody">
    
    
    <div id="usual1" class="usual"> 
    
    <div class="itab">
  	<ul> 
    <li><a href="dbckjh.jsp">调剂出库</a></li> 
    <li><a href="dbck_list.jsp" class="selected">出库列表</a></li>
  	</ul>
    </div> 
<%
//java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date currentTime = new java.util.Date();
PreparedStatement pstmt=null;  
ResultSet rs=null;
String today = formatter.format(currentTime);
String var_BankSN=(String)session.getAttribute("bankSN");
String var_LogisticsID="";
String var_miyao="";
String var_ipage="1";
String var_NowState="12";
String var_starTime=today;
String var_endTime=today;
String s_LogisticsID="";

if (request.getParameter("ipage")!=null&&!request.getParameter("ipage").equals("")) {var_ipage=(String)request.getParameter("ipage"); }
if (request.getParameter("miyao")!=null &&!request.getParameter("miyao").equals("")&& request.getParameter("miyao")!=""){
	var_miyao=request.getParameter("miyao");
	var_BankSN=var_miyao.split(":")[0].trim();
	var_LogisticsID=var_miyao.split(":")[1].trim();
	s_LogisticsID=" and LogisticsID="+var_LogisticsID;
	}
	
if (request.getParameter("starTime")!=null &&!request.getParameter("starTime").equals("")&& request.getParameter("starTime")!=""){
	var_starTime=request.getParameter("starTime");
}
if (request.getParameter("endTime")!=null&&!request.getParameter("endTime").equals("") && request.getParameter("endTime")!=""){
	var_endTime=request.getParameter("endTime");
}
if (request.getParameter("NowState")!=null &&!request.getParameter("NowState").equals("")&& request.getParameter("NowState")!=""){
	var_NowState=request.getParameter("NowState");
	
}
String s_BankSN=" and BankSN='"+var_BankSN+"'";
String s_NowState=" ";
String s_starTime=" and UpDateTime>=(to_date('"+var_starTime+"','yyyy-mm-dd')-1)";
String s_endTime=" and UpDateTime<=(to_date('"+var_endTime+"','yyyy-mm-dd')+1)";
%>   
<div id="tab1" class="tabson">    
<ul class="seachform"> 
   <form  method="post" action="dbck_list.jsp" id="search_form" name="search_form">   
    <%-- <li><label>出库状态</label>  
    <div class="vocation">
    <select name="NowState" class="select3" id="NowState">
    <option value="13" <%if (Integer.parseInt(var_NowState)==13){out.println("selected");}%>>调剂出库完成</option>
    <option value="12" <%if (Integer.parseInt(var_NowState)==12){out.println("selected");}%>>调剂待出库</option>
    </select>
    </div>
    </li> --%>
    <li><label>取款秘钥</label><input name="miyao" type="text" class="scinput2" id="miyao" value="<%=var_miyao%>" /></li>
    <li><label>时间</label><input name="starTime" type="text" class="scinput" id="starTime" onClick="WdatePicker()" value="<%=var_starTime%>" /></li>
    <li><label>至</label><input name="endTime" type="text" class="scinput" id="endTime" onClick="WdatePicker()" value="<%=var_endTime%>" /></li> 
    <input name="ipage" type="hidden" id="ipage" value="<%=var_ipage%>">   
    <li><label>&nbsp;</label><input type="submit" class="scbtn" value="查询"/></li>    
   </form>
   </ul> 
</div>
	
<%
if (request.getParameter("qk")!=null &&!request.getParameter("qk").equals("")&& Integer.parseInt(request.getParameter("qk"))==1){
	out.println("<script type='text/javascript'>alert('已成功提交!');</script>");
	}
if (request.getParameter("cancel")!=null && Integer.parseInt(request.getParameter("cancel"))==1){
	out.println("<script type='text/javascript'>alert('已撤回!');</script>");
	}
%>
<div id="tab2" class="tabson">    
    

   <% 
 try{
	 
	int pageSize=50;//每页显示条数
    int pageNow=1;//默认显示第一页  
    int rowCount=0;//总笔数  
    int pageCount=0;  //总页数
    String s_pageNow=var_ipage;  
    if(s_pageNow!=null){  
        pageNow = Integer.parseInt(s_pageNow);  
    }
    if(pageNow < 1){pageNow = 1; }	
    String sql1 = "select count(distinct LogisticsID) from V_LogCashCode where  SERVICETYPEID=1  "+s_LogisticsID+s_BankSN+s_NowState+s_starTime+s_endTime+" order by LogisticsID desc";
	  //out.write(sql1);
    pstmt=conn.prepareStatement(sql1);  
    rs=pstmt.executeQuery();  
    if(rs.next()){  
        rowCount = rs.getInt(1);  
    }  
    if(rowCount%pageSize==0){  
        pageCount = rowCount/pageSize;  
    }else{  
        pageCount = rowCount/pageSize + 1;  
    }
	if(pageNow > pageCount){pageNow = pageCount;}	
 %>   
    <table class="tablelist">
    	<thead>
    	<tr>
        <th>调出时间</th>
        <th>调入银行</th>
        <th>调出秘钥</th>
        <th>状态</th>
        <th>操作</th>        
        </tr>
        </thead>
        <tbody>
<%
	String sql="SELECT * FROM (select t.*,rownum rn from (select distinct LogisticsID, to_char(UpDateTime,'YYYY-MM-DD hh24:mi:ss') UpDateTime,FtBankName,BankSN,NowStateName,fromorto,servicetypename from V_LogCashCode where  SERVICETYPEID=1 "+s_LogisticsID+s_BankSN+s_NowState+s_starTime+s_endTime+" order by LogisticsID desc ) t  WHERE  rownum<="+pageSize*pageNow+") where  rn>="+((pageNow-1)*pageSize+1);
	 //out.write(sql);
    pstmt=conn.prepareStatement(sql);  
    rs=pstmt.executeQuery(); 
    while(rs.next()){  
        String BankSN=rs.getString("BankSN"); 
        String FtBankName=rs.getString("FtBankName");  
        String LogisticsID=rs.getString("LogisticsID");  
        String UpDateTime=rs.getString("UpDateTime"); 
		String NowStateName=rs.getString("NowStateName"); 
		String fromorto=rs.getString("fromorto");
		String servicetypename=rs.getString("servicetypename");
		String getTime = UpDateTime.replaceAll("[[\\s-:punct:]]","");  
%>
        <tr>
        <td><%=UpDateTime%></td>
        <td><%=FtBankName%></td>
        <td><%=BankSN%>:<%=LogisticsID%></td>
        <td><%=servicetypename%></td>
        <td><a href="dbck_ck.jsp?miyao=<%=BankSN%>:<%=LogisticsID%>" class="tablelink">查看</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <a href="download.jsp?fromorto=<%=fromorto%>&&getTime=<%=getTime%>">下载</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
       <%--  <%if (Integer.parseInt(var_NowState)==12){ %>	
        <a href="dbck_del.jsp?miyao=<%=BankSN%>:<%=LogisticsID%>" class="tablelink">撤回</a>
        <% }%> --%>
        </td>
        </tr> 
<%  
    }  
    rs.close();  
    pstmt.close();  
    conn.close();
%>
        </tbody>
    </table>
      <div class="pagin">
    	<div class="message">共&nbsp;<i class="blue"><%=rowCount%></i>&nbsp;条记录，分&nbsp;<i class="blue"><%=pageCount%></i>&nbsp;页显示，当前显示第&nbsp;<i class="blue"><%=pageNow%></i>&nbsp;页</div>
        <ul class="paginList">
        <li class="paginItem"><a href="javascript:FormSubmit(1);" title="第一页"><b>&lt;&lt;</b></a></li>
        <li class="paginItem"><a href="javascript:FormSubmit(<%=pageNow-10%>);" title="上10页"><b>&lt;</b></a></li>
        <%
			int zjMinPage=1; //中间最小页码
			int zjMaxPage=1; //中间最大页码
			zjMinPage=pageNow - 5;
			if(zjMinPage <= 1){
			zjMinPage = 1;
			}
			zjMaxPage=pageNow + 5;
			if(zjMaxPage >= pageCount){
			zjMaxPage = pageCount;
			}
			for(int i=zjMinPage;i<=zjMaxPage;i++){
		%>
        <li class="paginItem<%if(i==pageNow){out.write(" current");}%>"><a href="javascript:FormSubmit(<%=i%>);"><%=i%></a></li>
        <%
			}
		%>
        <li class="paginItem"><a href="javascript:FormSubmit(<%=pageNow+10%>);" title="下10页"><b>&gt;</b></a></li>
        <li class="paginItem"><a href="javascript:FormSubmit(<%=pageCount%>);" title="最末页"><b>&gt;&gt;</b></a></li>
        </ul>
    </div>  
<%
    }catch(Exception e){  
        out.println(e);  
    } 	
%> 
</div> 
	<script type="text/javascript"> 
      $("#usual1 ul").idTabs(); 
    </script>    
    <script type="text/javascript">
	$('.tablelist tbody tr:odd').addClass('odd');
	</script>    
    </div>
      <%
    try{  
        rs.close();  
        pstmt.close();  
        conn.close();  
    }catch(Exception e){  
        //System.out.println(e);  
    } 
%>
</body>
</html>