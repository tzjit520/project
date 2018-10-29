package com.platform.system.dbobject.mapper;

import java.util.List;

import com.platform.mapper.BaseMapper;
import com.platform.system.dbobject.model.SysDbObject;


public interface SysDbObjectMapper extends BaseMapper<SysDbObject> {
	
	public int updateByPrimaryKeyWithBLOBs(SysDbObject record);
	
	public List<SysDbObject> selectByCode(SysDbObject record);
	
}