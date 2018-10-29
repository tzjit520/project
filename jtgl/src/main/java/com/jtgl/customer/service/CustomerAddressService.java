package com.jtgl.customer.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;

import com.jtgl.customer.mapper.CustomerAddressMapper;
import com.jtgl.customer.model.CustomerAddress;


@Service
public class CustomerAddressService extends BaseService<CustomerAddressMapper, CustomerAddress> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<CustomerAddress> selectByPage(CustomerAddress vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<CustomerAddress> results = this.selectByProperties(vo);

		PageModel<CustomerAddress> page = new PageModel<CustomerAddress>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
}
