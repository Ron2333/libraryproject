package util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;


public class Dcon {

	public Connection getCon() throws Exception {
		Connection con = null;
		Properties properties = new Properties();
		try {
			//properties.load(this.getClass().getResourceAsStream(
			//		"/db.properties"));
			properties.load(this.getClass().getResourceAsStream("/db.properties"));
			String driver =new String(properties.getProperty("driverName"));
			String url = new String(properties.getProperty("dbURL"));
			String user =new String(properties.getProperty("userName"));
			String password = new String(properties.getProperty("userPwd"));
			
			System.out.println(driver+"---"+url+"---"+user+"---"+password);
			try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, user, password);
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}
}