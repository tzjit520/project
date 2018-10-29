package com.platform.utils.sequence.generator.impl;

import java.util.Map;

import com.platform.utils.sequence.generator.GeneratorTypeEnum;
import com.platform.utils.sequence.generator.IGenerator;

public class CompanyGenerator implements IGenerator {

	private static final String type = GeneratorTypeEnum.COMPANY.getValue();
	
	@Override
	public String getGeneratorType() {
		return type;
	}

	@Override
	public String generate(String format, Map<String,String> parameterMap) {
		String company = parameterMap.get(GeneratorTypeEnum.COMPANY.getValue());//要处理的id
		if(company == null){
			return "";
		}
		return company;
		
	}
	
	

}
