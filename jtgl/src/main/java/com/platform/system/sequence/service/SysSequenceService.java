package com.platform.system.sequence.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.sequence.mapper.SysSequenceMapper;
import com.platform.system.sequence.model.SysSequence;
import com.platform.utils.sequence.SequenceGenerateEngine;


@Service
public class SysSequenceService extends BaseService<SysSequenceMapper, SysSequence> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysSequence> selectByPage(SysSequence vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysSequence> results = this.selectByProperties(vo);

		PageModel<SysSequence> page = new PageModel<SysSequence>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	/**
	 * 根据code  获取对应的序列   
	 */
	public String getCode(String code){
		//根据编码查询序列
		SysSequence seq = this.getMapper().selectByCode(code);
		String formatStr = seq.getFormartStr();
		//更新序列  并且返回最新序列值
		int newNumber = updateSequenceCurrentNum(seq);
		Map<String,String> parameterMap= new HashMap<String,String>();
		parameterMap.put("currentNum",  newNumber+"");
		SequenceGenerateEngine sequenceGenerateEngine = SequenceGenerateEngine.getInstance();
		sequenceGenerateEngine.setFormatStr(formatStr);
		return sequenceGenerateEngine.generate(parameterMap);
	}
	
	//将原有序列值加上步长  获取一个新值
	public int updateSequenceCurrentNum(SysSequence seq) {
		//当前数字序列号值
		seq.setSeqNumber(seq.getSeqNumber().intValue() + seq.getSeqStep().intValue());
		this.updateNotNull(seq);
		return seq.getSeqNumber();
	}
}
