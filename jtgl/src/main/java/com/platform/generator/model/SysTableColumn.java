package com.platform.generator.model;

import com.platform.model.BaseEntity;

public class SysTableColumn extends BaseEntity<SysTableColumn>{

	private static final long serialVersionUID = -8341966624295461854L;
	
	private String tableName;	// 表名
	private String columnName;	// 列名
	private String columnType;	// 列类型，带长度，如bigint(20)
	private String dataType;	// 数据类型，如bigint
	private String comment;		// 备注
	
//	private String propertyName;		// 属性名
//	private String jdbcType;			// mapper.xml文件中的JDBCTYPE属性
//	private String javaType;			// mapper.xml文件中的JavaType属性
	
	private Integer dataPrecision;	// 数据精度，oracle使用

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getColumnName() {
		return columnName;
	}

	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}

	public String getColumnType() {
		return columnType;
	}

	public void setColumnType(String columnType) {
		this.columnType = columnType;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public String getDataType() {
		return dataType;
	}

	public void setDataType(String dataType) {
		this.dataType = dataType;
	}

	public Integer getDataPrecision() {
		return dataPrecision;
	}

	public void setDataPrecision(Integer dataPrecision) {
		this.dataPrecision = dataPrecision;
	}
	
//	public String getPropertyName() {
//		return propertyName;
//	}
//
//	public void setPropertyName(String propertyName) {
//		this.propertyName = propertyName;
//	}

//	public String getJdbcType() {
//		return jdbcType;
//	}
//
//	public void setJdbcType(String jdbcType) {
//		this.jdbcType = jdbcType;
//	}

//	public String getJavaType() {
//		return javaType;
//	}
//
//	public void setJavaType(String javaType) {
//		this.javaType = javaType;
//	}
	
}
