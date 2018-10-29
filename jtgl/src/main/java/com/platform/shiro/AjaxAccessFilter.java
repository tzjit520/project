package com.platform.shiro;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;

import com.alibaba.fastjson.JSONObject;

/**
  * 用于处理未授权的AJAX访问请求（注意：该类的方法是在subject.login(token)之后才调用的）
  * 在会话失效后，发生ajax请求时shiro不会跳转到登录页面，
  * 也无返回数据，因此需要以ajax方式提示浏览器进行跳转
  */
public class AjaxAccessFilter extends AccessControlFilter
{
	/**
	  * 返回true表示允许访问，就不会再调用onAccessDenied()了；返回false表示拒绝，需要onAccessDenied()继续处理
	 */
	@Override
	protected boolean isAccessAllowed(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {
		return false;
	}

	/**
	  * 返回true表示需要继续处理；返回false表示该拦截器已经处理了，不需要后续处理直接返回。
	 */
	@Override
	protected boolean onAccessDenied(ServletRequest request, ServletResponse response) throws Exception {
		Subject subject = getSubject(request, response);
		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		String ajaxHeader = httpRequest.getHeader("x-requested-with");
		if (!subject.isAuthenticated() && ajaxHeader != null && ajaxHeader.equalsIgnoreCase("XMLHttpRequest")) {
			/**
			  * 当前请求为AJAX请求，但会话已失效
			 */
			// 保存请求
			saveRequest(request);
			// 设置响应头
			httpResponse.setStatus(HttpStatus.UNAUTHORIZED.value());
			httpResponse.setContentType(MediaType.APPLICATION_JSON_VALUE);
			httpResponse.setHeader("Cache-Control", "no-cache, must-revalidate");
			// 响应信息
			httpResponse.getWriter().print(JSONObject.toJSON("会话已失效"));
			httpResponse.getWriter().close();
			return false;
		}
		return true;
	}
}
