package com.platform.jdbc;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.platform.jdbc.util.JDBCUtil;
import com.platform.system.permission.model.SysPermission;
import com.platform.system.resource.model.SysResource;
import com.platform.system.role.model.SysRolePermission;

public class AddRolePermission {

	public static void main(String[] args) {
		
		//功能操作  1查看  2添加  3更新  4删除
		int[] operations = {1, 2, 3, 4};
		try {
			//所有资源
			List<SysResource> listResource = queryResourceList();
			for (SysResource resource : listResource) {
				for (int i = 0; i < operations.length; i++) {
					SysPermission permission = new SysPermission();
					permission.setResourceId(resource.getId());
					permission.setOperationId(operations[i]);
					permission.setRemark("");
					permission.setStatus(1);
					permission.setDeleted(0);
					permission.setCreateBy(1);
					permission.setCreateDate(new Date());
					permission.setUpdateBy(1);
					permission.setUpdateDate(new Date());
					insertPermission(permission);
				}
			}

			//查询功能操作
			List<SysPermission> listPermission = queryPermissionList();
			for (SysPermission permission : listPermission) {
				SysRolePermission rolePermission = new SysRolePermission();
				//角色ID
				rolePermission.setRoleId(1);	
				rolePermission.setPermissionId(permission.getId());
				rolePermission.setRemark("");
				rolePermission.setStatus(1);
				rolePermission.setDeleted(0);
				rolePermission.setCreateBy(1);
				rolePermission.setCreateDate(new Date());
				rolePermission.setUpdateBy(1);
				rolePermission.setUpdateDate(new Date());
				//为角色赋权限
				insertRolePermission(rolePermission);
			}
			
			//为普通用户添加权限
//			int[] roleIds = {2};
//			int[] permissionIds = {16,17,18,19,40,41,42,43};
//			for (int roleId : roleIds) {
//				for (int permissionId : permissionIds) {
//					SysRolePermission rolePermission = new SysRolePermission();
//					rolePermission.setRoleId(roleId);	
//					rolePermission.setPermissionId(permissionId);
//					rolePermission.setRemark("");
//					rolePermission.setStatus(1);
//					rolePermission.setDeleted(0);
//					rolePermission.setCreateBy(1);
//					rolePermission.setCreateDate(new Date());
//					rolePermission.setUpdateBy(1);
//					rolePermission.setUpdateDate(new Date());
//					//为角色赋权限
//					insertRolePermission(rolePermission);
//				}
//			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 为角色添加权限
	 * @param rolePermission
	 */
	public static void insertRolePermission(SysRolePermission rolePermission){
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = JDBCUtil.getMysqlConnection();
			ps = conn.prepareStatement("insert into sys_t_role_permission(role_id, permission_id, remark, status, deleted, "
					+ "create_by, create_date, update_by, update_date) values(?,?,?,?,?,?,?,?,?)");
			ps.setInt(1, rolePermission.getRoleId());
			ps.setInt(2, rolePermission.getPermissionId());
			ps.setString(3, rolePermission.getRemark());
			ps.setInt(4, rolePermission.getStatus());
			ps.setInt(5, rolePermission.getDeleted());
			ps.setInt(6, rolePermission.getCreateBy());
			ps.setTimestamp(7, new Timestamp(rolePermission.getCreateDate().getTime()));
			ps.setInt(8, rolePermission.getUpdateBy());
			ps.setTimestamp(9, new Timestamp(rolePermission.getUpdateDate().getTime()));
			ps.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			JDBCUtil.close(ps, conn);
		}
	}
	
	/**
	 * 添加功能操作
	 * @param permission
	 */
	public static void insertPermission(SysPermission permission){
		Connection conn = null;
		PreparedStatement ps = null;
		try {
			conn = JDBCUtil.getMysqlConnection();
			ps = conn.prepareStatement("insert into sys_t_permission(resource_id, operation_id, remark, status, deleted, "
					+ "create_by, create_date, update_by, update_date) values(?,?,?,?,?,?,?,?,?)");
			ps.setInt(1, permission.getResourceId());
			ps.setInt(2, permission.getOperationId());
			ps.setString(3, permission.getRemark());
			ps.setInt(4, permission.getStatus());
			ps.setInt(5, permission.getDeleted());
			ps.setInt(6, permission.getCreateBy());
			ps.setTimestamp(7, new Timestamp(permission.getCreateDate().getTime()));
			ps.setInt(8, permission.getUpdateBy());
			ps.setTimestamp(9, new Timestamp(permission.getUpdateDate().getTime()));
			ps.executeUpdate();
		}catch (SQLException e) {
			e.printStackTrace();
		}finally{
			JDBCUtil.close(ps, conn);
		}
	}
	
	/**
	 * 查询资源
	 * @throws SQLException 
	 */
	public static List<SysResource> queryResourceList() throws SQLException{
		List<SysResource> list = new ArrayList<SysResource>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = JDBCUtil.getMysqlConnection();
			ps = conn.prepareStatement("select id, code, name from sys_t_resource r where deleted = 0");
			rs = ps.executeQuery();
			while (rs.next()) {
				SysResource resource = new SysResource();
				resource.setId(rs.getInt("id"));
				resource.setCode(rs.getString("code"));
				resource.setName(rs.getString("name"));
				list.add(resource);
			}
		}finally{
			/*** 关闭数据库连接  */
			JDBCUtil.close(rs, ps, conn);
		}
		return list;
	}
	
	/**
	 * 查询功能操作
	 * @throws SQLException 
	 */
	public static List<SysPermission> queryPermissionList() throws SQLException{
		List<SysPermission> list = new ArrayList<SysPermission>();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			conn = JDBCUtil.getMysqlConnection();
			ps = conn.prepareStatement("select id from sys_t_permission where deleted = 0");
			rs = ps.executeQuery();
			while (rs.next()) {
				SysPermission permission = new SysPermission();
				permission.setId(rs.getInt("id"));
				list.add(permission);
			}
		}finally{
			/*** 关闭数据库连接  */
			JDBCUtil.close(rs, ps, conn);
		}
		return list;
	}
}
