package com.jtgl.draw.mapper;

import com.platform.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jtgl.draw.model.DrawPrize;

public interface DrawPrizeMapper extends BaseMapper<DrawPrize> {
	/**
	 * 根据抽奖基础信息ID查询 剩余中奖次数>0 所有奖项信息
	 * @param drawId
	 * @return
	 */
	public List<DrawPrize> queryDrawPrizeList(@Param("drawId")Integer drawId);

	/**
	 * 奖项剩余中奖次数-1
	 */
	public void updateDrawPrize(DrawPrize drawPrize);
	
	/**
	 * 查询奖项对应的奖品信息
	 * @param drawId
	 * @return
	 */
	public List<Map<String, Object>> selectPrizeItem(@Param("drawId")Integer drawId);
}
