package com.platform.jdbc;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.jtgl.demo.model.Map;
import com.platform.jdbc.util.JDBCUtil;

public class AddMap {

	private static Connection connection = null;
	private static PreparedStatement ps = null;
	
	public static void main(String[] args) {
		try {
			connection = JDBCUtil.getMysqlConnection();
			List<Map> listMap = querySourceList();
			int count = 0;
			for (Map map : listMap) {
				count = count + insertMap(map);
			}
			System.out.println("本次成功录入"+count+"信息!");
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			JDBCUtil.close(ps, connection);
		}
	}
	
	/**
	 * 添加  地图坐标信息
	 */
	public static int insertMap(Map map) throws SQLException{
		ps = connection.prepareStatement("insert into t_map(name,number,province,city,area,address,map_x,map_y,"
				+ "status,create_by,create_date,update_by,update_date,deleted,map_type) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		ps.setString(1, map.getName());
		ps.setString(2, map.getNumber());
		ps.setString(3, map.getProvince());
		ps.setString(4, map.getCity());
		ps.setString(5, map.getArea());
		ps.setString(6, map.getAddress());
		ps.setString(7, map.getMapX());
		ps.setString(8, map.getMapY());
		ps.setInt(9, 1);
		ps.setBigDecimal(10, new BigDecimal(1));
		ps.setTimestamp(11, new Timestamp(new Date().getTime()));
		ps.setBigDecimal(12, new BigDecimal(1));
		ps.setTimestamp(13, new Timestamp(new Date().getTime()));
		ps.setInt(14, 0);
		ps.setInt(15, 1);//地图类型  
		return ps.executeUpdate();
	}
	
	/**
	 * 查询源数据
	 */
	public static List<Map> querySourceList() throws SQLException{
		List<Map> list = new ArrayList<Map>();
		ps = connection.prepareStatement("select name,number,province,city,area,address,map_x,map_y from t_personnel");
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Map map = new Map();
			map.setName(rs.getString("name"));
			map.setNumber(rs.getString("number"));
			map.setProvince(rs.getString("province"));
			map.setCity(rs.getString("city"));
			map.setArea(rs.getString("area"));
			map.setAddress(rs.getString("address"));
			map.setMapX(rs.getString("map_x"));
			map.setMapY(rs.getString("map_y"));
			list.add(map);
		}
		rs.close();
		return list;
	}
}
