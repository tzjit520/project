package com.platform.controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.UnauthorizedException;
import org.apache.shiro.session.Session;
import org.apache.shiro.session.mgt.eis.SessionDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.platform.common.constants.SessionConstants;
import com.platform.dynamic.DynamicDataSource;
import com.platform.shiro.ShiroUtil;


public abstract class BaseController {
	
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	protected SessionDAO sessionDAO;
	
	/**
	 * 清除指定用户的权限缓存
	 */
	protected void clearAuthorizationInfo(String userCode) {
		ShiroUtil.clearAuthorizationInfo(userCode);
	}
	
	/**
	 * 删除指定用户的Session
	 */
	protected void deleteUserSession(List<Integer> userIdList) {
		// 获取当前活动的Session
		Iterator<Session> iterator = sessionDAO.getActiveSessions().iterator();
		while (iterator.hasNext()) {
			// 若存在指定用户的活动Session，则删除
			Session session = iterator.next();
			// TODO:如何优化？
			Integer userId = (Integer) session.getAttribute(SessionConstants.SESSION_USER_ID_KEY);
			if (userId != null && userIdList.contains(userId)) {
				sessionDAO.delete(session);
			}
		}
	}
	
	/**
	 * 全局异常捕获
	 */
	@ExceptionHandler(Exception.class)
	public String bindException(Exception ex, HttpServletRequest request){
		
		logger.error(ex.getMessage(), ex);
		request.setAttribute("ex", ex);
		if(ex instanceof UnauthorizedException){  
			return "error/403";
        }else{
        	return "error/500";
        }
	}

	/**
	 * 设置数据源
	 */
	protected void setDataSource(String dataSourceName){
		
		DynamicDataSource.setDataSource(dataSourceName);
	}
	
	/**
	 * 获取数据源
	 */
	public String getDbName(){
		String dbName = DynamicDataSource.getDataSource();
		if(dbName == null){
			setDataSource("default");
			return "default";
		}
		return dbName;
	}
	
}
