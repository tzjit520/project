package com.platform.system.user.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

@EntityAnotation(logicalDelete = true)
public class SysUserRole  extends BaseEntity<SysUserRole> {

    private static final long serialVersionUID = -3637122097195582177L;
    private Integer roleId;

    private Integer userId;

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

}