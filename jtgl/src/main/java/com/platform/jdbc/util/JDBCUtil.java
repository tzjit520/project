package com.platform.jdbc.util;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCUtil {

	static Properties properties = null;   //可以帮助读取和处理资源文件中的信息
	
	static {   //加载JDBCUtil类的时候调用
		properties = new Properties();
		try {
			properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("jdbc.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 获取MySql链接
	 */
	public static Connection getMysqlConnection(){
		try {
			Class.forName(properties.getProperty("jdbc.mysql.driver"));
			Connection conn = DriverManager.getConnection(
					properties.getProperty("jdbc.mysql.url"),
					properties.getProperty("jdbc.mysql.username"),
					properties.getProperty("jdbc.mysql.password"));
			return conn;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 获取Oracle链接
	 */
	public static Connection getOracleConnection(){
		try {
			Class.forName(properties.getProperty("jdbc.oracle.driver"));
			Connection conn = DriverManager.getConnection(
					properties.getProperty("jdbc.oracle.url"),
					properties.getProperty("jdbc.oracle.username"),
					properties.getProperty("jdbc.oracle.password"));
			return conn;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	public static void close(ResultSet rs, Statement ps, Connection conn){
		try {
			if(rs!=null){
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if(ps!=null){
				ps.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if(conn!=null){
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(Statement ps,Connection conn){
		try {
			if(ps!=null){
				ps.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if(conn!=null){
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public static void close(Connection conn){
		try {
			if(conn!=null){
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
}
