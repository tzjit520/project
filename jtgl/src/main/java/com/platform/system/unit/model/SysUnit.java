package com.platform.system.unit.model;

import java.util.ArrayList;
import java.util.List;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

@EntityAnotation(logicalDelete = true)
public class SysUnit extends BaseEntity<SysUnit> implements Comparable<SysUnit>{
	private static final long serialVersionUID = -3545454544441624L;

	private Integer parentId;

	private String name;

	private String code;

	private Integer type;

	private Integer sort;

	private SysUnit parentUnit;
	
	private Integer depth;			// 机构层级，1为第一层
	
	private List<SysUnit> childrenListUnits = new ArrayList<SysUnit>();		// 子机构

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public SysUnit getParentUnit() {
		return parentUnit;
	}

	public void setParentUnit(SysUnit parentUnit) {
		this.parentUnit = parentUnit;
	}

	public SysUnit(Integer parentId) {
		super();
		this.parentId = parentId;
	}

	public SysUnit(Integer id, Integer parentId) {
		super();
		this.parentId = parentId;
		super.id = id;
	}
	
	public SysUnit() {
		super();
	}

	public List<SysUnit> getChildrenListUnits() {
		return childrenListUnits;
	}

	public void setChildrenListUnits(List<SysUnit> childrenListUnits) {
		this.childrenListUnits = childrenListUnits;
	}

	public Integer getDepth() {
		return depth;
	}

	public void setDepth(Integer depth) {
		this.depth = depth;
	}

	@Override
	public int compareTo(SysUnit unit) {
		if (unit.getSort() != null && this.getSort() != null) {
			return this.getSort() - unit.getSort();
		}
		return 0;
	}

	
}