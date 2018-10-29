package com.platform.generator.util;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.text.WordUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.platform.generator.model.SysTableColumn;

import freemarker.template.Template;

/**
 * 代码生成工具类
 */
@Service
public class GeneratorUtil {
	
	@Autowired
	private FreeMarkerConfigurer freemarkerConfig;

	// 生产代码的Java文件存放目录
	@Value("${generator.targetSrcDir}")
	private String targetSrcDir;

	// 生成代码的资源文件存放目录
	@Value("${generator.targetResourceDir}")
	private String targetResourceDir;

	// 数据库类型
	@Value("${datasource.type}")
	private String dataSourceType;

	/**
	 * 模板文件
	 */
	@SuppressWarnings("serial")
	private static Map<String, String> templateFiles = new HashMap<String, String>(){
		{
			put("mapper", "Mapper.java.ftl");
			put("model", "Model.java.ftl");
			put("service", "Service.java.ftl");
			put("controller", "Controller.java.ftl");
			put("mapper.impl", "Mapper.xml.ftl");
		}
	};

	/**
	 * 根据用户指定的包名和数据表信息生成相应的源码
	 * 
	 * @param packageName
	 * @param tableName
	 * @param columns
	 * @throws Exception
	 */
	public void createFile(String packageName, String tableName, List<SysTableColumn> columns) throws Exception {
		String className = tableNameConvertor(tableName);
		// 构造生成代码需要的数据
		Map<String, Object> dataModel = bulildModel(packageName, tableName, columns);
		// 根据不同的模版生成相应的文件
		for (Map.Entry<String, String> entry : templateFiles.entrySet()) {
			// 子目录
			String targetSubDir = entry.getKey();
			// 模版文件名
			String templateFileName = entry.getValue();
			// 根据指定包名和相应的子目录创建目标目录
			String targetPath = createDir(packageName, targetSubDir);
			if (targetPath != null) {
				// 构建完整的文件路径
				String fileName = buildFullFileName(targetPath, className, templateFileName);
				File outFile = new File(fileName);
				// 渲染模板
				Writer out = null;
				try {
					out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFile)));
					// 对mapper.xml.ftl文件特殊处理，加上dataSourceType的前缀
					if ("Mapper.xml.ftl".equals(templateFileName)) {
						templateFileName = this.dataSourceType + "." + templateFileName;
					}
					Template template = freemarkerConfig.getConfiguration().getTemplate(templateFileName);
					template.process(dataModel, out);
					out.flush();
				} catch (Exception e) {
					e.printStackTrace();
					throw e;
				} finally {
					// 关闭输出流
					try {
						out.close();
					} catch (Exception e) {
					}
				}
			}
		}
	}

	/**
	 * 表名转换为类名
	 * @param tableName
	 * @return
	 */
	private String tableNameConvertor(String tableName) {
		return WordUtils.capitalizeFully(tableName, new char[] { '_', 'T', '_' }).replace("_T_", "").replace("_", "");
	}
	
	/**
	 * 构造生成代码需要的数据
	 * 
	 * @param tableName
	 * @param columns
	 * @return
	 */
	private Map<String, Object> bulildModel(String packageName, String tableName, List<SysTableColumn> columns) {
		// 根据DataSourceType创建不同的ColumnConverter
		ColumnConverter converter = ColumnConverterFactory.getColumnConverter(dataSourceType);
		
		String className = tableNameConvertor(tableName);
		Map<String, Object> dataModel = new HashMap<String, Object>();
		dataModel.put("package", packageName);
		dataModel.put("tableName", tableName);
		dataModel.put("ClassName", className);
		dataModel.put("className", StringUtils.uncapitalize(className));
		dataModel.put("columns", converter.convert(columns));
		
		// 生成去除com的目录，供html页面中使用
		dataModel.put("htmldir", packageName.replace("com.", "").replace(".", "/"));
		return dataModel;
	}

	/**
	 * 根据指定的包名及子目录名创建目录
	 * 
	 * @param packageName
	 * @param targetSubDir
	 * @return
	 */
	private String createDir(String packageName, String targetSubDir) {
		// 确定目标目录
		StringBuilder sb = new StringBuilder();
		// mapper.xml文件存放路径生成
		if ("mapper.impl".equals(targetSubDir)) {
			// 资源文件目录
			sb.append(targetResourceDir).append(File.separator);
			// 根据数据库类型在com目录后增加dataSourceType的目录
			// 默认认为package一定是以com.开始
			packageName = packageName.replaceAll("com.", "");
			sb.append("com.").append(File.separator).append(dataSourceType).append(File.separator);
			sb.append(packageName.replace(".", File.separator)).append(File.separator).append("mapper").append(File.separator).append("impl").append(File.separator);
		}else {
			// Java文件目录
			sb.append(targetSrcDir).append(File.separator);
			sb.append(packageName.replace(".", File.separator)).append(File.separator);
			// 在指定包名下增加相应的子目录(model, mapper, service, web)
			sb.append(targetSubDir);
		}
		// 检查是否存在目标目录，若不存在则创建
		File targetDir = new File(sb.toString());
		if (!targetDir.exists()) {
			return targetDir.mkdirs() ? sb.toString() : null;
		} else {
			return sb.toString();
		}
	}

	/**
	 * 根据类名和模版名构建目标文件名
	 * 
	 * @param className
	 * @param templateFileName
	 * @return
	 */
	private String buildFullFileName(String targetPath, String className, String templateFileName) {
		StringBuilder sb = new StringBuilder(targetPath);
		sb.append(File.separator);
		// 对于html文件特殊处理，不加类名
		if ("list.html.ftl".equals(templateFileName) || "view.html.ftl".equals(templateFileName) || "edit.html.ftl".equals(templateFileName)) {
			sb.append(templateFileName.substring(0, templateFileName.lastIndexOf(".")));
		} 
		// else中为对js文件、java文件和mapper.xml文件的处理
		else {
			sb.append(className);
			if ("Model.java.ftl".equals(templateFileName)) {
				// 生成实体类时，不加"Model"后缀
				sb.append(".java");
			} else {
				sb.append(templateFileName.substring(0, templateFileName.lastIndexOf(".")));
			}
		}
		return sb.toString();
	}
}
