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

import com.jtgl.im.mapper.ImGroupMsgToUserMapper;
import com.jtgl.im.model.ImGroupMsgToUser;


@Service
public class ImGroupMsgToUserService extends BaseService<ImGroupMsgToUserMapper, ImGroupMsgToUser> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<ImGroupMsgToUser> selectByPage(ImGroupMsgToUser vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<ImGroupMsgToUser> results = this.selectByProperties(vo);

		PageModel<ImGroupMsgToUser> page = new PageModel<ImGroupMsgToUser>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
}
