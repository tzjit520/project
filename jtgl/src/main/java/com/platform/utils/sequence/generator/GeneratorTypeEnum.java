package com.platform.utils.sequence.generator;

public enum GeneratorTypeEnum {
	COMPANY("Company","公司类型"),
	INV("Inv","库存类型"),
	STRING("Str","字符窜类型"),
	DATE_TIME("DateTime","日期类型"),
	NUMBER("NumSeq","数字类型");
	
	private String value;
	
	private String desc;
	
	private GeneratorTypeEnum(String value,String desc){
		this.value = value;
		this.desc = desc;
	}

	public String getValue() {
		return value;
	}

	public String getDesc() {
		return desc;
	}
	
	
}
