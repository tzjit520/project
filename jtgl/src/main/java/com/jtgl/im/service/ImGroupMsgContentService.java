package com.jtgl.im.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;

import com.jtgl.im.mapper.ImGroupMsgContentMapper;
import com.jtgl.im.model.ImGroupMsgContent;


@Service
public class ImGroupMsgContentService extends BaseService<ImGroupMsgContentMapper, ImGroupMsgContent> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<ImGroupMsgContent> selectByPage(ImGroupMsgContent vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<ImGroupMsgContent> results = this.selectByProperties(vo);

		PageModel<ImGroupMsgContent> page = new PageModel<ImGroupMsgContent>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
}
