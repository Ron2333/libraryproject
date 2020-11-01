package myservlet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;

import util.Dcon;

public class LogInsert {
	// SqConn.class是获得SqConn类
		static //日志
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		/**
		 * private static String driverName = "oracle.jdbc.OracleDriver"; private
		 * static String dbURL = "jdbc:oracle:thin:@192.168.1.2:1521:ORCL"; //
		 * smxc数据库名称 private static String userName = "kcrx"; private static String
		 * userPwd = "kcrx8888";
		 **/
//		private static String driverName = "oracle.jdbc.OracleDriver";
//		private static String dbURL = "jdbc:oracle:thin:@38.63.132.200:1521:rmbdb"; // smxc数据库名称
//		//private static String dbURL = "jdbc:oracle:thin:@localhost:1521:orcl";
//		private static String userName = "kcrx";
//		private static String userPwd = "kcrx8888";
		private Connection conn;
		public void  insertDB(String loginName, String tableName,String banksn,String loginfo) throws Exception {
			PreparedStatement pstmt = null;
			if(conn==null||conn.isClosed()){
				Dcon dc = new Dcon();
				conn = dc.getCon();
			}
			if (conn != null) {
				try {
					if (conn.isClosed()) {
						Dcon dc = new Dcon();
						conn = dc.getCon();
					}
					String sql1 = "insert into T_LOGINFO(LOGINNAME,TABLENAME,MESSAGEINFO,BANKSN) "
							+ " VALUES('" + loginName + "','"+tableName+"','"+loginfo+"','"+banksn+"') ";
					System.out.print("LogInsert.java>>>>"+sql1);
					pstmt = conn.prepareStatement(sql1);
					pstmt.execute(sql1);
					pstmt.close();
					conn.close();
				} catch (Exception e) {
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
					e.printStackTrace();
				} finally {
					if (pstmt != null)
						pstmt.close();
					if (conn != null)
						conn.close();
				}
			}
		}
		
		//
//		public Connection getConn() {
//			Connection conn = null;
//			try {
//				Class.forName(driverName);
//				conn = DriverManager.getConnection(dbURL, userName, userPwd);
//			} catch (Exception e) {
//				// TODO 自动生成的 catch 块
//				e.printStackTrace();
//			}
//			return conn;
//		}
}
