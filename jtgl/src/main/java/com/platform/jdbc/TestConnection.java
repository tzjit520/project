package com.platform.jdbc;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.platform.jdbc.util.JDBCUtil;

/**
 * 测试JDBC
 */
public class TestConnection {
	
	public static void main(String[] args) {
		try {
			List<Map<String,Object>> listMap = TestConnection.queryData();
			for (int i = 0; i < listMap.size(); i++) {
				Map<String,Object> map = listMap.get(i);
				System.out.println("编号：" + map.get("number") + "   姓名：" + map.get("name"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 查询人员信息
	 */
	public static List<Map<String,Object>> queryData() throws Exception{
		List<Map<String,Object>> listMap = new ArrayList<Map<String,Object>>();
		ResultSet rs = null;
		Connection conn = JDBCUtil.getMysqlConnection();
		try {
			Statement stat = conn.createStatement();
			rs = stat.executeQuery("select * from t_personnel");
			while (rs.next()) {
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("number", rs.getObject("number"));
				map.put("name", rs.getObject("name"));
				listMap.add(map);
			}
		}finally{
			/*** 关闭数据库连接  */
			JDBCUtil.close(rs, null, conn);
		}
		return listMap;
	}
}
