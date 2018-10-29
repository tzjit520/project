package com.jtgl.test.mapper;

import com.jtgl.test.model.TestUser;
import com.platform.mapper.BaseMapper;

public interface TestUserMapper extends BaseMapper<TestUser> {
	/**
	 * 查询所有数据
	 */
	public String queryAll();
	
}
