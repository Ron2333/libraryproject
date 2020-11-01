<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
	<%@ page language="java" import="java.util.*" %>
<%@ include file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<%
	String var_roleID = "";
	String s_roleID = "";
	
	String var_userID = "";
	String s_userID = "";
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	try{
	if (request.getParameter("userID") != null&&!request.getParameter("userID").equals("")
			&& request.getParameter("userID") != "") {
		var_userID = (String) request.getParameter("userID");
	}
	if (request.getParameter("roleID") != null&&!request.getParameter("roleID").equals("")
			&& request.getParameter("roleID") != "") {
		String desql = "delete from T_USERROLE where USERID="+var_userID;
		pstmt = conn.prepareStatement(desql);
		pstmt.executeUpdate();
		pstmt.close();
		String[] checkboxGroup1 = request.getParameterValues("roleID");
		
		if(checkboxGroup1!=null){
			String insql = "insert into T_USERROLE (USERID,ROLEID)  VALUES(?,?)";
			pstmt = conn.prepareStatement(insql);
			for(String k:checkboxGroup1){
				
				pstmt.setInt(1, Integer.parseInt(var_userID));
				pstmt.setInt(2,Integer.parseInt(k));
				pstmt.addBatch();
			}
			int[] counts = pstmt.executeBatch();
			conn.commit();
			pstmt.close();
		}
		
		conn.close();
		response.sendRedirect("jueseuser.jsp?userID="+var_userID);
	}
	}catch(Exception e){
		conn.close();
		e.printStackTrace();
	}
	
	//out.write("----");
	/***
			for(int i=0;i<f.length;i++){
				
	**/
%>
</html>
