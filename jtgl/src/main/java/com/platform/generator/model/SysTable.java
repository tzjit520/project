package com.platform.generator.model;

import com.platform.model.BaseEntity;

public class SysTable extends BaseEntity<SysTable>{
	
	private static final long serialVersionUID = -3421454263233994546L;
	
	private String tableName;
	private String comment;
	private Integer rows; // 表的记录数
	
	private String tableNames; // 代码生成时选择的表名，json格式，[tablename1, tablename2, tablename3]
	private String packageName; // 代码生成时输入的包名

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Integer getRows() {
		return rows;
	}

	public void setRows(Integer rows) {
		this.rows = rows;
	}

	public String getTableNames() {
		return tableNames;
	}

	public void setTableNames(String tableNames) {
		this.tableNames = tableNames;
	}

	public String getPackageName() {
		return packageName;
	}

	public void setPackageName(String packageName) {
		this.packageName = packageName;
	}
	
}
