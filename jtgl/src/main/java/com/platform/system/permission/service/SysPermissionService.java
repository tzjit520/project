package com.platform.system.permission.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.permission.mapper.SysPermissionMapper;
import com.platform.system.permission.model.SysPermission;

@Service
public class SysPermissionService extends BaseService<SysPermissionMapper,SysPermission>{

	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysPermission> selectByPage(SysPermission vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysPermission> results = this.selectByProperties(vo);

		PageModel<SysPermission> page = new PageModel<SysPermission>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}

}
