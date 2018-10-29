package com.platform.shiro;

import java.net.InetAddress;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.DisabledAccountException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.mgt.RealmSecurityManager;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;

import com.google.code.kaptcha.Constants;

/**
 * 注意，该类中除authenticate()方法，其他方法需要在登录成功后才可以调用
 */
public class ShiroUtil{
	/**
	 * 认证用户
	 */
	public static void authenticate(String code, String password, String verificationCode) throws Exception {
		if (StringUtils.isBlank(code) || StringUtils.isBlank(password) || StringUtils.isBlank(verificationCode)) {
			throw new Exception("认证信息为空");
		}
		
		/**
		 * 检查验证码
		 */
		String realCode = (String) getSessionAttribute(Constants.KAPTCHA_SESSION_KEY);
		if (!verificationCode.equalsIgnoreCase(realCode)) {
			throw new Exception("验证码错误");
		}
		
		/**
		 * Shiro认证
		 */
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(code, password);
		try {
			subject.login(token);
		}
		catch (LockedAccountException lae) {
			// 账号被锁定
			throw lae;
		}catch (DisabledAccountException dae){
			// 账号已停用
			throw new Exception("账号已停用");
		}catch (UnknownAccountException uae){
			// 无效账号
			throw new Exception("无效的账号");
		}catch (IncorrectCredentialsException ice){
			// 认证失败
			throw new Exception("密码错误");
		}catch (ExcessiveAttemptsException eae){
			// 超过重试次数
			throw new Exception("超过重试次数");
		}catch (AuthenticationException ae){
			// 其他错误
			throw new Exception("认证错误：" + ae.getMessage());
		}
	}
	
	/**
	 * 获取认证主体对象
	 */
	public static Subject getSubject() {
		try {
			return SecurityUtils.getSubject();
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 获取session对象
	 */
	public static Session getSession() {
		return getSubject()!=null ? getSubject().getSession() : null;
	}

	/**
	 * 获取登录用户名
	 */
	public static String getUserCode() {
		return getSubject()!=null ? (String)getSubject().getPrincipal(): null;
	}
	
	/**
	 * 获取客户端IP
	 */
	public static String getLoginIP() {
		String ipAddress = getSession()!=null ? getSession().getHost() : null;
		if (ipAddress != null && ipAddress.contains(":1")) {
            try {
                ipAddress = InetAddress.getLocalHost().getHostAddress();
            } catch (Exception e) { 
            }
        }
		return ipAddress;
	}
	
	/**
	 * 获取session中指定属性值
	 */
	public static Object getSessionAttribute(Object key) {
		return getSession()!=null ? getSession().getAttribute(key) : null;
	}
	
	/**
	 * 在session中保存指定属性
	 */
	public static void setSessionAttribute(Object key, Object value) {
		getSession().setAttribute(key, value);
	}
	
	/**
	 * 使用户退出登录
	 */
	public static void logout() {
		if (getSubject() != null) {
			getSubject().logout();
		}
	}
	
	/**
	 * 清除用户的权限缓存
	 */
	public static void clearAuthorizationInfo(String code) {
		RealmSecurityManager rsm = (RealmSecurityManager) SecurityUtils.getSecurityManager();
		AuthorizingRealm shiroRealm = (AuthorizingRealm) rsm.getRealms().iterator().next();
		Cache<Object, AuthorizationInfo> cache = shiroRealm.getAuthorizationCache();
		if (StringUtils.isNotBlank(code)) {
			// 清除指定用户的权限缓存
			SimplePrincipalCollection principals = new SimplePrincipalCollection(code, shiroRealm.getName());
			cache.remove(principals);
		} else {
			// 清除所有用户的权限缓存
			for (Object key : cache.keys()) {
				cache.remove(key);
			}
		}
	}
}
