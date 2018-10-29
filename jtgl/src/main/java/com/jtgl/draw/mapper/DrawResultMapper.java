package com.jtgl.draw.mapper;

import com.platform.mapper.BaseMapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.jtgl.draw.model.DrawResult;

public interface DrawResultMapper extends BaseMapper<DrawResult> {
	
	/**
	 * 根据用户Id所获得的奖品及数量信息
	 * @param userId 用户ID
	 * @return
	 */
	List<Map<String, Object>> selectPrizeByUserId(@Param("userId") Integer userId);
	
	/**
	 * 根据抽奖基础信息ID  查询所有抽奖结果
	 * @return
	 */
	List<Map<String, Object>> selectAllDrawResult(@Param("drawId") Integer drawId);
}
