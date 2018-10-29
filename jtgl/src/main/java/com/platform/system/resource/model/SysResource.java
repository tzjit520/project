package com.platform.system.resource.model;

import java.util.ArrayList;
import java.util.List;

import com.platform.model.BaseEntity;
import com.platform.system.operation.model.SysOperation;

public class SysResource extends BaseEntity<SysResource> {
	private static final long serialVersionUID = 8627704085216363192L;

    private String name;//资源名称

    private String code;//资源编码

    private List<SysOperation> operationList = new ArrayList<SysOperation>();

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

    public List<SysOperation> getOperationList() {
        return operationList;
    }

    public void setOperationList(List<SysOperation> operationList) {
        this.operationList = operationList;
    }
}