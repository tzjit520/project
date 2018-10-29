package com.platform.system.lov.mapper;

import java.util.List;

import com.platform.mapper.BaseMapper;
import com.platform.system.lov.model.SysLov;


public interface SysLovMapper extends BaseMapper<SysLov> {
	
    List<SysLov> selectFetchLineByProperties(SysLov record);
    
    public SysLov selectByCode(String code);
}