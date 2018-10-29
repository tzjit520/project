package com.jtgl.test.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jtgl.test.mapper.TestUserMapper;
import com.jtgl.test.model.TestUser;
import com.platform.page.PageModel;
import com.platform.service.BaseService;


@Service
public class TestUserService extends BaseService<TestUserMapper, TestUser>{

	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<TestUser> selectByPage(TestUser vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<TestUser> results = this.selectByProperties(vo);

		PageModel<TestUser> page = new PageModel<TestUser>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
}
