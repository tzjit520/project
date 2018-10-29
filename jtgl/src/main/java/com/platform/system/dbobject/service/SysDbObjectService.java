package com.platform.system.dbobject.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.dbobject.mapper.SysDbObjectMapper;
import com.platform.system.dbobject.model.SysDbObject;
import com.platform.utils.HtmlUtil;

@Service
public class SysDbObjectService extends BaseService<SysDbObjectMapper,SysDbObject>{
	protected Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	@Qualifier("masterJdbcTemplate")
	private JdbcTemplate masterJdbcTemplate;

	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysDbObject> selectByPage(SysDbObject vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysDbObject> results = this.selectByProperties(vo);

		PageModel<SysDbObject> page = new PageModel<SysDbObject>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	public int update(SysDbObject entity) {
		entity.preUpdate();
		return mapper.updateByPrimaryKeyWithBLOBs(entity);
	}

	public List<Map<String,Object>> getTranslateList(SysDbObject searchVo) {
		SysDbObject sysDbObject = this.mapper.selectByCode(searchVo).get(0);
		String sql = sysDbObject.getSqlStatements();
		String[] params = searchVo.getParams();
		for(String param:params) {
			param = HtmlUtil.filteSQLStr(param);
			sql = sql.replaceFirst("\\?",param);
		}
		List<Map<String,Object>> list =  masterJdbcTemplate.queryForList(sql);
		return list;
	}
}
