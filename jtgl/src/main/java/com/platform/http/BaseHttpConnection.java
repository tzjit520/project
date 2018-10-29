package com.platform.http;

import java.io.IOException;

import org.apache.commons.httpclient.HttpStatus;
import org.apache.log4j.Logger;
import org.jsoup.Connection;
import org.jsoup.Connection.Method;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import com.platform.common.exception.HttpConnectException;

/**
 * 网络请求发起及处理基类
 * 在一个BaseHttpClient中仅对一个URL地址发起请求，并解析其返回内容
 */
public abstract class BaseHttpConnection {
	
	private Logger logger = Logger.getLogger(getClass());
	
	protected RequestContext requestContext = new RequestContext();
	
	/**
	 * 发起一个http get连接
	 * @param requestContext 请求上下文
	 * @throws HttpConnectException
	 */
	public void get(RequestContext requestContext) throws HttpConnectException {
		this.requestContext = requestContext;
		requestContext.method(Method.GET);
		this.connect();
	}
	
	/**
	 * 发起一个http post连接
	 * @param requestContext 请求上下文
	 * @throws HttpConnectException
	 */
	public void post(RequestContext requestContext) throws HttpConnectException {
		this.requestContext = requestContext;
		requestContext.method(Method.POST);
		this.connect();
	}
	
	/**
	 * 发起一个http put连接
	 * @param requestContext 请求上下文
	 * @throws HttpConnectException
	 */
	public void put(RequestContext requestContext) throws HttpConnectException {
		this.requestContext = requestContext;
		requestContext.method(Method.PUT);
		this.connect();
	}
	
	/**
	 * 发起一个http delete连接
	 * @param requestContext 请求上下文
	 * @throws HttpConnectException
	 */
	public void delete(RequestContext requestContext) throws HttpConnectException {
		this.requestContext = requestContext;
		requestContext.method(Method.DELETE);
		this.connect();
	}
	
	/**
	 * 发起一个http连接
	 * @throws HttpConnectException
	 */
	protected void connect() throws HttpConnectException {
		this.prepareConnection();
		
		logger.info("---------request url---------");
		logger.info(requestContext.url());
		logger.info("---------request headers---------");
		logger.info(requestContext.headers());
		logger.info("---------request cookies---------");
		logger.info(requestContext.cookies());
		logger.info("---------request datas---------");
		logger.info(requestContext.requestDatas());
		
		Connection.Response response = null;
		try {
			response = Jsoup.connect(requestContext.url())
					.headers(requestContext.headers())
					.data(requestContext.requestDatas())
	                .cookies(requestContext.cookies())
	                .timeout(requestContext.timeout())
	                .method(requestContext.method())
	                .execute();
			
			logger.info("---------response contentType---------");
			logger.info(response.contentType());
			logger.info("---------response statusCode---------");
			logger.info(response.statusCode());
			logger.info("---------response statusMessage---------");
			logger.info(response.statusMessage());
			logger.info("---------response charset---------");
			logger.info(response.charset());
			
			logger.info("---------response headers---------");
			logger.info(response.headers());
			logger.info("---------response cookies---------");
			logger.info(response.cookies());
			// 打印返回内容根据需要决定是否打开
//			logger.info("---------response body---------");
//			logger.info(response.parse().body().html());
			
			// 返回状态码是200，则解析结果交由doProcess处理
			if (response.statusCode() == HttpStatus.SC_OK) {
				doProcess(response.parse());
			} else {
				throw new HttpConnectException(response.statusCode(), response.parse().body().html());
			}
		
		} catch (IOException exp) {
			logger.error(exp);
			throw new HttpConnectException(response.statusCode(), exp.getMessage(), exp.getCause());
		}
	}
	
	/**
	 * 在连接发送前对需要发送的数据或Cookies进行处理
	 * @param datas 外部数据
	 */
	public abstract void prepareConnection();
	
	/**
	 * 对返回结果进行处理
	 * @param document 返回页面
	 */
	public abstract void doProcess(Document document);

	
	public RequestContext requestContext() {
		return requestContext;
	}
	
}
