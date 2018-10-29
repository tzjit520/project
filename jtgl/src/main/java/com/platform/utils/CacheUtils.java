/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.platform.utils;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;


/**
 * Cache工具类
 */
public class CacheUtils {
	
	private static CacheManager cacheManager = ((CacheManager) SpringUtil.getBean("cacheManager"));

	private static final String SHIRO_CACHE = "shiro_cache";

	/**
	 * 获取SHIRO_CACHE缓存
	 * @param key
	 * @return
	 */
	public static Object get(String key) {
		return get(SHIRO_CACHE, key);
	}
	
	/**
	 * 写入SHIRO_CACHE缓存
	 * @param key
	 * @return
	 */
	public static void put(String key, Object value) {
		put(SHIRO_CACHE, key, value);
	}
	
	/**
	 * 从SHIRO_CACHE缓存中移除
	 * @param key
	 * @return
	 */
	public static void remove(String key) {
		remove(SHIRO_CACHE, key);
	}
	
	/**
	 * 获取缓存
	 * @param cacheName
	 * @param key
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static Object get(String cacheName, String key) {
		return getCache(cacheName).get(key);
	}

	/**
	 * 写入缓存
	 * @param cacheName
	 * @param key
	 * @param value
	 */
	@SuppressWarnings("unchecked")
	public static void put(String cacheName, String key, Object value) {
		getCache(cacheName).put(key, value);
	}

	/**
	 * 从缓存中移除
	 * @param cacheName
	 * @param key
	 */
	@SuppressWarnings("unchecked")
	public static void remove(String cacheName, String key) {
		getCache(cacheName).remove(key);
	}
	
	/**
	 * 获得一个Cache，没有则创建一个。
	 * @param cacheName
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	private static Cache getCache(String cacheName){
		Cache cache = cacheManager.getCache(cacheName);
		try {
			if(null == cache){
				cache = cacheManager.getCache(SHIRO_CACHE);
			}
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return cache;
	}

	public static CacheManager getCacheManager() {
		return cacheManager;
	}
	
}
