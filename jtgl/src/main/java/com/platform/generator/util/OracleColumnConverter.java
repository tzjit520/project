package com.platform.generator.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.platform.generator.model.SysTableColumn;

@Service("OracleColumnConverter")
public class OracleColumnConverter extends ColumnConverter {
	
	// 精度
	@Value("${generator.oracle.LongPrecision}")
	private Integer longPrecision;

	@Override
	public List<Map<String, String>> convert(List<SysTableColumn> columns) {
		if (columns == null || columns.isEmpty()) {
			return null;
		}
		List<Map<String, String>> resultMapList = new ArrayList<Map<String, String>>();
		for (SysTableColumn column : columns) {
			String dbDataType = column.getDataType();
			String columnName = column.getColumnName();
			String attrName = ColumnConverter.columnNameConvertor(columnName);
//			column.setPropertyName(columnName);
			// 过滤掉基类中定义的字段
			if (baseEntityFieldSet.contains(attrName) && !baseEntityDefaultFieldSet.contains(attrName)) {
				continue;
			}
			// 数据库字段类型到Java类型的转换
			String javaDataType = null;
			if ("TINYINT".equalsIgnoreCase(dbDataType) || "SMALLINT".equalsIgnoreCase(dbDataType)
					|| "INT".equalsIgnoreCase(dbDataType) || "INTEGER".equalsIgnoreCase(dbDataType)) {
				javaDataType = "Integer";
			} else if ("NUMBER".equalsIgnoreCase(dbDataType) || "BIGINT".equalsIgnoreCase(dbDataType)) {
				if (column.getDataPrecision() >= longPrecision) {
					javaDataType = "Long";
				} else {
					javaDataType = "Integer";
				}
			} else if ("FLOAT".equalsIgnoreCase(dbDataType)) {
				javaDataType = "Float";
			} else if ("DOUBLE".equalsIgnoreCase(dbDataType)) {
				javaDataType = "Double";
			} else if ("CHAR".equalsIgnoreCase(dbDataType) || "CHARACTER".equalsIgnoreCase(dbDataType)
					|| "CHARACTER VARYING".equalsIgnoreCase(dbDataType) || "VARCHAR".equalsIgnoreCase(dbDataType)
					|| "VARCHAR2".equalsIgnoreCase(dbDataType)) {
				javaDataType = "String";
			} else if ("DATE".equalsIgnoreCase(dbDataType) || "DATETIME".equalsIgnoreCase(dbDataType)
					|| "TIMESTAMP".equalsIgnoreCase(dbDataType)) {
				javaDataType = "java.util.Date";
			}
//			column.setJavaType(javaDataType);
			// 构造转换结果
			Map<String, String> columnMap = new HashMap<String, String>();
			// 【是否是默认字段】 
			if (baseEntityDefaultFieldSet.contains(attrName)) {
				columnMap.put("default", "true");
			} else {
				columnMap.put("default", "false");
			}
			// 【数据库字段对应的mybatis类型】 
			if ("TINYINT".equalsIgnoreCase(dbDataType) || "SMALLINT".equalsIgnoreCase(dbDataType)
					|| "INT".equalsIgnoreCase(dbDataType) || "INTEGER".equalsIgnoreCase(dbDataType)) {
				columnMap.put("myBatisDataType", "INTEGER");
			} else if ("DATETIME".equalsIgnoreCase(dbDataType) || "DATE".equalsIgnoreCase(dbDataType)) {
				columnMap.put("myBatisDataType", "TIMESTAMP");
			} else if ("NUMBER".equalsIgnoreCase(dbDataType)) {
				columnMap.put("myBatisDataType", "DECIMAL");
			} else if ("CHAR".equalsIgnoreCase(dbDataType) || "CHARACTER".equalsIgnoreCase(dbDataType)
					|| "CHARACTER VARYING".equalsIgnoreCase(dbDataType) || "VARCHAR".equalsIgnoreCase(dbDataType)
					|| "VARCHAR2".equalsIgnoreCase(dbDataType)) {
				columnMap.put("myBatisDataType", "VARCHAR");
			} else {
				columnMap.put("myBatisDataType", StringUtils.upperCase(dbDataType));
			}
			// 【表的字段名】 
			columnMap.put("columnName", columnName);
			// Java数据类型
			columnMap.put("attrType", javaDataType);
			//  【Java类属性名】
			columnMap.put("attrName", attrName);
			// 首字母大写的字段名，用于产生get和set方法
			columnMap.put("AttrName", StringUtils.capitalize(attrName));
			// 备注
			columnMap.put("comment", column.getComment()==null?"":column.getComment());

			resultMapList.add(columnMap);
		}
		return resultMapList;
	}

}