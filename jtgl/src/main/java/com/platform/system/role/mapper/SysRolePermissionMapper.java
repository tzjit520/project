package com.platform.system.role.mapper;

import java.util.List;

import com.platform.mapper.BaseMapper;
import com.platform.system.role.model.SysRolePermission;


public interface SysRolePermissionMapper extends BaseMapper<SysRolePermission> {
	
	List<SysRolePermission> selectAuthByProperties(SysRolePermission sysRolePermission);

    public void deleteByRoleId(Integer roleId);
    
    public void logicalDeleteByRoleId(Integer roleId);
    
}