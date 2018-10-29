package com.jtgl.draw.mapper;

import com.platform.mapper.BaseMapper;

import org.apache.ibatis.annotations.Param;

import com.jtgl.draw.model.DrawFrequency;

public interface DrawFrequencyMapper extends BaseMapper<DrawFrequency> {
	/**
	 * 根据抽奖基础信息Id和客户ID查询抽奖次数
	 * @param drawId 抽奖基础信息Id
	 * @param customerId 客户ID
	 * @return
	 */
	public DrawFrequency queryDrawFrequency(@Param("drawId")Integer drawId, @Param("userId")Integer userId);
	
	/**
	 * 修改抽奖次数
	 * @param drawFrequency
	 * @return
	 */
	public int updateLuckyDraw(DrawFrequency drawFrequency);
}
