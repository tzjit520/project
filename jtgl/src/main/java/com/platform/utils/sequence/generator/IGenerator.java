package com.platform.utils.sequence.generator;

import java.util.Map;

public interface IGenerator {
	
	public String getGeneratorType();
	
	public String generate(String format, Map<String,String> parameterMap);
	
}
