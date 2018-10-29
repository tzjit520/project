package com.platform.system.resource.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.resource.mapper.SysResourceMapper;
import com.platform.system.resource.model.SysResource;

@Service
public class SysResourceService extends BaseService<SysResourceMapper,SysResource>{

	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysResource> selectByPage(SysResource vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysResource> results = this.selectByProperties(vo);

		PageModel<SysResource> page = new PageModel<SysResource>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}

}
