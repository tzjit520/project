package com.platform.system.log.mapper;

import org.apache.ibatis.annotations.Param;

import com.platform.mapper.BaseMapper;
import com.platform.system.log.model.SysLog;

public interface SysLogMapper extends BaseMapper<SysLog> {
	
	/**
	 * 定期清理日志
	 */
	public int cleanLogs(@Param("logTypes")String[] logTypes, @Param("reserverHours")int reserverHours);
}