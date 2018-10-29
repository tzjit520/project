package com.platform.system.operation.model;

import com.platform.model.BaseEntity;

public class SysOperation extends BaseEntity<SysOperation> {
	
	private static final long serialVersionUID = -8353669305729584763L;

    private String name;//操作名称

    private String code;//操作编码

    private Integer resourceId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getResourceId() {
        return resourceId;
    }

    public void setResourceId(Integer resourceId) {
        this.resourceId = resourceId;
    }
}