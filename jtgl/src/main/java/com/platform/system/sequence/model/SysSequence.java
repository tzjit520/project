package com.platform.system.sequence.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class SysSequence extends BaseEntity<SysSequence> {

	private String code; // 序列编码
	private String name; // 序列名称
	private String formartStr; // 序列格式化字符串
	private Integer seqNumber; // 序列数值
	private Integer seqStep; // 步长

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
	
	public String getFormartStr() {
		return formartStr;
	}
	
	public void setFormartStr(String formartStr) {
		this.formartStr = formartStr;
	}
	
	public Integer getSeqNumber() {
		return seqNumber;
	}
	
	public void setSeqNumber(Integer seqNumber) {
		this.seqNumber = seqNumber;
	}
	
	public Integer getSeqStep() {
		return seqStep;
	}
	
	public void setSeqStep(Integer seqStep) {
		this.seqStep = seqStep;
	}
	
}
