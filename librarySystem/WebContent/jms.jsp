<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<%@page import="util.MyUtil"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新物流管理系统</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.idTabs.min.js"></script>


<!-- <script type="text/javascript">


function myrefresh(){
	
	 
   window.location.reload();
  
  
}

setTimeout('myrefresh()',5000);  //指定1秒刷新一次

//alert(aaa);

</script> -->
<% request.setCharacterEncoding("utf-8");%>  
<%
//设置输出信息的格式及字符集  
response.setContentType("text/xml; charset=utf-8");
response.setHeader("Pragma","No-cache"); 
response.setHeader("Cache-Control","no-cache");
response.setDateHeader("Expires", -10); 
response.flushBuffer();

%>
</head>

<%

PreparedStatement pstmt=null;
ResultSet rs=null;
ResultSet rs1=null;
ResultSet rs2=null;
ResultSet rs3=null;

int outcount=0;
int real=0;
String pack="";
String cashvouchername="";
String cashtypename="";
String bankname="";
String packEpc="";

int planAll=0;
int nowAll=0;
%>
<body>

<response>

<% 
try{
       
String sql="select outcount ,cashvoucherid,cashtypeid from t_tempout where isuse=1 group by cashvoucherid,cashtypeid,outcount";
System.out.println("=========="+sql);
pstmt=conn.prepareStatement(sql);
rs=pstmt.executeQuery();
while(rs.next()){
	outcount=rs.getInt("outcount");
	
	int quanbie=rs.getInt("cashvoucherid");
	int leixing=rs.getInt("cashtypeid");
	
	int i=0;
	sql="select t.cashvouchername,t1.cashtypename from t_cashvoucher t,t_cashtype t1 where t.cashvoucherid="+quanbie+" and t1.cashtypeid="+leixing+"";
	pstmt=conn.prepareStatement(sql);  
	System.out.println("sql==="+sql);
    rs3=pstmt.executeQuery();
    if(rs3.next()){
    	cashvouchername=rs3.getString("cashvouchername");
    	cashtypename=rs3.getString("cashtypename");
    }
    rs3.close();
    pstmt.close();
    sql="select distinct(twopackcode),epc from t_tag where epctag=0 and twopackcode is not null "; 
	System.out.println("=========="+sql);
	pstmt=conn.prepareStatement(sql);
    rs1=pstmt.executeQuery();
    while(rs1.next()){
    	
    	String tag=rs1.getString("twopackcode");
    	String epc=rs1.getString("epc");
    	String ztag=epc.substring(8);
		int index=0;
		int count=0;
		while(true){
			index = ztag.indexOf("3A", index + 1);  
			if (index > 0) {  
			 count++;  
			} else {  
			 break;  
			}  
		}
		
    	if(epc.length()==24||count>2){
			sql="select cashvoucherid ,cashtypeid from t_onetwopack where twopackcode='"+tag+"' order by updatetime desc";
			System.out.println("sql=="+sql);
			pstmt=conn.prepareStatement(sql);
			rs2=pstmt.executeQuery();
			if(rs2.next()){
				int cashvoucherid=rs2.getInt("cashvoucherid");
				int cashtypeid=rs2.getInt("cashtypeid");
				if(quanbie==cashvoucherid&&leixing==cashtypeid){
					i++;
				}
			
			}else if(epc.length()==24){
				String cash = epc.substring(20, 24);
				int voucherid = Integer.parseInt(MyUtil.toStringHex1(cash)) ;
				if(voucherid==quanbie){
					i++;
				}
			}else{
				String tag_id = MyUtil.toStringHex1(ztag);
				String arr[] = tag_id.split(":");

				int cashvoucherid = Integer.parseInt(arr[3]);
				if(quanbie==cashvoucherid){
					i++;
				}
			}
			rs2.close();
		}
    }
    rs1.close();
	planAll=planAll+outcount;
	nowAll=nowAll+i;
	System.out.println("cashvouchername"+cashvouchername+"cashtypename"+cashtypename+"outcount"+outcount);
%>
<packageCode>
	<voucher><%=cashvouchername %></voucher>
	<typename><%=cashtypename %></typename>
    <jihua><%=outcount %></jihua>
    <shiji><%=i %></shiji>
</packageCode>  
<%
			
	
}
%>
     
    <zong>
     	<%=planAll %></zong>  
    <zong1> <%=nowAll %></zong1>
      

<%
		
rs.close();
rs3.close();
pstmt.close();
conn.close();
}catch(Exception e){
	e.printStackTrace();
}
%>	
</response>
</body>

</html>
