package dao;	

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBContext {
	private static Connection conn;
	public static Connection getMySQLConnection()
	        throws ClassNotFoundException, SQLException {
	    String hostName = "localhost";
	    String dbName = "web";
	    String userName = "root";
	    String password = "onething1";
	    return getMySQLConnection(hostName, dbName, userName, password);
	}
	 
	public static Connection getMySQLConnection(String hostName, String dbName, String userName, String password) throws SQLException,ClassNotFoundException{
		if(conn == null) {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/web",userName,password);
		}
		return conn;
	}
	

}
