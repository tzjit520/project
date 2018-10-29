package com.jtgl.group.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;

import com.jtgl.group.mapper.GroupPrivilegeMapper;
import com.jtgl.group.model.GroupPrivilege;


@Service
public class GroupPrivilegeService extends BaseService<GroupPrivilegeMapper, GroupPrivilege> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<GroupPrivilege> selectByPage(GroupPrivilege vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<GroupPrivilege> results = this.selectByProperties(vo);

		PageModel<GroupPrivilege> page = new PageModel<GroupPrivilege>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
}
