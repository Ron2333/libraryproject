<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
	<%@ page language="java" import="java.util.*,util.MD5Util,java.text.SimpleDateFormat,java.util.Date,java.util.GregorianCalendar" %>
<%@ include file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<%
	String var_loginName = "";
	String s_loginName = "";
	
	String var_loginPWD = "";
	String s_loginPWD = "";
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
	if (request.getParameter("loginName") != null&&!request.getParameter("loginName").equals("")
			&& request.getParameter("loginName") != "") {
		var_loginName = (String) request.getParameter("loginName");
	}
	if (request.getParameter("loginPWD") != null&&!request.getParameter("loginPWD").equals("")
			&& request.getParameter("loginPWD") != "") {
		var_loginPWD = (String) request.getParameter("loginPWD");
	}
	
	String userID = "";
	String userName = "";
	String loginName = "";
	String loginPWD = "";
	int isUse=0;
	String bankuserid="";
		String fsql = "select USERID,USERNAME,LOGINNAME,LOGINPWD,ISUSE  from T_USER  where  LOGINNAME='"+var_loginName+"' and ISUSE=1";
		System.out.println(fsql);
		pstmt = conn.prepareStatement(fsql);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			 userID = rs.getString("USERID");
			 
			 userName = rs.getString("USERNAME");
			 loginName = rs.getString("LOGINNAME");
			 loginPWD = rs.getString("LOGINPWD");
			 isUse = rs.getInt("ISUSE");
			
		}
		HttpSession hs = request.getSession();
		hs.setMaxInactiveInterval(3600);
		if(userID!=null&&userID!=""){
			hs.setAttribute("userID", userID);
		}
		
		if(userName!=null&&userName!=""){
			hs.setAttribute("userName", userName);
		}
		if(loginName!=null&&loginName!=""){
			hs.setAttribute("loginName", loginName);
		}
		
		rs.close();
		pstmt.close();
		
		
		
		conn.close();
		if(loginName==null||loginName.equals("")){
			request.setAttribute("loginNameMessage", "error");
			System.out.println("用户名不存在!");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
			
    	if(loginPWD.equals(var_loginPWD)){
			
			request.getRequestDispatcher("main.jsp").forward(request, response);
				
		}else if(!loginPWD.equals(var_loginPWD)){
			System.out.println("密码错误!");
			request.setAttribute("loginPWDMessage", "error");
			request.getRequestDispatcher("index.jsp").forward(request, response);
		}
	}catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	
%>
</html>
