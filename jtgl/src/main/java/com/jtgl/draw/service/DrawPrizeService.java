package com.jtgl.draw.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jtgl.draw.mapper.DrawPrizeMapper;
import com.jtgl.draw.model.DrawPrize;
import com.platform.page.PageModel;
import com.platform.service.BaseService;


@Service
public class DrawPrizeService extends BaseService<DrawPrizeMapper, DrawPrize> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<DrawPrize> selectByPage(DrawPrize vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<DrawPrize> results = this.selectByProperties(vo);

		PageModel<DrawPrize> page = new PageModel<DrawPrize>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	/**
	 * 根据抽奖基础信息ID查询 剩余中奖次数>0 所有奖项信息
	 * @param drawId
	 * @return
	 */
	public List<DrawPrize> queryDrawPrizeList(Integer drawId){
		return this.getMapper().queryDrawPrizeList(drawId);
	}

	/**
	 * 奖项剩余中奖次数-1
	 */
	public void updateDrawPrize(DrawPrize drawPrize){
		this.getMapper().updateDrawPrize(drawPrize);
	}
	
	/**
	 * 查询奖项对应的奖品信息
	 * @param drawId
	 * @return
	 */
	public List<Map<String, Object>> selectPrizeItem(Integer drawId){
		return this.getMapper().selectPrizeItem(drawId);
	}
}
