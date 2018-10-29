package com.platform.dynamic;

import org.springframework.jdbc.datasource.lookup.AbstractRoutingDataSource;


public class DynamicDataSource extends AbstractRoutingDataSource {

	private static final ThreadLocal<String> dataSource = new ThreadLocal<String>();
	
	@Override
	protected Object determineCurrentLookupKey() {
		
		return dataSource.get();
	}

	/**
	 * 设置数据源
	 */
	public static void setDataSource(String dataSourceName){
		
		dataSource.set(dataSourceName);
	}
	
	/**
	 * 获取数据源
	 */
	public static String getDataSource(){
		
		return dataSource.get();
	}
	
	/**
	 * 获取数据库类型
	 */
	public static String getDataBaseType() {
		
		return "mysql";
	}
	
}
