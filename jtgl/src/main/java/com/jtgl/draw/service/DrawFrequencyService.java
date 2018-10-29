package com.jtgl.draw.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;

import com.jtgl.draw.mapper.DrawFrequencyMapper;
import com.jtgl.draw.model.DrawFrequency;


@Service
public class DrawFrequencyService extends BaseService<DrawFrequencyMapper, DrawFrequency> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<DrawFrequency> selectByPage(DrawFrequency vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<DrawFrequency> results = this.selectByProperties(vo);

		PageModel<DrawFrequency> page = new PageModel<DrawFrequency>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	/**
	 * 根据抽奖基础信息Id和用户ID查询抽奖次数
	 * @param drawId 抽奖基础信息Id
	 * @param userId 用户ID
	 * @return
	 */
	@Transactional(readOnly = true)
	public DrawFrequency queryDrawFrequency(Integer drawId, Integer userId){
		return this.getMapper().queryDrawFrequency(drawId, userId);
	}
	
	/**
	 * 修改抽奖次数
	 */
	public int updateLuckyDraw(DrawFrequency drawFrequency){
		return this.getMapper().updateLuckyDraw(drawFrequency);
	}
}
