package com.platform.generator.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.generator.mapper.SysTableColumnMapper;
import com.platform.generator.mapper.SysTableMapper;
import com.platform.generator.model.SysTable;
import com.platform.generator.model.SysTableColumn;
import com.platform.generator.util.GeneratorUtil;
import com.platform.page.PageModel;
import com.platform.service.BaseService;

/**
 * 代码生成器
 */
@Service
public class SysGeneratorService extends BaseService<SysTableMapper, SysTable> {

	@Autowired
	private GeneratorUtil generatorUtil;
	
	@Autowired
	private SysTableColumnMapper sysTableColumnMapper;

	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysTable> selectByPage(SysTable vo) {	
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysTable> results = this.selectByProperties(vo);

		PageModel<SysTable> page = new PageModel<>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	/**
	 * 根据指定的表和包名生产代码
	 * 
	 * @param targetTableList
	 * @param packageName
	 * @throws Exception
	 */
	public void generateCodes(List<String> targetTableList, String packageName) throws Exception {
		for (String targetTableName : targetTableList) {		
			SysTableColumn sysTableColumn = new SysTableColumn();
			sysTableColumn.setTableName(targetTableName);
			// 查询目标表中的列信息
			List<SysTableColumn> columns = sysTableColumnMapper.selectByProperties(sysTableColumn);
			// 根据模版文件生成代码文件
			generatorUtil.createFile(packageName, targetTableName, columns);
		}
	}
}
