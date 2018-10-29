package com.platform.system.lov.model;

import java.util.ArrayList;
import java.util.List;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

@EntityAnotation(logicalDelete = true)
public class SysLov extends BaseEntity<SysLov> {

	private static final long serialVersionUID = -3073779008228797952L;

	private String module;	// 模块名，一般用于分组，暂不使用
	private String code;	// 编码
	private String name;	// 名称
	private Integer type; 	// 是否鉴权，1表示鉴权，0表示不鉴权

	private Integer depth;  //只用于前台表格展示树

	private List<SysLovLine> lovLineList = new ArrayList<SysLovLine>();
	
	public String getModule() {
		return module;
	}

	public void setModule(String module) {
		this.module = module;
	}

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

	public List<SysLovLine> getLovLineList() {
		return lovLineList;
	}

	public void setLovLineList(List<SysLovLine> lovLineList) {
		this.lovLineList = lovLineList;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getDepth() {
		return depth;
	}

	public void setDepth(Integer depth) {
		this.depth = depth;
	}
	
}