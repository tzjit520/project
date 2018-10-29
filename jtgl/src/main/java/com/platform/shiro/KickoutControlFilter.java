package com.platform.shiro;

import java.io.Serializable;
import java.util.Deque;
import java.util.LinkedList;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.AccessControlFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;

import com.alibaba.fastjson.JSON;
import com.platform.common.constants.SessionConstants;

/**
 * 用于完成踢出用户的功能
 */
public class KickoutControlFilter extends AccessControlFilter {
	
	Logger logger = LoggerFactory.getLogger(KickoutControlFilter.class);

	// 同一个帐号的最大会话数
    private int maxSession = 1;
	// 默认踢出之前登录的用户
    private boolean kickoutAfter = false;
    
	private SessionDAO sessionDAO;
	
	private static Cache<String, Deque<Serializable>> cache;

    public KickoutControlFilter(SessionDAO sessionDAO, CacheManager cacheManager) {
    	this.sessionDAO = sessionDAO;
    	if (cache == null) {
    		// 在shiro-ehcache.xml中配置的缓存名字
        	cache = cacheManager.getCache("kickout-sessionIdCache");
        }
    }

	public void setKickoutAfter(boolean kickoutAfter) {
		this.kickoutAfter = kickoutAfter;
	}

	public int getMaxSession() {
		return maxSession;
	}
	
	public void setMaxSession(int maxSession) {
		this.maxSession = maxSession;
	}

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
		if (!subject.isAuthenticated()){
        	// 如果没有登录，直接进行之后的流程
        	return true;
        }
        Session currSession = subject.getSession();
        Serializable currSessionId = currSession.getId();
        String userCode = (String) subject.getPrincipal();
        // 同步控制
        synchronized (cache) {
        	// 保存用户会话ID的队列
	        Deque<Serializable> deque = cache.get(userCode);
	        if (deque == null) {
	        	deque = new LinkedList<Serializable>();
	        	cache.put(userCode, deque);
	        }
	        // 如果队列里没有此sessionId，且用户没有被踢出，则将之加入队列尾部
	        if (!deque.contains(currSessionId) && currSession.getAttribute(SessionConstants.SESSION_KICKOUT_KEY) == null) {
	        	deque.add(currSessionId);
	        }
	        // 如果队列里的sessionId数超出最大会话数，开始踢人
	        while (deque.size() > maxSession) {
	        	Serializable kickoutSessionId = null;
	        	if (kickoutAfter) {
	        		// 踢出最后登录的用户
	        		kickoutSessionId = deque.pollLast();
	        	} else {
	        		// 踢出最早登录的用户
	        		kickoutSessionId = deque.pollFirst();
	        	}
	        	// 获取要踢出的session
	        	try {
	        		Session kickoutSession = sessionDAO.readSession(kickoutSessionId);
	        		if (kickoutSession != null) {
	        			// 若不需要提示用户，则可以直接删除session
	        			//sessionDAO.delete(kickoutSession);
	        			// 若需要提示用户，则设置session的kickout属性表示被踢出了
	        			kickoutSession.setAttribute(SessionConstants.SESSION_KICKOUT_KEY, true);
	        		}
	        	} catch (Exception e) {
	        	}
	        }
        }
        // 检查当前session中的kickout属性，如果被踢出了则退出并重定向到踢出后的地址
        if (currSession.getAttribute(SessionConstants.SESSION_KICKOUT_KEY) != null) {
        	// 先注销登录，销毁当前session
       		subject.logout();
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
    			httpResponse.getWriter().print(JSON.toJSON("您的帐号已在其他地方登录"));
				httpResponse.getWriter().close();
    		} else {
    			// 若非AJAX请求，则返回JavaScript脚本提示用户并转向登录界面
    			String contextPath = request.getServletContext().getContextPath();
    			String loginUrl = this.getLoginUrl();
    			StringBuffer respBuf = new StringBuffer();
    			respBuf.append("<script>");
    			respBuf.append("alert('您的帐号已在其他地方登录');");
    			respBuf.append("top.location.replace('").append(contextPath.concat(loginUrl)).append("')");
    			respBuf.append("</script>");
    			httpResponse.setStatus(HttpStatus.UNAUTHORIZED.value());
    			httpResponse.setContentType(MediaType.TEXT_HTML_VALUE);
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
