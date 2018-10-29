package com.platform.system.role.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

@EntityAnotation(logicalDelete = true)
public class SysRolePermission extends BaseEntity<SysRolePermission> {
	
	private static final long serialVersionUID = -6810620649172797073L;

	private Integer roleId;

	private Integer permissionId;

	private String operationName;

	private String resourceName;
	
	private String permission;

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public Integer getPermissionId() {
		return permissionId;
	}

	public void setPermissionId(Integer permissionId) {
		this.permissionId = permissionId;
	}

	public String getOperationName() {
		return operationName;
	}

	public void setOperationName(String operationName) {
		this.operationName = operationName;
	}

	public String getResourceName() {
		return resourceName;
	}

	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}

	public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}
}