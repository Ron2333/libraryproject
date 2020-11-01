<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@ include  file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新物流管理系统</title>
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/select.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/jquery.idTabs.min.js"></script>
<script type="text/javascript" src="js/select-ui.min.js"></script> 
<style>
.STYLE3 {
	color: #FF0000;
	font-size: 50px;
}


.red{color:red;}

.green{color:green;}

</style>
<script type="text/javascript">

var XMLHttpReq;  
//创建XMLHttpRequest对象         
function createXMLHttpRequest() {  
if(window.XMLHttpRequest) { //Mozilla 浏览器  
    XMLHttpReq = new XMLHttpRequest();  
}  
else if (window.ActiveXObject) { // IE浏览器  
    try {  
        XMLHttpReq = new ActiveXObject("Msxml2.XMLHTTP");  
    } catch (e) {  
        try {  
            XMLHttpReq = new ActiveXObject("Microsoft.XMLHTTP");  
        } catch (e) {}  
    }  
}  
}  
//发送请求函数  
function sendRequest() {  
createXMLHttpRequest();  
var url = "jms.jsp";  
XMLHttpReq.open("GET", url, true);  
XMLHttpReq.onreadystatechange = processResponse;//指定响应函数  
XMLHttpReq.send(null);  // 发送请求  
}  
//处理返回信息函数  
function processResponse() {  
if (XMLHttpReq.readyState == 4) { // 判断对象状态  
    if (XMLHttpReq.status == 200) { // 信息已经成功返回，开始处理信息  
        DisplayHot();  
    	
        setTimeout("sendRequest()", 3000);  
    } else { //页面不正常  
        window.alert(XMLHttpReq.status);
    	
    }
    //alert(XMLHttpReq.responseText);
}  
} 

function DisplayHot() {  
	var xmlData=XMLHttpReq.responseXML;
	var txt="";
	var txt2;
	var tags = 0;
	txt2="<table width='100%' height='70%' border='0' align='center' cellpadding='0' cellspacing='0'> "
	+ "<tr style='font-size: 40px ;color: yellow'>"
    
    
	+ "<td style='font-size: 40px '>券别</td>"
	+ "<td style='font-size: 40px '>类型</td>"
	+ "<td style='font-size: 40px '>计划</td>"
	+ "<td style='font-size: 40px '>实际</td>"
  	+ "</tr>"; 
	var packCode=xmlData.getElementsByTagName("packageCode");
	//alert(packCode.length);
	for (i=0;i<packCode.length;i++){
		txt=txt + "<tr style='font-size: 40px; color: red'>";
		var xx=packCode[i];   
		var voucher=xx.getElementsByTagName("voucher");
		var typename=xx.getElementsByTagName("typename");
		var jihua=xx.getElementsByTagName("jihua");
		var shiji=xx.getElementsByTagName("shiji");
		if(parseInt(jihua[0].firstChild.nodeValue) == parseInt(shiji[0].firstChild.nodeValue )){
			try
	          {
	          txt=txt + "<td style='font-size: 40px;color: green'>" + voucher[0].firstChild.nodeValue + "</td>";
	          }
	        catch (er)
	          {
	        	 
	          }
	   
		
		
	        try
	          {
	          txt=txt + "<td style='font-size: 40px;color: green'>" + typename[0].firstChild.nodeValue + "</td>";
	          }
	        catch (er)
	          {
	        	
	          }
	    
		
		
	        try
	          {
	        	
	          txt=txt + "<td style='font-size: 60px ;color: green'>" + jihua[0].firstChild.nodeValue + "</td>";
	          }
	        catch (er)
	          {
	         
	          }
	    
		
		
	        try
	          {
	
	          	txt=txt + "<td style='font-size: 60px ;color: green'>" + shiji[0].firstChild.nodeValue + "</td>";
		
	          }
	        catch (er)
	          {
	         
	          }
		}else{
			tags = 1;
			try
	          {
	          txt=txt + "<td style='font-size: 40px;'>" + voucher[0].firstChild.nodeValue + "</td>";
	          }
	        catch (er)
	          {
	        	 
	          }
	   
		
		
	        try
	          {
	          txt=txt + "<td style='font-size: 40px;'>" + typename[0].firstChild.nodeValue + "</td>";
	          }
	        catch (er)
	          {
	        	
	          }
	    
		
		
	        try
	          {
	        	
	          txt=txt + "<td style='font-size: 60px ;'>" + jihua[0].firstChild.nodeValue + "</td>";
	          }
	        catch (er)
	          {
	         
	          }
	    
		
		
	        try
	          {
	
	          	txt=txt + "<td style='font-size: 60px ;'>" + shiji[0].firstChild.nodeValue + "</td>";
		
	          }
	        catch (er)
	          {
	         
	          }
		}
		
		
	        
	    
		
		
		/* if (parseInt(shiji[0].firstChild.nodeValue ) > parseInt(jihua[0].firstChild.nodeValue)){
			txt="<tr style='font-size: 40px; color: red'>"+ txt + "</tr>";
		}
		 else{txt="<tr style='font-size: 40px; color: green'> "+ txt + "</tr>";}  */
		txt=txt + "</tr>";
		
	}
	var zong=xmlData.getElementsByTagName("zong");
	var zong1=xmlData.getElementsByTagName("zong1");
	
	if(tags == 1){
		
		try
        {
		txt=txt + "<tr style='color: red;'><td ></td><td align='center' style='font-size: 40px ; '>合计:</td>";
		
        txt=txt + "<td style='font-size: 60px ;'>" + zong[0].firstChild.nodeValue + "</td>";
        txt=txt + "<td style='font-size: 60px ;'>" + zong1[0].firstChild.nodeValue + "</td>";
        txt=txt + "</tr>";
        }
      catch (er)
        {
        txt=txt + "<td> </td>";
        }
	}else{
    	  try
          {
  		txt=txt + "<tr style='color: green;'><td ></td><td align='center' style='font-size: 40px ; '>合计:</td>";
  		
          txt=txt + "<td style='font-size: 60px ;'>" + zong[0].firstChild.nodeValue + "</td>";
          txt=txt + "<td style='font-size: 60px ;'>" + zong1[0].firstChild.nodeValue + "</td>";
          txt=txt + "</tr>";
          }
        catch (er)
          {
          txt=txt + "<td> </td>";
          }
      }
	txt=txt2+ txt + "</table>";
	 document.getElementById('txtCDInfo').innerHTML=txt;

}  

</script> 

</head>
<body onLoad="sendRequest();" style="background-color: black;margin:0px;">
 <div id="txtCDInfo">
 </div>
</body>
</html>
