package com.jtgl.draw.mapper;

import com.platform.mapper.BaseMapper;

import org.apache.ibatis.annotations.Param;

import com.jtgl.draw.model.Draw;

public interface DrawMapper extends BaseMapper<Draw> {
	/**
	 * 查询有效的抽奖信息
	 */
	public Draw selectOne(@Param("queryDate")String queryDate);
}
