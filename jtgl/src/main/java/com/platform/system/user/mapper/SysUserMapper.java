package com.platform.system.user.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.platform.mapper.BaseMapper;
import com.platform.system.user.model.SysUser;

public interface SysUserMapper extends BaseMapper<SysUser> {

	List<SysUser> selectAuthByProperties(SysUser sysUser);

    void insertToken(SysUser sysUser);

    void deleteToken(String token);
	
    /**
     * 根据权限查询所有用户  
     * @param permission 例：tool:update|tool:add|...
     * @return
     */
    List<SysUser> selectUserListByPermission(@Param("permission")String permission);
}