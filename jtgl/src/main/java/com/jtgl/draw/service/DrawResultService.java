package com.jtgl.draw.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jtgl.draw.mapper.DrawResultMapper;
import com.jtgl.draw.model.DrawResult;
import com.platform.page.PageModel;
import com.platform.service.BaseService;


@Service
public class DrawResultService extends BaseService<DrawResultMapper, DrawResult> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<DrawResult> selectByPage(DrawResult vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<DrawResult> results = this.selectByProperties(vo);

		PageModel<DrawResult> page = new PageModel<DrawResult>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	/**
	 * 根据用户Id所获得的奖品及数量信息
	 * @param userId 用户ID
	 * @return
	 */
	public List<Map<String, Object>> selectPrizeByUserId(Integer userId){
		return this.getMapper().selectPrizeByUserId(userId);
	}
	
	/**
	 * 根据抽奖基础信息ID  查询所有抽奖结果
	 * @return
	 */
	public List<Map<String, Object>> selectAllDrawResult(Integer drawId){
		return this.getMapper().selectAllDrawResult(drawId);
	}
}
