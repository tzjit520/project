package com.platform.system.user.mapper;

import com.platform.mapper.BaseMapper;
import com.platform.system.user.model.SysUserRole;

public interface SysUserRoleMapper extends BaseMapper<SysUserRole> {
    
	public void deleteByRoleId(Integer roleId);
    
    public void logicalDeleteByRoleId(Integer roleId);
    
}