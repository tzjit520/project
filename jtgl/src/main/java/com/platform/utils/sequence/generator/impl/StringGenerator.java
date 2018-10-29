package com.platform.utils.sequence.generator.impl;

import java.util.Map;

import com.platform.utils.sequence.generator.GeneratorTypeEnum;
import com.platform.utils.sequence.generator.IGenerator;

public class StringGenerator implements IGenerator {

	private static final String type = GeneratorTypeEnum.STRING.getValue();
	
	@Override
	public String getGeneratorType() {
		return type;
	}

	@Override
	public String generate(String format, Map<String,String> parameterMap) {
		return format;
	}

}
