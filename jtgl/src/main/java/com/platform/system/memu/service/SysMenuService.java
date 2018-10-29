package com.platform.system.memu.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.memu.mapper.SysMenuMapper;
import com.platform.system.memu.model.SysMenu;

@Service
public class SysMenuService extends BaseService<SysMenuMapper,SysMenu>{

	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysMenu> selectByPage(SysMenu vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysMenu> results = this.selectByProperties(vo);

		PageModel<SysMenu> page = new PageModel<SysMenu>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	public void deletMenu(Integer id) {
		this.getMapper().deleleByParentId(id);
		this.delete(id);
	}

}
