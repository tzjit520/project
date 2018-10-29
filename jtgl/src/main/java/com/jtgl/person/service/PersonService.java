package com.jtgl.person.service;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jtgl.person.mapper.PersonMapper;
import com.jtgl.person.model.Person;
import com.platform.page.PageModel;
import com.platform.service.BaseService;


@Service
public class PersonService extends BaseService<PersonMapper, Person> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<Person> selectByPage(Person vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		
		List<Person> results = this.selectByProperties(vo);
		PageModel<Person> page = new PageModel<Person>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	/**
	 * 递归查询子数据
	 */
	public String recursionQueryChild(String ids, String parentId){
		Person person = new Person();
		person.setParentId(Integer.valueOf(parentId));
		List<Person> results = this.selectByProperties(person);
		for (Person p : results) {
			ids += ","+ p.getId();
			ids = recursionQueryChild(ids, p.getId()+"");
		}
		return ids;
	}
	
	/**
	 * 查询最大编号
	 */
	public String selectMaxNumber(){
		String number = super.mapper.selectMaxNumber();
		if(Integer.valueOf(number) > 99){
			return ""+(Integer.valueOf(number)+1);
		}
		return "0"+(Integer.valueOf(number)+1);
	}
	
	/**
	 * 查询指定字段的数据(以后方便地图地址解析和逆地址解析)
	 */
	public List<Map<String, Object>> findMapData(){
		return super.mapper.findMapData();
	}
}
