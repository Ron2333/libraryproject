<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>
	<%@ page language="java" import="java.util.*" %>
<%@ include file="conn.jsp"%>
<% request.setCharacterEncoding("utf-8");%>
<%
	String var_roleID = "";
	String s_roleID = "";
	
	String var_functionID = "";
	String s_functionID = "";
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String message="";
	if (request.getParameter("roleID") != null&&!request.getParameter("roleID").equals("")
			&& request.getParameter("roleID") != "") {
		var_roleID = (String) request.getParameter("roleID");
	}
	if (request.getParameter("count") != null&&!request.getParameter("count").equals("")
			&& request.getParameter("count") != "") {
		int count = Integer.parseInt(request.getParameter("count"));
		//out.write("-------------------"+count);
		try{
			String desql = "delete from T_ROLEFUNCTION where ROLEID="+var_roleID;
			pstmt = conn.prepareStatement(desql);
			pstmt.executeUpdate();
			pstmt.close();
			for(int i=1;i<=count;i++){
				String[] checkboxGroup1 = request.getParameterValues("functionID"+i);
				String[] checkboxGroup2 = request.getParameterValues("dupfunctionID"+i);
				
				
				if(checkboxGroup1!=null&&checkboxGroup2!=null){
					String insql = "insert into T_ROLEFUNCTION (ROLEID,FUNCTIONID)  VALUES(?,?)";
					pstmt = conn.prepareStatement(insql);
					for(String k:checkboxGroup1){
						
						pstmt.setInt(1, Integer.parseInt(var_roleID));
						pstmt.setInt(2,Integer.parseInt(k));
						pstmt.addBatch();
					}
					for(String k:checkboxGroup2){
						
						pstmt.setInt(1, Integer.parseInt(var_roleID));
						pstmt.setInt(2,Integer.parseInt(k));
						pstmt.addBatch();
					}
					int[] counts = pstmt.executeBatch();
					conn.commit();
					pstmt.close();
				}
			}
			message="授权成功!";
		}catch(Exception e){
			message="授权失败!";
			e.printStackTrace();
		}
		
		
		conn.close();
		response.sendRedirect("quanxian.jsp?roleID="+var_roleID);
	}
	
	//out.write("----");
	/***
			for(int i=0;i<f.length;i++){
				
	**/
%>
</html>
