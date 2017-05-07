/**
* Title: DBUtils.java
* Description: database connection file
* Copyright: Copyright (c) 2014
* Company: neuedu
* @author team3
* @date 2014-7-25
* @version 1.0
*/
package comp9321.assignment2.bookstore;

/**
 * @author JasonZhuang 
 *
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtils {
	static{
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	
	public static Connection getConnection() throws SQLException{
		System.out.println("found DBUtils");
		String url = "jdbc:mysql://localhost/bookstore?autoReconnect=true&useSSL=false";
		Connection conn = DriverManager.getConnection(url,"root","root");
		return conn;
	}
	
	public static void close(PreparedStatement ps){
		if(ps != null){
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	
	}
	public static void close(Connection conn){
		if(conn != null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	public static void close(ResultSet rs){
		if(rs != null){
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public static void close(ResultSet rs,PreparedStatement ps,Connection conn){
		close(rs);
		close(ps);
		close(conn);
	
	}
	public static void close(PreparedStatement ps,Connection conn){
		close(ps);
		close(conn);
	
	}
}