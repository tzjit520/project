package com.platform.utils;

import java.util.List;

import com.platform.system.lov.model.SysLov;
import com.platform.system.lov.model.SysLovLine;
import com.platform.system.lov.service.SysLovService;

/**
 * 值列表   工具类
 */
public class LovUtils {

	private static SysLovService sysLovService = (SysLovService) SpringUtil.getBean("sysLovService");
	public static final String LOV_CACHE = "lovCache";
	public static final String LOV_CACHE_CODE = "code_";
	public static final String LOV_LINE_CACHE = "lovLineCache";
	public static final String LOV_LINE_CACHE_ID = "id_";
	
	/**
	 * 根据code获取值数据
	 */
	@SuppressWarnings("unchecked")
	public static List<SysLovLine> getLineList(String code){
		List<SysLovLine> listLovLine = (List<SysLovLine>) CacheUtils.get(LOV_LINE_CACHE, LOV_LINE_CACHE_ID + code);
		if(listLovLine == null){
			SysLov sysLov = getLov(code);
			listLovLine = sysLov.getLovLineList();
			if(listLovLine.size() > 0){
				CacheUtils.put(LOV_LINE_CACHE, LOV_LINE_CACHE_ID + code, listLovLine);
			}
		}
		return listLovLine;
	}
	
	/**
	 * 根据code获取值类型
	 * @param code
	 */
	public static SysLov getLov(String code){
		SysLov sysLov = (SysLov) CacheUtils.get(LOV_CACHE, LOV_CACHE_CODE + code);
		if(sysLov == null){
			sysLov = sysLovService.selectByCode(code);
			CacheUtils.put(LOV_CACHE, LOV_CACHE_CODE + code, sysLov);
		}
		return sysLov;
	}
	
	/**
	 * 根据code获取值类型
	 * @param lineCode 值数据code
	 * @param lovCode 值类型code
	 */
	public static String getLineValue(String lineCode, String lovCode){
		List<SysLovLine> listLovLine = getLineList(lovCode);
		for (SysLovLine sysLovLine : listLovLine) {
			if(lineCode.equals(sysLovLine.getCode())){
				return sysLovLine.getName();
			}
		}
		return null;
	}

}
