package com.platform.system.lov.model;

import java.util.List;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;
import com.platform.system.role.model.SysRole;

@EntityAnotation(logicalDelete = true)
public class SysLovLine extends BaseEntity<SysLovLine> {

    private static final long serialVersionUID = -598798534433349802L;
    
    private String code;		// 编码
    private String name;		// 名称
    private String value;		// 值
    private Integer sort;		// 排序
    
    private Integer lovId;			// 值类型对象ID    
    private Integer lovType;	// 值类型对象的类型，该字段用于设置查询条件
    private String lovCode;		// 值类型对象的编码，该字段与sysLov中的lovCode重复，该字段用于设置查询条件
    private SysLov sysLov;		// 值类型对象
    
    private Long roleId;    	// 角色ID
    // 该变量仅在LovLineService的getTranslateList方法中使用
    private List<SysRole> roleList;		// 角色列表
    
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
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public Integer getSort() {
		return sort;
	}
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	public Integer getLovId() {
		return lovId;
	}
	public void setLovId(Integer lovId) {
		this.lovId = lovId;
	}
	public Integer getLovType() {
		return lovType;
	}
	public void setLovType(Integer lovType) {
		this.lovType = lovType;
	}
	public String getLovCode() {
		return lovCode;
	}
	public void setLovCode(String lovCode) {
		this.lovCode = lovCode;
	}
	public SysLov getSysLov() {
		return sysLov;
	}
	public void setSysLov(SysLov sysLov) {
		this.sysLov = sysLov;
	}
	public Long getRoleId() {
		return roleId;
	}
	public void setRoleId(Long roleId) {
		this.roleId = roleId;
	}
	public List<SysRole> getRoleList() {
		return roleList;
	}
	public void setRoleList(List<SysRole> roleList) {
		this.roleList = roleList;
	}
    
    
}