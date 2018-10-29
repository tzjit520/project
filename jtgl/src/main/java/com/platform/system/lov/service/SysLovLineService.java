package com.platform.system.lov.service;

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
import com.platform.system.lov.mapper.SysLovLineMapper;
import com.platform.system.lov.model.SysLov;
import com.platform.system.lov.model.SysLovLine;

@Service
public class SysLovLineService extends BaseService<SysLovLineMapper,SysLovLine> {

	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysLovLine> selectByPage(SysLovLine vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysLovLine> results = this.selectByProperties(vo);

		PageModel<SysLovLine> page = new PageModel<SysLovLine>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
    @Transactional(readOnly = true)
    public List<SysLovLine> selectAll(SysLovLine vo) {    	
        return this.selectByProperties(vo);
    }
    
    @SuppressWarnings({ "rawtypes", "unchecked" })
	public void deleteByLovId(Integer lovId){
    	// 根据SysLov的注解判断是否是逻辑删除或物理删除
	    Class entityClass = SysLov.class;
		boolean logicalDelete = ((EntityAnotation)entityClass.getAnnotation(EntityAnotation.class)).logicalDelete();
		if (logicalDelete) {
			this.getMapper().logicalDeleteByLovId(lovId);
		} else {
			this.getMapper().deleteByLovId(lovId);
		}
    }
}
