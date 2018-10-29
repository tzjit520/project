package com.platform.utils;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;

/**
 * 异步返回工具类
 */
public class ResponseUtil {

	/**
	 * 发送内容
	 * @param response
	 * @param contextType
	 * @param text
	 */
	public static void send(HttpServletResponse response,String contentType,String text){
		response.setContentType(contentType);
		try {
			response.getWriter().write(text);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	//发送的是JSON
	public static void sendJson(HttpServletResponse response,String text){
		send(response, "application/json;charset=UTF-8", text);
	}
	//发送xml
	public static void sendXml(HttpServletResponse response,String text){
		send(response, "text/xml;charset=UTF-8", text);
	}
	//发送text
	public static void sendText(HttpServletResponse response,String text){
		send(response, "text/plain;charset=UTF-8", text);
	}
	
}
