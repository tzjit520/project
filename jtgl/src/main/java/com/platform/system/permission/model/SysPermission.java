package com.platform.system.permission.model;

import com.platform.model.BaseEntity;

/**
 * 功能权限类，功能权限为角色、资源、操作的组合
 */
public class SysPermission extends BaseEntity<SysPermission> {
	
	private static final long serialVersionUID = 7389090204029685670L;

	private String permission;		// 功能名，resourceCode+':'+operationCode	
	private Integer roleId;			// 角色ID	
	
	private Integer resourceId;		// 资源ID	
	private String resourceCode;	// 资源编码	
	private String resourceName;	// 资源名称
	
	private Integer operationId;	// 操作ID	
	private String operationCode;	// 操作编码		
	private String operationName;	// 操作名称

    public Integer getResourceId() {
        return resourceId;
    }

    public void setResourceId(Integer resourceId) {
        this.resourceId = resourceId;
    }

    public Integer getOperationId() {
        return operationId;
    }

    public void setOperationId(Integer operationId) {
        this.operationId = operationId;
    }

    public String getPermission() {
		return permission;
	}

	public void setPermission(String permission) {
		this.permission = permission;
	}

	public String getResourceName() {
		return resourceName;
	}

	public void setResourceName(String resourceName) {
		this.resourceName = resourceName;
	}

	public String getOperationName() {
		return operationName;
	}

	public void setOperationName(String operationName) {
		this.operationName = operationName;
	}

	public String getResourceCode() {
		return resourceCode;
	}

	public void setResourceCode(String resourceCode) {
		this.resourceCode = resourceCode;
	}

	public String getOperationCode() {
		return operationCode;
	}

	public void setOperationCode(String operationCode) {
		this.operationCode = operationCode;
	}

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }
}