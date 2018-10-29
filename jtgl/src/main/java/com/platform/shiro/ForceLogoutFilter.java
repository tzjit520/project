package com.platform.shiro;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.session.Session;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;

import com.alibaba.fastjson.JSON;
import com.platform.common.constants.SessionConstants;

/**
 * 在用户被强制下线后进行提示并跳转
 */
public class ForceLogoutFilter extends AccessControlFilter
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
		Session session = getSubject(request, response).getSession(false);
		if (session == null) {
        	return true;
		}
		if (session.getAttribute(SessionConstants.SESSION_FORCE_LOGOUT_KEY) != null) {
			// 先注销登录，销毁当前session
			getSubject(request, response).logout();
			// 再保存当前请求（会保存到新的session中），若登录成功后再重定向到该请求
       		saveRequest(request);
	   		// 提示用户并跳转到登录界面
       		HttpServletRequest httpRequest = (HttpServletRequest) request;
       		HttpServletResponse httpResponse = (HttpServletResponse) response;
       		String ajaxHeader = httpRequest.getHeader("x-requested-with");
    		if (ajaxHeader != null && ajaxHeader.equalsIgnoreCase("XMLHttpRequest")) {
    			// 若为AJAX请求，则返回JSON格式的提示用户并转向登录界面
    			httpResponse.setStatus(HttpStatus.UNAUTHORIZED.value());
    			httpResponse.setContentType(MediaType.APPLICATION_JSON_VALUE);
    			httpResponse.setHeader("Cache-Control", "no-cache, must-revalidate");
    			httpResponse.getWriter().print(JSON.toJSON("您已被管理员强制下线"));
				httpResponse.getWriter().close();
    		} else {
    			// 若非AJAX请求，则返回JavaScript脚本提示用户并转向登录界面
    			String contextPath = request.getServletContext().getContextPath();
    			String loginUrl = this.getLoginUrl();
    			StringBuffer respBuf = new StringBuffer();
    			respBuf.append("<script>");
    			respBuf.append("alert('您已被管理员强制下线');");
    			respBuf.append("top.location.replace('").append(contextPath.concat(loginUrl)).append("')");
    			respBuf.append("</script>");
    			httpResponse.setStatus(HttpStatus.UNAUTHORIZED.value());
    			httpResponse.setContentType(MediaType.TEXT_HTML_VALUE+";charset=UTF-8");
    			httpResponse.setHeader("Cache-Control", "no-cache, must-revalidate");
    			httpResponse.getWriter().print(respBuf.toString());
				httpResponse.getWriter().close();
    		}
	    	// 该拦截器已处理，不再需要后续拦截器处理
	    	return false;
		}
		return true;
	}
}
