package com.platform.system.role.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.anotation.EntityAnotation;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.role.mapper.SysRolePermissionMapper;
import com.platform.system.role.model.SysRolePermission;

@Service
public class SysRolePermissionService extends BaseService<SysRolePermissionMapper,SysRolePermission>{

	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysRolePermission> selectByPage(SysRolePermission vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysRolePermission> results = this.getMapper().selectAuthByProperties(vo);

		PageModel<SysRolePermission> page = new PageModel<SysRolePermission>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}

    @SuppressWarnings({ "rawtypes", "unchecked" })
	public void deleteByRoleId(Integer roleId) {
    	// 根据SysRolePermission的注解判断是否是逻辑删除或物理删除
	    Class entityClass = SysRolePermission.class;
		boolean logicalDelete = ((EntityAnotation)entityClass.getAnnotation(EntityAnotation.class)).logicalDelete();
		if (logicalDelete) {
			this.getMapper().logicalDeleteByRoleId(roleId);
		} else {
			this.getMapper().deleteByRoleId(roleId);
		}
    }
    
	@Transactional(readOnly = true)
	public List<SysRolePermission> selectAll(SysRolePermission vo) {
		return this.getMapper().selectAuthByProperties(vo);
	}
}
