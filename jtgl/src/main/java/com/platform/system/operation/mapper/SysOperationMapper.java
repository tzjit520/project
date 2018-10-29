package com.platform.system.operation.mapper;

import com.platform.mapper.BaseMapper;
import com.platform.system.operation.model.SysOperation;

public interface SysOperationMapper extends BaseMapper<SysOperation>  {
	
	public int selectPermissionCount(Long operationId);
	
}