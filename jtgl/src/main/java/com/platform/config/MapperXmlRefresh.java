package com.platform.config;

import javax.annotation.PostConstruct;

import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.stereotype.Component;

import com.platform.mapper.MapperRefresh;

@Component
public class MapperXmlRefresh {
	
	@Autowired
	private SqlSessionFactory sqlSessionFactory;
	
	@PostConstruct
	public void init() throws Exception{
		System.out.println("自动刷新Mybatis-XML文件");
		PathMatchingResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
		Resource[] mapperLocations = resolver.getResources("classpath*:mappings/**/*.xml");
		new MapperRefresh(mapperLocations, sqlSessionFactory.getConfiguration()).run();
	}
}
