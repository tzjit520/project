package com.platform.system.role.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.platform.mapper.BaseMapper;
import com.platform.system.role.model.SysRole;


public interface SysRoleMapper extends BaseMapper<SysRole> {
	
	public List<SysRole> selectRoleList(@Param("code")String code);
}