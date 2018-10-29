package com.platform.system.sequence.mapper;

import com.platform.mapper.BaseMapper;

import com.platform.system.sequence.model.SysSequence;

public interface SysSequenceMapper extends BaseMapper<SysSequence> {
	
	public SysSequence selectByCode(String code);
}
