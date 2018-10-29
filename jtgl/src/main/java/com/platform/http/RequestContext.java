package com.platform.http;

import java.util.HashMap;
import java.util.Map;

import org.jsoup.Connection.Method;

/**
 * 存放HTTP请求用到的参数，包括超时时间、Cookies、请求数据等
 */
public class RequestContext {
	
	// 访问链接
	private String url = null;
	
	// 默认超时时间，单位毫秒
	private int timeout = 30000;
	
	// 请求方式，put、get、delete等
	private Method method = null;
	
	// headers
	Map<String, String> headers = new HashMap<String, String>();
		
	// cookies
	Map<String, String> cookies = new HashMap<String, String>();
	
	// 存放在不同请求间需要传递的参数
	Map<String, Object> globalDatas = new HashMap<String, Object>();
	
	// 存放单次请求需要给后台传递的参数
	Map<String, String> requestDatas = new HashMap<String, String>();

	public Map<String, String> headers() {
		return headers;
	}

	public RequestContext headers(Map<String, String> headers) {
		this.headers = headers;
		return this;
	}
	
	public Map<String, String> cookies() {
		return cookies;
	}

	public RequestContext cookies(Map<String, String> cookies) {
		this.cookies = cookies;
		return this;
	}

	public Map<String, Object> globalDatas() {
		return globalDatas;
	}

	public RequestContext globalDatas(Map<String, Object> globalDatas) {
		this.globalDatas = globalDatas;
		return this;
	}
	
	public Map<String, String> requestDatas() {
		return requestDatas;
	}
	
	public RequestContext requestDatas(Map<String, String> requestDatas) {
		this.requestDatas = requestDatas;
		return this;
	}

	public RequestContext header(String key, String value) {
		this.headers.put(key, value);
		return this;
	}
	
	public RequestContext cookie(String key, String value) {
		this.cookies.put(key, value);
		return this;
	}
	
	public RequestContext globalData(String key, Object value) {
		this.globalDatas.put(key, value);
		return this;
	}
	
	public RequestContext requestData(String key, String value) {
		this.requestDatas.put(key, value);
		return this;
	}
	
	public String header(String key){
		return this.headers.get(key);
	}
	
	public String cookie(String key){
		return this.cookies.get(key);
	}

	public Object globalData(String key){
		return this.globalDatas.get(key);
	}
	
	public String requestData(String key){
		return this.requestDatas.get(key);
	}
	
	public int timeout() {
		return timeout;
	}

	public RequestContext timeout(int timeout) {
		this.timeout = timeout;
		return this;
	}

	public Method method() {
		return method;
	}

	public RequestContext method(Method method) {
		this.method = method;
		return this;
	}

	public String url() {
		return url;
	}

	public RequestContext url(String url) {
		this.url = url;
		return this;
	}
	
}
