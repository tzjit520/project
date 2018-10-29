package ${package}.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;

import ${package}.mapper.${ClassName}Mapper;
import ${package}.model.${ClassName};


@Service
public class ${ClassName}Service extends BaseService<${ClassName}Mapper, ${ClassName}> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<${ClassName}> selectByPage(${ClassName} vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<${ClassName}> results = this.selectByProperties(vo);

		PageModel<${ClassName}> page = new PageModel<${ClassName}>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
}
