package com.platform.utils.sequence;

import java.util.HashMap;
import java.util.Map;

import com.platform.utils.sequence.generator.IGenerator;
import com.platform.utils.sequence.generator.impl.DateTimeGenerator;
import com.platform.utils.sequence.generator.impl.NumberGenerator;
import com.platform.utils.sequence.generator.impl.StringGenerator;

public class SequenceGenerateEngine {
	//流水号生成引擎对象
	private static SequenceGenerateEngine sequenceGenerateEngine = new SequenceGenerateEngine();
	private static Map<String,IGenerator> generatorMap = new HashMap<String,IGenerator>();
	//流水号生成规则
	@SuppressWarnings("unused")
	private String formatStr;
	//子序列分割符
	private String splitChar = "#";
	//子序列内部分隔符
	private String innerChar = "@";
	//流水号子序列生成规则
	private String[] subFormatStr;
	
	/**
	 * 生成器初始化
	 */
	static {
		StringGenerator stringGenerator = new StringGenerator();
		NumberGenerator numberGenerator = new NumberGenerator();
		DateTimeGenerator dateTimeGenerator = new DateTimeGenerator();
		generatorMap.put(stringGenerator.getGeneratorType(), new StringGenerator());
		generatorMap.put(numberGenerator.getGeneratorType(), new NumberGenerator());
		generatorMap.put(dateTimeGenerator.getGeneratorType(), new DateTimeGenerator());
	}
	/**
	 * 单例模式:
	 */
	private SequenceGenerateEngine(){
		
	}
	

	public void addGenerator(IGenerator generator){
		generatorMap.put(generator.getGeneratorType(), generator);
	}
	
	public static SequenceGenerateEngine getInstance(){
		return sequenceGenerateEngine;
	}
	
	public void setFormatStr(String formatStr){
		this.formatStr = formatStr;
		this.subFormatStr = formatStr.split(splitChar);
	}
	/**
	 * 
	 * @param parameterMap 传递参数：key = currentNum代表要生成的数字、
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	public String generate(Map parameterMap){
		StringBuffer sb = new StringBuffer();
		for(String format : subFormatStr){
			sb.append(this.generateSubSN(format, parameterMap));
		}
		return sb.toString();
	}
	/**
	 * 生成子序列号
	 * @param format 子序列格式字符窜  ，如：Str@中央、NumSeq@5S0
	 * @param parameterMap
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private String generateSubSN(String format,Map parameterMap){
		String[] innerSubStr = format.split(innerChar);
		if(innerSubStr.length < 2){
			return "";
		}
		IGenerator generator = this.getGenerator(innerSubStr[0]);
		if(generator == null){
			return "";
		}else{
			return generator.generate(innerSubStr[1], parameterMap);
		}
	}
	/**
	 * 返回序列生成器
	 * @param type 序列类型
	 * @return
	 */
	private IGenerator getGenerator(String type){
		return generatorMap.get(type);
	}
	
	public static void main(String[] args) {
		String formatStr= "Str@Order#DateTime@yyyyMMdd#NumSeq@5S0";
		Map<String,String> parameterMap= new HashMap<String,String>();
		parameterMap.put("currentNum", 10+"");
		SequenceGenerateEngine sequenceGenerateEngine = SequenceGenerateEngine.getInstance();
		sequenceGenerateEngine.setFormatStr(formatStr);
		String gs = sequenceGenerateEngine.generate(parameterMap);
		System.out.println(gs);
	}

}
