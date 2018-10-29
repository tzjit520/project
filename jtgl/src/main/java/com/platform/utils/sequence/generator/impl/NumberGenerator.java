package com.platform.utils.sequence.generator.impl;

import java.util.Map;

import com.platform.utils.sequence.generator.GeneratorTypeEnum;
import com.platform.utils.sequence.generator.IGenerator;

public class NumberGenerator implements IGenerator {

	private static final String type = GeneratorTypeEnum.NUMBER.getValue();
	
	private String split = "S";
	
	@Override
	public String getGeneratorType() {
		return type;
	}

	@Override
	public String generate(String format, Map<String,String> parameterMap) {
		String currentNum = parameterMap.get("currentNum");//要处理的id
		if(currentNum == null){
			return "";
		}
		String[] charArr = format.split(split);
		int seqNumLength = Integer.parseInt(charArr[0]);
		char prefixChar = charArr[1].charAt(0);
		if(seqNumLength == 0){
			return currentNum;
		}else{
			return appendPrefixChar(prefixChar, seqNumLength, currentNum);
		}
	}
	
	/**
	 * 补足前缀以保证序列定长，如 0001, 保持 4 位，不足 4 位用'0'补齐
	 * @param prefixChar 需要补齐的前缀字符
	 * @param seqNumLength  生成器需要返回的字符窜长度
	 * @param currentNum 当前数值字符窜
	 * @return
	 */
	private String appendPrefixChar(char prefixChar,int seqNumLength,String currentNum){
		StringBuffer sb = new StringBuffer();
		for(int i = currentNum.length();i<seqNumLength;i++){
			sb.append(prefixChar);
		}
		sb.append(currentNum);
		return sb.toString();
	}

}
