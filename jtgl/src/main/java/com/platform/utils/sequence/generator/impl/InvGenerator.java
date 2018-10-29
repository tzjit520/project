package com.platform.utils.sequence.generator.impl;

import java.util.Map;

import com.platform.utils.sequence.generator.GeneratorTypeEnum;
import com.platform.utils.sequence.generator.IGenerator;

public class InvGenerator implements IGenerator {

	private static final String type = GeneratorTypeEnum.INV.getValue();
	
	@Override
	public String getGeneratorType() {
		return type;
	}

	@Override
	public String generate(String format, Map<String,String> parameterMap) {
		String inv = parameterMap.get(GeneratorTypeEnum.INV.getValue());//要处理的id
		if(inv == null){
			return "";
		}
		return inv;
		
	}
	
	

}
