package com.platform.generator.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.platform.generator.model.SysTableColumn;
import com.platform.mapper.BaseMapper;

/**
 * 代码生成器
 * 
 * @author user
 *
 */
public interface SysTableColumnMapper extends BaseMapper<SysTableColumn> {

	/**
	 * 获取表的列名（对应Java的属性名）和数据类型
	 * 
	 * @param tableName
	 *            表名
	 * @return columnName, dataType
	 */
	List<SysTableColumn> selectColumns(@Param("tableName") String tableName);

}
