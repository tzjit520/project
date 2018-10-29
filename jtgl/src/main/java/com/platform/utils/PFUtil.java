package com.platform.utils;

import java.util.Collection;

public class PFUtil {
	
	/**
	 * 将List中的String值转换为SQL查询的条件语句
	 * @param datas 
	 * @return
	 */
	public static String convertListToString(Collection<String> datas) {
		StringBuffer sb = new StringBuffer("");
		for (String data : datas) {
			sb.append("'" + data + "',");
		}
		if (sb.toString().length() > 0) {
			return sb.toString().substring(0, sb.toString().length() - 1);
		} else {
			return "''";
		}
	}
	
	public static String convertArrayToString(Object[] objArray) {
		StringBuffer sb = new StringBuffer("");
		for (Object data : objArray) {
			sb.append("'" + data + "',");
		}
		if (sb.toString().length() > 0) {
			return sb.toString().substring(0, sb.toString().length() - 1);
		} else {
			return "''";
		}
	}

}
