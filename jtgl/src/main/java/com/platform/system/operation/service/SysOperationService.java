package com.platform.system.operation.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.operation.mapper.SysOperationMapper;
import com.platform.system.operation.model.SysOperation;

@Service
public class SysOperationService extends BaseService<SysOperationMapper,SysOperation>{

	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysOperation> selectByPage(SysOperation vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysOperation> results = this.selectByProperties(vo);

		PageModel<SysOperation> page = new PageModel<SysOperation>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	/**
     * 查询操作被多少个功能引用
     * @param  操作id
     * @return
     */
    public int selectPermissionCount(Long operationId){
    	return this.getMapper().selectPermissionCount(operationId);
    }
}
