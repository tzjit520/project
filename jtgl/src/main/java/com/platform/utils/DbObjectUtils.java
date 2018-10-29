package com.platform.utils;

import java.util.List;
import java.util.Map;

import com.platform.system.dbobject.model.SysDbObject;
import com.platform.system.dbobject.service.SysDbObjectService;

/**
 * 数据对象   工具类
 */
public class DbObjectUtils {

	private static SysDbObjectService dbObjectService = (SysDbObjectService) SpringUtil.getBean("sysDbObjectService");
	public static final String DBOBJECT_CACHE = "objCache";
	public static final String DBOBJECT_CACHE_CODE = "code_";
	
	/**
	 * 根据code获取数据对象
	 */
	@SuppressWarnings("unchecked")
	public static List<Map<String, Object>> getSqlList(String code){
		List<Map<String,Object>> list = (List<Map<String,Object>>) CacheUtils.get(DBOBJECT_CACHE, DBOBJECT_CACHE_CODE + code);
		if(list == null){
			SysDbObject dbObject = new SysDbObject();
			dbObject.setCode(code);
			list = dbObjectService.getTranslateList(dbObject);
			CacheUtils.put(DBOBJECT_CACHE, DBOBJECT_CACHE_CODE + code, list);
		}
		return list;
	}
	
}
