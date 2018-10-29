package com.platform.system.memu.mapper;

import com.platform.mapper.BaseMapper;
import com.platform.system.memu.model.SysMenu;

public interface SysMenuMapper extends BaseMapper<SysMenu>  {
	
	void deleleByParentId(Integer parentId);
	
}