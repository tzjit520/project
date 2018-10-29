package com.platform.shiro;

import java.io.Serializable;
import java.util.Deque;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.SessionListenerAdapter;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 监控会话过期、会话终止事件，并从缓存中清除无效的会话
 */
public class UserSessionListener extends SessionListenerAdapter
{
	Logger logger = LoggerFactory.getLogger(UserSessionListener.class);
	
	private static Cache<String, Deque<Serializable>> cache;
	
	public UserSessionListener(CacheManager cacheManager) {
		if (cache == null) {
    		// 在shiro-ehcache.xml中配置的缓存名字
        	cache = cacheManager.getCache("kickout-sessionIdCache");
        }
	}
	
	/**
	 * 会话过期或失效时清除"踢出用户缓存"
	 */
	private void removeSessionFromCache(Session session, String userCode) {
		if (userCode != null && cache != null) {
			synchronized (cache) {
				Deque<Serializable> deque = cache.get(userCode);
				if (deque != null) {
					deque.remove(session.getId());
		        }
			}
		}
    }
	
	@Override
	public void onStart(Session session) {
		this.logger.info("会话创建：" + session.getId());
	}
	
	@Override
	public void onExpiration(Session session) {
		SimplePrincipalCollection principalSet = (SimplePrincipalCollection) session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
		String userCode = "";
		if (principalSet != null) {
			userCode = (String) principalSet.getPrimaryPrincipal();
		}
		this.logger.info(userCode + "会话过期：" + session.getId());
		this.removeSessionFromCache(session, userCode);
	}

	@Override
	public void onStop(Session session) {
		SimplePrincipalCollection principalSet = (SimplePrincipalCollection) session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
		String userCode = "";
		if (principalSet != null) {
			userCode = (String) principalSet.getPrimaryPrincipal();
		}
		this.logger.info(userCode + "会话终止：" + session.getId());
		this.removeSessionFromCache(session, userCode);
	}
}
