package com.platform.utils;

public class RandStringUtil {
	
	/**
	 * 生成一个指定长度的随机字符串
	 * @param length
	 * @return
	 */
	public static String getString(int length) {
		String a = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < length; i++) {
			int rand = (int) (Math.random() * a.length());
			sb.append(a.charAt(rand));
		}
		return sb.toString();
	}
}
