package com.platform.system.dbobject.model;

import com.platform.model.BaseEntity;

public class SysDbObject extends BaseEntity<SysDbObject> {
    private static final long serialVersionUID = 3767103920176607421L;

    private String code;			// 数据对象编码
    private String name;			// 数据对象名称
    private String procedureName;	// 存储过程名称，暂不使用
    private String sysModule;		// 模块名，用于区分数据对象所属模块，暂不使用
    private String sqlStatements;	// 查询语句

    private String[] params;
    
    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getProcedureName() {
        return procedureName;
    }

    public void setProcedureName(String procedureName) {
        this.procedureName = procedureName;
    }

    public String getSysModule() {
        return sysModule;
    }

    public void setSysModule(String sysModule) {
        this.sysModule = sysModule;
    }

    public String getSqlStatements() {
        return sqlStatements;
    }

    public void setSqlStatements(String sqlStatements) {
        this.sqlStatements = sqlStatements;
    }

	public String[] getParams() {
		return params;
	}

	public void setParams(String[] params) {
		this.params = params;
	}
    
    
}