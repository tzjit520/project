package com.platform.system.session.service;

import java.net.InetAddress;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.support.DefaultSubjectContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.platform.common.constants.SessionConstants;
import com.platform.shiro.KickoutControlFilter;

@Service
public class SessionService{
	
	@Autowired
	protected SessionDAO sessionDAO;
	
	@Autowired
	private KickoutControlFilter kickoutControlFilter;
	
	/**
	 * 获取符合条件的session
	 */
	public List<Map<String, Object>> getActiveSessions(String keyword) {
		List<Map<String, Object>> resultList = new ArrayList<Map<String, Object>>();
		// 获取所有活动的Session
		List<Session> sessionList = new ArrayList<Session>();
		sessionList.addAll(sessionDAO.getActiveSessions());
		Collections.sort(sessionList, new Comparator<Session>(){
			@Override
			public int compare(Session s1, Session s2) {
				// 按session创建时间倒序排序
				return (s2.getStartTimestamp().compareTo(s1.getStartTimestamp()));
			}
		});
		// 获取允许同一用户同时登录的会话数
		int maxSession = kickoutControlFilter.getMaxSession();
		// 已成功登录的用户名
		Set<String> loginedUserSets = new HashSet<String>();
		for (Session session : sessionList) {
			// 若已登录，则session中会记录登录用户名
			SimplePrincipalCollection principalSet = (SimplePrincipalCollection) session.getAttribute(DefaultSubjectContext.PRINCIPALS_SESSION_KEY);
			if (principalSet == null || session.getAttribute(SessionConstants.SESSION_FORCE_LOGOUT_KEY) != null) {
				// 过滤掉尚未登录成功的session和已被标记为强制下线的session
				continue;
			}
			String userCode = (String) principalSet.getPrimaryPrincipal();
			if (maxSession == 1) {
				// 只有maxSession为1时，才能判定先登录的session为无效；若maxSession大于1，则不能做此推断
				if (!loginedUserSets.contains(userCode)) {
					loginedUserSets.add(userCode);
				} else {
					// 用户直接关闭浏览器而未清除的session
					sessionDAO.delete(session);
					continue;
				}
			}
			// 根据查询条件进行过滤（匹配登录名或IP）
			String ipAddress = session.getHost();
	        if (ipAddress != null && ipAddress.contains(":1")) {
	            try {
	            	InetAddress inet = InetAddress.getLocalHost();
	                ipAddress = inet.getHostAddress();
	            } catch (Exception e) {
	            }
	        }
			if (keyword != null && !keyword.isEmpty()) {
				if (userCode.indexOf(keyword) == -1 && ipAddress.indexOf(keyword) == -1) {
					continue;
				}
			}
			// 用户名、登录IP、会话ID、会话开始时间、最后访问时间
			Map<String, Object> retMap = new HashMap<String, Object>();
			retMap.put("loginName", userCode);
			retMap.put("loginIP", ipAddress);
			retMap.put("sessionID", session.getId());
			retMap.put("sessionStartTime", session.getStartTimestamp());
			retMap.put("sessionLastAccessTime", session.getLastAccessTime());
			resultList.add(retMap);
		}
		loginedUserSets.clear();
		return resultList;
	}
}
