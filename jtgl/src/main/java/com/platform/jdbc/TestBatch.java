package com.platform.jdbc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.platform.jdbc.util.JDBCUtil;


/**
 * 测试批处理的基本用法
 */
public class TestBatch {
	
	public static void main(String[] args) {
		insertBatch();
	}
	
	/**
	 * 批处理添加
	 */
	public static void insertBatch() {
		
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = JDBCUtil.getMysqlConnection();
			
			conn.setAutoCommit(false);  //设为手动提交
			long start = System.currentTimeMillis();
			String sql = "insert into test_users (name, age, birth_day) values (?,?,?)";
			ps = conn.prepareStatement(sql);
			
			for(int i = 0; i < 20000; i++){
				ps.setString(1, "露露"+i);
				ps.setInt(2, i);
				ps.setDate(3, new Date(new java.util.Date().getTime()));
				ps.addBatch();
			}
			ps.executeBatch();
			ps.clearBatch();
			conn.commit();  //提交事务
			long end = System.currentTimeMillis();
			System.out.println("插入20000条数据，耗时(毫秒)："+(end-start));
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			JDBCUtil.close(ps, conn);
		}
	}
}
