package com.platform.jdbc;

import java.io.Reader;
import java.sql.Clob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.platform.jdbc.util.JDBCUtil;


/**
 * 测试CLOB  文本大对象的使用
 */
public class TestClob {
	
	public static void main(String[] args) {
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		Reader r  = null;
		try {
			
			conn = JDBCUtil.getMysqlConnection();
			
//			ps = conn.prepareStatement("insert into t_user (username,myInfo) values (?,?) ");
//			ps.setString(1, "qqq");
//			ps.setClob(2, new FileReader(new File("d:/a.txt")));  //将文本文件内容直接输入到数据库中
			//将程序中的字符串输入到数据库的CLOB字段中
//			ps.setClob(2, new BufferedReader(new InputStreamReader(new ByteArrayInputStream("aaaabbbbbb".getBytes()))));
			
			ps = conn.prepareStatement("select * from t_user where id=?");
			ps.setObject(1, 101024);
			
			rs = ps.executeQuery();
			while(rs.next()){
				Clob c = rs.getClob("myInfo");
				r  = c.getCharacterStream();
				int temp = 0;
				while((temp=r.read())!=-1){
					System.out.print((char)temp);
				}
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally{
			/*** 关闭数据库连接  */
			JDBCUtil.close(rs, ps, conn);
			
		}
	}
}
