<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
	<%@ page language="java" import="java.util.*" %>
<%@ include file="conn.jsp"%>
<%
	String url = "usergl.jsp";
	String userID="";
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	boolean flag = false;
	try{
		if (request.getParameter("userID") != null&&!request.getParameter("userID").equals("")
				&& request.getParameter("userID") != "") {
			userID = (String) request.getParameter("userID");
			
			String sql = "delete from t_userrole where userID = '"+userID+"'";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
			sql = "delete from t_user where userID = '"+userID+"' ";
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		
			pstmt.close();
			conn.close();
			flag = true;
			
		}
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect(url+"?flag="+flag);
%>
</html>
