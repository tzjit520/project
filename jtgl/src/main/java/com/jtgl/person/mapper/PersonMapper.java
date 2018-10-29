package com.jtgl.person.mapper;

import java.util.List;
import java.util.Map;

import com.jtgl.person.model.Person;
import com.platform.mapper.BaseMapper;

public interface PersonMapper extends BaseMapper<Person> {
	/**
	 * 查询最大编号
	 */
	public String selectMaxNumber();
	
	/**
	 * 查询指定字段的数据(以后方便地图地址解析和逆地址解析)
	 */
	public List<Map<String, Object>> findMapData();
}
