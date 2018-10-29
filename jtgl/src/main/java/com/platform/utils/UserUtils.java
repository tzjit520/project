/**
 * Copyright &copy; 2012-2014 <a href="https://github.com/thinkgem/jeesite">JeeSite</a> All rights reserved.
 */
package com.platform.utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.InvalidSessionException;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;

import com.platform.system.memu.model.SysMenu;
import com.platform.system.memu.service.SysMenuService;
import com.platform.system.role.model.SysRole;
import com.platform.system.user.model.SysUser;
import com.platform.system.user.service.SysUserService;

/**
 * 用户工具类
 */
public class UserUtils {

	private static SysUserService userService = (SysUserService) SpringUtil.getBean("sysUserService");
	private static SysMenuService menuService = (SysMenuService) SpringUtil.getBean("sysMenuService");

	public static final String USER_CACHE = "userCache";
	public static final String USER_CACHE_ID_ = "id_";
	public static final String USER_CACHE_LOGIN_NAME_ = "ln_";

	public static final String CACHE_ROLE_LIST = "roleList";
	public static final String CACHE_MENU_LIST = "menuList";

	/**
	 * 根据ID获取用户
	 * @param id
	 * @return 取不到返回null
	 */
	public static SysUser getUserById(Integer id){
		SysUser sysUser = (SysUser) CacheUtils.get(USER_CACHE, USER_CACHE_ID_ + id);
		if (sysUser ==  null){
			sysUser = userService.selectById(id);
			if (sysUser == null){
				return null;
			}
			//查询用户包括角色和权限
			List<SysUser> listUser = userService.selectUserByAuth(sysUser);
			if (listUser == null || listUser.size() <= 0){
				return null;
			}
			sysUser = listUser.get(0);
			CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + sysUser.getId(), sysUser);
		}
		return sysUser;
	}
	
	/**
	 * 根据登录名获取用户
	 * @param code
	 * @return 取不到返回null
	 */
	public static SysUser getUserByCode(String code){
		SysUser sysUser = (SysUser)CacheUtils.get(USER_CACHE, USER_CACHE_LOGIN_NAME_ + code);
		if (sysUser == null){
			List<SysUser> listUser = userService.selectUserByAuth(new SysUser(code, null));
			if (listUser == null || listUser.size() <= 0){
				return null;
			}
			sysUser = listUser.get(0);
			CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + sysUser.getId(), sysUser);
			CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + sysUser.getCode(), sysUser);
		}
		return sysUser;
	}
	
	/**
	 * 清除当前用户缓存
	 */
	public static void clearCache(){
		removeCache(CACHE_ROLE_LIST);
		removeCache(CACHE_MENU_LIST);
		UserUtils.clearCache(getUser());
	}
	
	/**
	 * 清除指定用户缓存
	 * @param user
	 */
	public static void clearCache(SysUser user){
		CacheUtils.remove(USER_CACHE, USER_CACHE_ID_ + user.getId());
		CacheUtils.remove(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getCode());
	}
	
	/**
	 * PUT指定用户缓存
	 * @param user
	 */
	public static void putUserCache(SysUser user){
		CacheUtils.put(USER_CACHE, USER_CACHE_ID_ + user.getId(), user);
		CacheUtils.put(USER_CACHE, USER_CACHE_LOGIN_NAME_ + user.getCode(), user);
	}
	
	/**
	 * 获取当前用户
	 */
	public static SysUser getUser(){
		String code = (String) getSubject().getPrincipal();
		return getUserByCode(code);
	}

	/**
	 * 获取当前用户角色列表
	 * @return
	 */
	public static List<SysRole> getRoleList(){
		SysUser user = getUser();
		List<SysRole> roleList = user.getRoleList();
		if (roleList != null){
			putCache(CACHE_ROLE_LIST, roleList);
		}
		return roleList;
	}
	
	/**
	 * 获取当前用户授权菜单
	 * @return
	 */
	public static Set<SysMenu> getMenus(){
		@SuppressWarnings("unchecked")
		Set<SysMenu> menuSet = (Set<SysMenu>)getCache(CACHE_MENU_LIST);
		if (menuSet == null){
			menuSet = format(new SysMenu());
			putCache(CACHE_MENU_LIST, menuSet);
		}
		return menuSet;
	}

	//获取菜单
	private static Set<SysMenu> format(SysMenu searchVo){
		List<SysMenu> menus = menuService.selectByProperties(searchVo);
		// 构建菜单树
		for (SysMenu menu : menus) {
			SysMenu parent = findParent(menus, menu);
			if (parent != null) {
				parent.getChildrenListMenus().add(menu);
			}
		}
		List<SysMenu> rootMenus = new ArrayList<SysMenu>();
		// 只找到根节点的菜单，将其加入rootMenus
		for (SysMenu menu : menus) {
			if (menu.getParentId() == null) {
				rootMenus.add(menu);
			}
		}
		// 设定每个菜单的深度
		for (SysMenu rootMenu : rootMenus) {
			constuctMenuDepth(rootMenu, menus);
		}

		// 根据菜单深度和sort对菜单进行排序，优先将菜单深度大的排在前面
		Collections.sort(menus, new Comparator<SysMenu>() {
			@Override
			public int compare(SysMenu o1, SysMenu o2) {
				if (o1.getDepth().intValue() == o2.getDepth().intValue()) {
					return o1.getSort().intValue() - o2.getSort().intValue();
				} else {
					return o1.getDepth().intValue() - o2.getDepth().intValue();
				}
			}
		});

		Set<SysMenu> permissionSet = new LinkedHashSet<>();

		//循环第一次 将权限插入各自的menu中
		for(SysMenu menu:menus) {
			//如果是顶级菜单直接添加
			if(menu.getParentId()==null) {
				permissionSet.add(menu);
			}
			else {
				//如果不是顶级菜单需要找到parent菜单
				SysMenu parentMenu = findParent(menus, menu);
				// 该行代码与205行的代码区别在于一个将子菜单加入到childrenMenus中，一个将子菜单加入到childrenListMenus中，后续该部分代码需重构
				parentMenu.getChildrenMenus().add(menu);
				//每次添加到父菜单的时候 重新计算父菜单的权限
				setPermission(parentMenu,menus);
			}
		}

		//判断各自的menu 将没有权限的menu的以及子menu去掉
		Subject subject = SecurityUtils.getSubject();
		Iterator<SysMenu> it = menus.iterator();
		while (it.hasNext()) {
			SysMenu menu = it.next();
			menu.getChildrenMenus().clear();
			if(!checkPermissionMenu(subject,menu)) {
				it.remove();
			}
		}

		//再次循环menu 添加有权限的menu形成最终菜单
		Set<SysMenu> returnSet = new LinkedHashSet<>();
		for(SysMenu menu:menus) {
			if(menu.getParentId()==null) {
				returnSet.add(menu);
			}
			else {
				SysMenu parentMenu = findParent(menus, menu);
				parentMenu.getChildrenMenus().add(menu);
			}
		}
		return returnSet;
	}

	/**
	 * 对菜单设置权限，以逗号分隔(包括子菜单)
	 */
	private static void setPermission(SysMenu menu,List<SysMenu> menus) {
		Set<String> permissions = new HashSet<String>();
		//添加自己的权限 （这块可以忽略  父菜单可以忽略自己的权限 如果要计算 他和子菜单的权限应该是and关系而不是or）
		if(menu.getPermission()!=null&&menu.getPermission().length()>0) {
			permissions.add(menu.getPermission());
		}
		if(menu.getChildrenMenus().size()>0) {
			//添加子菜单权限
			for(SysMenu childMenu:menu.getChildrenMenus()) {
				if(childMenu.getPermission()!=null&&childMenu.getPermission().length()>0) {
					permissions.add(childMenu.getPermission());
				}
				else {
					//子菜单没有配置权限，并且该节点菜单没有子菜单，父菜单必须显示 配置一个any权限
					if(childMenu.getChildrenMenus().size()<=0) {
						boolean isFind = false;
						for(SysMenu findMenu:menus) {
							if(findMenu.getParentId()!=null&&findMenu.getParentId().longValue()==childMenu.getId().longValue()) {
								isFind = true;
							}
						}
						if(!isFind) {
							permissions.add("any");
						}
					}
				}
			}
		}
		//格式化权限以逗号隔开
		if(permissions.size()>1) {
			StringBuffer sb = new StringBuffer();
			for(String p:permissions) {
				sb.append(p);
				sb.append(",");
			}
			menu.setPermission(sb.toString());
		}
		else {
			if(permissions.size()>0) {
				menu.setPermission(permissions.iterator().next());
			}
		}
	}
	
	private static boolean checkPermissionMenu(Subject subject,SysMenu menu) {
		String permissions = menu.getPermission();
		if(permissions!=null&&permissions.length()>0) {
			//如果菜单含有any，就代表不需要权限鉴权
			if(permissions.contains("any")) {
				return true;
			}
			String[] permissonsArray = permissions.split(",");
			boolean hasPermission = false;

			for(String permission:permissonsArray) {
				if(permission!=null&&permission.length()>0) {
					//保证自身权限必须通过
					if(subject.isPermitted(permission))  {
						hasPermission = true;
					}
				}
			}
			return hasPermission;
		}
		else {
			return true;
		}

	}
	
	/**
	 * 找到某个菜单的父节点
	 * @param
	 * @param menu
	 */
	private static SysMenu findParent(List<SysMenu> menus, SysMenu menu) {
		if (menu.getParentId() == null) {
			return null;
		} else {
			for (SysMenu tempMenu : menus) {
				if (menu.getParentId().intValue() == tempMenu.getId().intValue()) {
					return tempMenu;
				}
			}
		}
		return null;
	}
	
	/**
	 * 设置菜单的深度
	 * @param menu
	 * @param menus
	 */
	private static void constuctMenuDepth(SysMenu menu, List<SysMenu> menus) {
		if (menu.getParentId() == null) {
			menu.setDepth(1);
		} else {
			SysMenu parentMenu = findParent(menus, menu);
			menu.setDepth(parentMenu.getDepth() + 1);
		}
		for (SysMenu childMenu: menu.getChildrenListMenus()) {			
			constuctMenuDepth(childMenu, menus);
		}
	}
	
	/**
	 * 获取授权主要对象
	 */
	public static Subject getSubject(){
		return SecurityUtils.getSubject();
	}

	public static Session getSession(){
		try{
			Subject subject = getSubject();
			Session session = subject.getSession(false);
			if (session == null){
				session = subject.getSession();
			}
			if (session != null){
				return session;
			}
//			subject.logout();
		}catch (InvalidSessionException e){
			
		}
		return null;
	}
	
	// ============== User Cache ==============
	
	public static Object getCache(String key) {
		return getCache(key, null);
	}
	
	public static Object getCache(String key, Object defaultValue) {
//		Object obj = getCacheMap().get(key);
		Object obj = getSession().getAttribute(key);
		return obj==null?defaultValue:obj;
	}

	public static void putCache(String key, Object value) {
//		getCacheMap().put(key, value);
		getSession().setAttribute(key, value);
	}

	public static void removeCache(String key) {
//		getCacheMap().remove(key);
		getSession().removeAttribute(key);
	}
	
//	public static Map<String, Object> getCacheMap(){
//		Principal principal = getPrincipal();
//		if(principal!=null){
//			return principal.getCacheMap();
//		}
//		return new HashMap<String, Object>();
//	}
	
}
