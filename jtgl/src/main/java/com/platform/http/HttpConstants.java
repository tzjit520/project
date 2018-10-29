package com.platform.http;

import java.util.HashMap;
import java.util.Map;

public class HttpConstants {
	
	public static final String HEAD_USER_AGENT_KEY = "User-Agent";
	public static final String HEAD_USER_AGENT_VALUE = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36";

	/**
	 * 获取默认requst headers
	 * @return
	 */
	public static Map<String, String> getDefaultHeaders() {
		Map<String, String> headers = new HashMap<String, String>();
		headers.put(HEAD_USER_AGENT_KEY, HEAD_USER_AGENT_VALUE);
		
		return headers;
	}
}
