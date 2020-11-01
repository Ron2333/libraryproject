<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="oracle.jdbc.proxy.annotation.Pre"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" import="java.util.*,util.*,java.net.*,java.io.*" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.sun.xml.internal.messaging.saaj.util.ByteOutputStream"%>
<%@page import="java.io.OutputStream"%>
<%@ include file="conn.jsp"%>
<font style="color:red" size='30'>
<%
CopyFile cf=new CopyFile();
Properties properties = new Properties();
properties.load(this.getClass().getResourceAsStream("/db.properties"));
String outPath = new String(properties.getProperty("outPath"));

String filePath = outPath+"/userinfo.txt";
FileOutputStream outfos=null;
BufferedWriter outbw=null;
File outFile=new File(filePath);

outfos= new FileOutputStream(outFile);
outbw= new BufferedWriter(new OutputStreamWriter(outfos));
String banksn=(String)session.getAttribute("bankSN");
PreparedStatement pstmt=null;
ResultSet rs=null;
String bankid="";
String hql="select bankid from t_bank where banksn='"+banksn+"'";
pstmt=conn.prepareStatement(hql);
rs=pstmt.executeQuery();
if(rs.next()){
	bankid=rs.getString("bankid");
}
String sql="select * from t_user where banksn='"+banksn+"'";
pstmt=conn.prepareStatement(sql);
rs=pstmt.executeQuery();
while(rs.next()){
	String updatetime=rs.getString("updatetime");
	String userid=rs.getString("userid");
	String username=rs.getString("username");
	String loginname=rs.getString("loginname");
	String loginpwd=rs.getString("loginpwd");
	String isuse=rs.getString("isuse");
	String bankuserid=rs.getString("bankuserid");
	String userInfo=updatetime+","+userid+",\""+bankid+"\",\""+username+"\",\""+loginname+"\",\""+loginpwd+"\","+isuse+",\""+bankuserid+"\"";
	outbw.write(userInfo);
	outbw.newLine();
}

outbw.close();
boolean flag=false;
	try {
		
		
		FileInputStream in=null;
		OutputStream fos=null;
	/* 	ShowAllFilesServlet ss=new ShowAllFilesServlet();
    	Map<String, String> mmap = new HashMap<String, String>();  
    	
		mmap=ss.getpath(fromorto);
		System.out.println("===1"+mmap.size()); */
		//if(mmap.size()>0){
			
					String oldPath= outPath+"/userinfo.txt";
					File file = new File(oldPath);
					
			
			        //设置响应头，控制浏览器下载该文件
			        response.setHeader("content-disposition", "attachment;filename=" + URLEncoder.encode("userinfo.txt", "UTF-8"));
			        //读取要下载的文件，保存到文件输入流
			        in = new FileInputStream(oldPath);
				        //创建输出流
				    fos=response.getOutputStream(); 
			        //创建缓冲区
			        byte buffer[] = new byte[1024];
			        int len = 0;
			        //循环将输入流中的内容读取到缓冲区当中
			        while((len=in.read(buffer))>0){
			        	fos.write(buffer, 0, len);
			        }
			        //输出缓冲区的内容到浏览器，实现文件下载
			          
			        //关闭文件输入流
			       
			        //关闭输出流
			        in.close();
					//关闭输出流
			        fos.close();   
			        //cf.moveFile(oldPath, newPath+File.separator+fileName);
			        flag=true;
				 	
		 
		
	} catch (Exception e) {
		// TODO 自动生成的 catch 块
		e.printStackTrace();
	} 
	
 %>
 </font>