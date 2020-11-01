<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>统计报表</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<!-- <link href="css/select.css" rel="stylesheet" type="text/css" /> -->
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="js/select-ui.min.js"></script>
<script type="text/javascript" src="editor/kindeditor.js"></script>
<script language="javascript" type="text/javascript" src="datepicker/WdatePicker.js"></script> 
<script type="text/javascript">
 function FormSubmit(num)   
  {
   document.getElementById("ipage").value=num;
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
		width : 100
	});
});
</script>
</head>
<%
//java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd");
java.util.Date currentTime = new java.util.Date();
String today = formatter.format(currentTime);
PreparedStatement pstmt=null;  
ResultSet rs=null;
String sql="";
String var_ipage="1";
String var_starTime=today;
String var_endTime=today;
String var_cashvoucher="";
String var_serviceType="";
String var_BankSN=(String)session.getAttribute("bankSN");;
String s_serviceType="";
String s_banksn="";
String s_cashvoucher="";
String var_cashtype="";
String s_cashtype="";
String v_banksn="";
if(var_BankSN.equals("323")){
	s_banksn="";
}else{
	s_banksn=" and banksn='"+var_BankSN+"'";
}
long sumvalue=0;

if (request.getParameter("ipage")!=null) {var_ipage=(String)request.getParameter("ipage"); }

	
if (request.getParameter("starTime")!=null && request.getParameter("starTime")!=""){
	var_starTime=request.getParameter("starTime");
}
if (request.getParameter("endTime")!=null && request.getParameter("endTime")!=""){
	var_endTime=request.getParameter("endTime");
}
if (request.getParameter("serviceType")!=null && request.getParameter("serviceType")!=""){
	var_serviceType=request.getParameter("serviceType");
}
if (request.getParameter("banksn")!=null && request.getParameter("banksn")!=""){
	v_banksn=request.getParameter("banksn");
	s_banksn=" and BANKSN='"+v_banksn+"'";
}
if (request.getParameter("cashvoucher")!=null && request.getParameter("cashvoucher")!=""){
	var_cashvoucher=request.getParameter("cashvoucher");
}
if (request.getParameter("cashtype")!=null && request.getParameter("cashtype")!=""){
	var_cashtype=request.getParameter("cashtype");
}
System.out.println("cashvou==="+var_cashtype);
String s_starTime=" and UpDateTime>=(to_date('"+var_starTime+"','yyyy-mm-dd'))";
String s_endTime=" and UpDateTime<=(to_date('"+var_endTime+"','yyyy-mm-dd')+1)";
//String s_atmcode=" and AtmBox='"+var_atmcode+"'";
if(var_cashtype!=null&&!var_cashtype.equals("0")&&!var_cashtype.equals("")){
	s_cashtype=" and CASHTYPEID="+var_cashtype+"";
	System.out.println("cashvou"+var_cashtype);
}
if(var_serviceType!=null&&!var_serviceType.equals("0")&&!var_serviceType.equals("")){
	s_serviceType=" and SERVICETYPEID="+var_serviceType+"";
}

	

if(var_cashvoucher!=null&&!var_cashvoucher.equals("0")&&!var_cashvoucher.equals("")){
	s_cashvoucher=" and CASHVOUCHERID="+var_cashvoucher+"";
}
%> 
<body>

	<div class="place">
    <span>位置：</span>
    <ul class="placeul">
    <li><a href="#">首页</a></li>
    <li><a href="#">统计报表</a></li>
	<li><a href="#">统计查询</a></li>
    </ul>
    </div>
    <div class="formbody">
    <div id="usual1" class="usual"> 
    <div class="itab">
  	<ul> 
    <li><a href="tjbb.jsp" class="selected">物流统计</a></li> 
    <!-- <li><a href="tjbbcashcode.jsp">统计查询</a></li> -->
    <!-- <li><a href="#">统计查询</a></li> -->
  	</ul>
    </div> 
<div id="tab1" class="tabson">
    <ul class="seachform">
     <form  method="post" action="tjbb.jsp" id="search_form" name="search_form">
    <li><label>业务类型</label>
      <span id="serviceType">
      <select name="serviceType" id="serviceType" class="select" size=1 >
	     <option value="0">-请选择-</option>
	    <%
			String fsql = "select SERVICETYPEID,SERVICETYPENAME from T_SERVICETYPE ";
				System.out.println(fsql);
				pstmt = conn.prepareStatement(fsql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					String serviceTypeID = rs.getString("SERVICETYPEID");
					String serviceTypeName = rs.getString("SERVICETYPENAME");
					//if(serviceTypeID.equals("11")||serviceTypeID.equals("1")||serviceTypeID.equals("2")||serviceTypeID.equals("6")){
		%>
	    <option value="<%=serviceTypeID%>" <%if(var_serviceType.equals(serviceTypeID)){ %>selected<%} %>><%=serviceTypeName%></option>
	    <%}
	    //}
				pstmt.close();
				rs.close();
	    %>  
     </select>
   </span></li>
 <%
if(var_BankSN.equals("323")){
%>   
   <li><label>银行机构</label>
      <span id="banksn">
      <select name="banksn" id="banksn" class="select" size=1 >
	     <option value="">-请选择-</option>
	    <%
			String bsql = "select BANKSN,BANKNAME from T_BANK ";
				System.out.println(bsql);
				pstmt = conn.prepareStatement(bsql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					String banksn = rs.getString("BANKSN");
					String bankName = rs.getString("BANKNAME");
		%>
	    <option value="<%=banksn%>" <%if(v_banksn.equals(banksn)){ %>selected<%} %>><%=bankName%></option>
	    <%}
				pstmt.close();
				rs.close();
	    %>  
     </select>
   </span></li>
    <%
}
   %>
   <li><label>券别类型</label>
      <span id="cashvoucher">
      <select name="cashvoucher" id="cashvoucher" class="select" size=1 >
	     <option value="0">-请选择-</option>
	    <%
			String csql = "select CASHVOUCHERID,CASHVOUCHERNAME from T_CASHVOUCHER ";
				System.out.println(csql);
				pstmt = conn.prepareStatement(csql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					String cashvoucherID = rs.getString("CASHVOUCHERID");
					String cashvoucherName = rs.getString("CASHVOUCHERNAME");
		%>
	    <option value="<%=cashvoucherID%>"  <%if(var_cashvoucher.equals(cashvoucherID)){ %>selected<%} %>><%=cashvoucherName%></option>
	    <%}
				pstmt.close();
				rs.close();
	    %>  
     </select>
   </span></li> 
   <li><label>完残类型</label>
      <span id="cashtype">
      <select name="cashtype" id="cashtype" class="select" size=1 >
	     <option value="0">-请选择-</option>
	    <%
			String tcsql = "select CASHTYPEID,CASHTYPENAME from T_CASHTYPE ";
				System.out.println(tcsql);
				pstmt = conn.prepareStatement(tcsql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					String cashtypeID = rs.getString("CASHTYPEID");
					String cashtypeName = rs.getString("CASHTYPENAME");
		%>
	    <option value="<%=cashtypeID%>"  <%if(var_cashtype.equals(cashtypeID)){ %>selected<%} %>><%=cashtypeName%></option>
	    <%}
				pstmt.close();
				rs.close();
	    %>  
     </select>
   </span></li>
   </ul>
    <ul class="placeul">
    <li><label>时间</label><input name="starTime" type="text" class="scinput" id="starTime" onClick="WdatePicker()" value="<%=var_starTime%>" /></li>
    <li><label>至</label><input name="endTime" type="text" class="scinput" id="endTime" onClick="WdatePicker()" value="<%=var_endTime%>" /></li>
     <input name="ipage" type="hidden" id="ipage" value="<%=var_ipage%>">
    <li><label>&nbsp;</label><input type="submit" class="scbtn" value="查询"/></li>
    </form>
    </ul>
    <%
    if(var_serviceType!=null&&!var_serviceType.equals("0")&&!var_serviceType.equals("")){
	sql="SELECT distinct to_char(UpDateTime,'YYYY-MM-DD hh24:mi:ss') UpDateTime,BANKSN,BANKNAME,SERVICETYPEID,SERVICETYPENAME,NOWSTATE,NOWSTATENAME,PACKHIERARCHY,PACKCODE,CASHVOUCHERID "+
			" from v_Logcashcode where 1=1 and PACKHIERARCHY=2 "+s_serviceType+s_cashtype+s_banksn+s_cashvoucher+s_starTime+s_endTime+" order by UpDateTime  "; 
	System.out.println(">>>tjbb.jsp 物流信息统计>>>"+sql);
	pstmt=conn.prepareStatement(sql);  
    rs=pstmt.executeQuery(); 
    while(rs.next()){
    	 int packh=rs.getInt("PACKHIERARCHY");
    	 String cashvoucherid=rs.getString("CASHVOUCHERID");
    	 int parvalue=0;
         
         if(cashvoucherid.equals("98")||cashvoucherid.equals("27")||cashvoucherid.equals("5")||cashvoucherid.equals("6")){
         	parvalue=100;
         }
         if(cashvoucherid.equals("4")||cashvoucherid.equals("7")){
         	parvalue=50;
         }
         if(cashvoucherid.equals("3")||cashvoucherid.equals("8")){
         	parvalue=20;
         }
         if(cashvoucherid.equals("2")||cashvoucherid.equals("9")){
         	parvalue=10;
         }
         if(cashvoucherid.equals("1")||cashvoucherid.equals("10")){
         	parvalue=5;
         }
    	 if(packh==1){
    		 sumvalue=sumvalue+parvalue*1000;
    	 }
    	 if(packh==2){
    		 sumvalue=sumvalue+parvalue*1000*25;
    	 }
    }
} %>
<br/>
<br/>
<div class="formtitle"><%
if(var_serviceType!=null&&!var_serviceType.equals("0")&&!var_serviceType.equals("")){ %><span>总计金额：<%=sumvalue%>元</span><%} %></div> 
  <% 
 try{
	 
	int pageSize=20;//每页显示条数
    int pageNow=1;//默认显示第一页  
    int rowCount=0;//总笔数  
    int pageCount=0;  //总页数
    String s_pageNow=var_ipage;  
    if(s_pageNow!=null){  
        pageNow = Integer.parseInt(s_pageNow);  
    }
    if(pageNow < 1){pageNow = 1; }
	
	sql="SELECT count(*) FROM (SELECT distinct to_char(UpDateTime,'YYYY-MM-DD hh24:mi:ss') UpDateTime,BANKSN,BANKNAME,SERVICETYPEID,SERVICETYPENAME,NOWSTATE,NOWSTATENAME,PACKHIERARCHY,PACKCODE "+
			" from v_Logcashcode where 1=1 and PACKHIERARCHY=2 "+s_serviceType+s_cashtype+s_cashvoucher+s_banksn+s_starTime+s_endTime+" order by UpDateTime ) t ";
	System.out.println(">>>tjbb.jsp 物流信息>>>"+sql);
    pstmt=conn.prepareStatement(sql);  
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
   <br>
    <table class="tablelist">
    	<thead>
    	<tr>
        <th>序号</th>
        <th>时间</th>
        <th>机构名称</th>
        <th>业务类型名称</th>
        <th>状态</th>
        <th>包装号</th>
        <th>券别</th>
        <!-- <th>类别</th> -->
        </tr>
        </thead>
        <tbody>
<%
    sql="SELECT * FROM (select t.*,rownum rn from (SELECT distinct to_char(UpDateTime,'YYYY-MM-DD hh24:mi:ss') UpDateTime,BANKSN,BANKNAME,SERVICETYPEID,SERVICETYPENAME,NOWSTATE,NOWSTATENAME,PACKHIERARCHY,PACKCODE,CASHVOUCHERNAME,CASHTYPENAME "+
" from v_Logcashcode where 1=1 and PACKHIERARCHY=2  "+s_serviceType+s_banksn+s_cashtype+s_cashvoucher+s_starTime+s_endTime+" order by UpDateTime ) t  WHERE  rownum<="+pageSize*pageNow+") where  rn>="+((pageNow-1)*pageSize+1); 
System.out.println(">>>tjbb.jsp 物流信息查询>>>"+sql);


	 int j=0;
    pstmt=conn.prepareStatement(sql);  
    rs=pstmt.executeQuery(); 
    while(rs.next()){
		 ++j;
        String upDateTime=rs.getString("UpDateTime"); 
        String bankSN=rs.getString("BANKSN");  
        String bankName=rs.getString("BANKNAME");
        String serviceTypeID=rs.getString("SERVICETYPEID");
        String serviceTypeName=rs.getString("SERVICETYPENAME");
        String nowstateName=rs.getString("NOWSTATENAME");
        String packCode=rs.getString("PACKCODE");
        String cashvouchername=rs.getString("CASHVOUCHERNAME");
        String cashtypename=rs.getString("CASHTYPENAME");
%>
        <tr>
        <td><%=j+(pageNow-1)*pageSize%></td>
        <td><%=upDateTime%></td>
        <td><%=bankName%></td>
        <td><%=serviceTypeName%></td>
        <td><%=nowstateName%></td>
        <td><%=packCode%></td>
        <td><%=cashvouchername%></td>
        <%-- <td><%=cashtypename%></td> --%>
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
</div> 
</div>
</body>
<%
    try{  
        rs.close();  
        pstmt.close();  
        conn.close();  
    }catch(Exception e){  
        //System.out.println(e);  
    } 
%>
</html>
