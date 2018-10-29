package com.platform.generator.util;

import java.lang.reflect.Field;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang3.text.WordUtils;

import com.platform.generator.model.SysTableColumn;
import com.platform.system.user.model.SysUser;

public abstract class ColumnConverter {
	
	// Entity基类字段，用于在根据数据表字段生成实体类时过滤基类中的字段
	protected static final Set<String> baseEntityFieldSet = new HashSet<String>();
	// 需增加到mapper.xml文件中的基类字段，为所有数据库表的公共字段
	protected static Set<String> baseEntityDefaultFieldSet = new HashSet<String>();
			
	static {
		if (baseEntityFieldSet.isEmpty()) {
			// BaseEntity为泛型 抽象类，因此使用其实现类SysUser获取其父类的属性
			Field fields[] = SysUser.class.getSuperclass().getDeclaredFields();
			for (Field field : fields) {
				baseEntityFieldSet.add(field.getName());
			}
				
			baseEntityDefaultFieldSet.add("id");
			baseEntityDefaultFieldSet.add("remark");
			baseEntityDefaultFieldSet.add("deleted");
			baseEntityDefaultFieldSet.add("status");
			baseEntityDefaultFieldSet.add("createBy");
			baseEntityDefaultFieldSet.add("createDate");
			baseEntityDefaultFieldSet.add("updateBy");
			baseEntityDefaultFieldSet.add("updateDate");
		}
	}
	
	/**
	 * 对查询到的列进行转换，转换为Java文件需要的属性名称和数据类型
	 * @param columns List<Map<columnName, dataType>>
	 * @return
	 */
	public abstract List<Map<String, String>> convert(List<SysTableColumn> columns);
	
	/**
	 * 数据库列名转变为属性名，将_去除，并将_后面的第一个字母修改为大写
	 * @param columnName
	 * @return
	 */
	public static String columnNameConvertor(String columnName) {
		return WordUtils.uncapitalize(WordUtils.capitalize(columnName.toLowerCase(), new char[] { '_' }).replace("_", ""));
	}

}
