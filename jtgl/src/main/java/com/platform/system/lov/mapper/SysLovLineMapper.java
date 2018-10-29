package com.platform.system.lov.mapper;

import java.util.List;

import com.platform.mapper.BaseMapper;
import com.platform.system.lov.model.SysLovLine;


public interface SysLovLineMapper  extends BaseMapper<SysLovLine> {
	
	/**
	 * 根据值列表数据对象中的值类型ID、值类型编码、当前用户角色返回相应的值列表数据
	 * @param record
	 * @return
	 */
	public List<SysLovLine> selectByCode(SysLovLine record);
	
	/**
	 * 根据LovID删除值列表数据
	 * 物理删除
	 * @param lovId
	 */
    public void deleteByLovId(Integer lovId);
    
    /**
	 * 根据LovID删除值列表数据
	 * 逻辑删除
	 * @param lovId
	 */
    public void logicalDeleteByLovId(Integer lovId);
}