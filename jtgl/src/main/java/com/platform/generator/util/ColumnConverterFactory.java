package com.platform.generator.util;

import com.platform.utils.SpringUtil;


public class ColumnConverterFactory {
	
	/**
	 * 根据数据库类型返回列转换器，默认返回mysql的转换器
	 * @param dataSourceType
	 * @return
	 */
	public static ColumnConverter getColumnConverter(String dataSourceType) {
		if (dataSourceType.equals("mysql")) {
			return (ColumnConverter) SpringUtil.getBean("MySqlColumnConverter");
		}
		if (dataSourceType.equals("oracle")) {
			return (ColumnConverter)SpringUtil.getBean("OracleColumnConverter");
		}
		return (ColumnConverter)SpringUtil.getBean("MySqlColumnConverter");
	}

}
