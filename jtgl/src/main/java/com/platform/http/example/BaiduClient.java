package com.platform.http.example;

import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;

import com.platform.http.BaseHttpClient;

@Service
public class BaiduClient extends BaseHttpClient {

	private String baiduURL = "http://www.baidu.com";
		
	/**
	 * 百度无需登录，空实现
	 */
	@Override
	public void login() {
	}
	
	@Override
	public void prepareConnection() {
		requestContext.url(this.baiduURL);
	}
	
	@Override
	public void doProcess(Document document) {
		System.out.println(document.body().html());
	}	

	public static void main(String[] args) {
		BaiduClient bcBaiduClient = new BaiduClient();
		bcBaiduClient.prepareConnection();
		bcBaiduClient.get();
	}
}
