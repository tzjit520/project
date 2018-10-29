package com.platform.shiro;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import com.platform.common.constants.StatusCode;
import com.platform.system.permission.model.SysPermission;
import com.platform.system.role.model.SysRole;
import com.platform.system.user.model.SysUser;
import com.platform.system.user.service.SysUserService;
import com.platform.utils.EncoderUtil;

public class SysRealm extends AuthorizingRealm{

	@Override
	public void setName(String name) {
		super.setName("sysRealm");
	}

	@Autowired
	private SysUserService userService;
	
	/**
	 * 身份验证
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken authcToken) throws AuthenticationException {
			
		// 获取基于用户名和密码的令牌
		// 实际上这个authcToken是从AccessController里面SecurityUtils.getSubject().login(token)传过来的
		// 两个token的引用都是一样的
		UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
		// token是用户输入的用户名和密码
        // 第一步从token中取出用户名
		//System.out.println("<-- 系统用户 -->验证当前Subject时获取到token为" + ReflectionToStringBuilder.toString(token,ToStringStyle.MULTI_LINE_STYLE));
        String code = (String) token.getPrincipal();
        if(StringUtils.isBlank(code)){
        	throw new IncorrectCredentialsException();
        }
		//验证后台用户登录
		// 第二步：根据用户输入的userCode从数据库查询
		List<SysUser> list = userService.selectByProperties(new SysUser(code, null));
		if (list != null && list.size() > 0) {
			//获取数据库用户信息
			SysUser sysUser = list.get(0);
			if(sysUser.getStatus().intValue()== StatusCode.COMMON_STATUS_LOCK) {
				throw new LockedAccountException();
			}
			//盐值
			ByteSource salt = ByteSource.Util.bytes(sysUser.getCode());

			//弄一个新user对象   过滤掉没用的信息
			/*SysUser user = new SysUser();
			user.setId(sysUser.getId());
			user.setCode(sysUser.getCode());
			user.setName(sysUser.getName());
			user.setHeadimgurl(sysUser.getHeadimgurl());*/
			
			return new SimpleAuthenticationInfo(sysUser.getCode(), sysUser.getPassword(), salt, getName());
		} else {
			throw new IncorrectCredentialsException();
		}
	}

	/**
	 * 授权
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
		
		//System.out.println("登录之后,做任何操作-先取得角色权限<为系统用户授权>......");
		//从 principals获取主身份信息
        //将getPrimaryPrincipal方法返回值转为真实身份类型（在上边的doGetAuthenticationInfo认证通过填充到SimpleAuthenticationInfo中身份类型），
        String code =  (String) principals.getPrimaryPrincipal();
        //查询权限
        List<SysUser> list = userService.selectUserByAuth(new SysUser(code, null));
        if(list == null || list.size() <= 0){
        	return null;
        }
        SysUser sysUser = list.get(0);
        //单独定一个角色集合对象
        List<String> roles = new ArrayList<String>();
        //单独定一个权限集合对象
        List<String> permissions = new ArrayList<String>();
    	//获取用户所拥有的权限
    	List<SysPermission> listPermission = sysUser.getPermissionList();
    	for (SysPermission permission : listPermission) {
    		permissions.add(permission.getPermission());
    	}
    	//获取角色
    	List<SysRole> listRole = sysUser.getRoleList();
    	for (SysRole sysRole : listRole) {
    		roles.add(sysRole.getCode());
    	}
    	//查到权限数据，返回授权信息(要包括 上边的permissions)
    	SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
    	//System.out.println("-----开始用户[" + sysUser.getName() + "]授权-------");
    	//将上边查询到角色信息填充到simpleAuthorizationInfo对象中
    	simpleAuthorizationInfo.addRoles(roles);
    	//将上边查询到授权信息填充到simpleAuthorizationInfo对象中
    	simpleAuthorizationInfo.addStringPermissions(permissions);
    	//System.out.println("-----结束用户[" + sysUser.getName() + "]授权-------");
    	// 若该方法什么都不做直接返回null的话,就会导致任何用户访问时都会自动跳转到unauthorizedUrl指定的地址
    	// 详见applicationContext.xml中的<bean id="shiroFilter">的配置
    	return simpleAuthorizationInfo;
        
	}
	
	//清除缓存
    public void clearCached() {
        PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
        super.clearCache(principals);
    }
    
    public static void main(String[] args) {
    	//MD5加密
		String encodeCharterMD5 = EncoderUtil.getEncodeCharter("MD5", "admin", ByteSource.Util.bytes("admin"), 2);
		System.out.println(encodeCharterMD5);
		//SHA-1加密
		String encodeCharterSHA = EncoderUtil.getEncodeCharter("SHA-1", "admin", ByteSource.Util.bytes("admin"), 2);
		System.out.println(encodeCharterSHA);
	}
}
