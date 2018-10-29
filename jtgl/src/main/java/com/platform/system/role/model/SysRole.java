package com.platform.system.role.model;

import java.util.ArrayList;
import java.util.List;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;
import com.platform.system.permission.model.SysPermission;
import com.platform.system.user.model.SysUser;

@EntityAnotation(logicalDelete = true)
public class SysRole extends BaseEntity<SysRole> {
	
	private static final long serialVersionUID = 507256516122221865L;

	private String name;

	private String code;

	private List<SysPermission> permissionList = new ArrayList<SysPermission>();

    private List<SysUser> userList = new ArrayList<SysUser>();

    //仅查询用
    private Integer userId;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public List<SysPermission> getPermissionList() {
		return permissionList;
	}

	public void setPermissionList(List<SysPermission> permissionList) {
		this.permissionList = permissionList;
	}

    public List<SysUser> getUserList() {
        return userList;
    }

    public void setUserList(List<SysUser> userList) {
        this.userList = userList;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

	
}