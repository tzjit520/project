package com.platform.utils.sequence.generator.impl;

import java.util.Date;
import java.util.Map;

import org.apache.commons.lang3.time.DateFormatUtils;

import com.platform.utils.sequence.generator.GeneratorTypeEnum;
import com.platform.utils.sequence.generator.IGenerator;

public class DateTimeGenerator implements IGenerator {

	private static final String type = GeneratorTypeEnum.DATE_TIME.getValue();
	
	@Override
	public String getGeneratorType() {
		return type;
	}

	@Override
	public String generate(String format, Map<String, String> parameterMap) {
		return DateFormatUtils.format(new Date(), format);
	}

}
