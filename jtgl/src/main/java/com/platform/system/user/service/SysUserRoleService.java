package com.platform.system.user.service;

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
import com.platform.system.user.mapper.SysUserRoleMapper;
import com.platform.system.user.model.SysUserRole;

@Service
public class SysUserRoleService extends BaseService<SysUserRoleMapper,SysUserRole>{

	protected Logger logger = LoggerFactory.getLogger(getClass());

    @Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysUserRole> selectByPage(SysUserRole vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysUserRole> results = this.getMapper().selectByProperties(vo);
        PageModel<SysUserRole> page = new PageModel<SysUserRole>();
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
    	// 根据SysUserRole的注解判断是否是逻辑删除或物理删除
	    Class entityClass = SysUserRole.class;
		boolean logicalDelete = ((EntityAnotation)entityClass.getAnnotation(EntityAnotation.class)).logicalDelete();
		if (logicalDelete) {
			this.getMapper().logicalDeleteByRoleId(roleId);
		} else {
			this.getMapper().deleteByRoleId(roleId);
		}
    }

	@Transactional(readOnly = true)
	public List<SysUserRole> selectAll(SysUserRole vo) {
		return this.getMapper().selectByProperties(vo);
	}
}
