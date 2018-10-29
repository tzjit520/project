package com.platform.system.memu.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.system.memu.model.SysMenu;
import com.platform.system.memu.service.SysMenuService;

@Controller
@RequestMapping("api/v1/menu")
public class SysMenuController extends BaseController{
	
	@Autowired
	private SysMenuService menuService;
	
	@RequiresPermissions("menu:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysMenu menu, Model model) {
		List<SysMenu> list = new ArrayList<SysMenu>();
		List<SysMenu> sourcelist = menuService.selectByProperties(menu);
		for (SysMenu sysMenu : sourcelist) {
			if(sysMenu.getParentId() == null){
				list.add(sysMenu);
				SysMenu.sortList(list, sourcelist, sysMenu.getId(), true);
			}
		}
		model.addAttribute("list", list);
		model.addAttribute("menu", menu);
        return "platform/menu/list";
	}
	
	@RequiresPermissions("menu:view")
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Integer parentId, Model model) {
		SysMenu sysMenu = new SysMenu();
		//查询所有菜单
		List<SysMenu> menus = menuService.selectByProperties(new SysMenu());
		//查询除自身外的所有菜单
		if(id != null && id.intValue() != 0){
			sysMenu = menuService.selectById(id);
			//过滤掉自己
			menus = menuService.selectByProperties(new SysMenu(id, -2));
		}else{
			sysMenu.setParentId(parentId);
		}
		// 构建菜单树
		List<SysMenu> rootMenus = new ArrayList<SysMenu>();
		for (SysMenu menu : menus) {
			SysMenu parent = findParent(menus, menu);
			if (parent != null) {
				parent.getChildrenListMenus().add(menu);
			}
		}
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
		List<SysMenu> result = new ArrayList<SysMenu>();
		// 遍历菜单树，生成返回的List，根据菜单的depth对菜单名称进行添加空格处理
		// 先进行排序 
		Collections.sort(rootMenus);
		for (SysMenu menu: rootMenus) {			
			constuctMenus(result, menu);
		}
		model.addAttribute("result", result);
		model.addAttribute("menu", sysMenu);
		return "platform/menu/save";
	}
	
	/**
	 * 找到某个菜单的父节点
	 * @param
	 * @param menu
	 */
	private SysMenu findParent(List<SysMenu> menus, SysMenu menu) {
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
	private void constuctMenuDepth(SysMenu menu, List<SysMenu> menus) {
		if (menu.getParentId() == null) {
			menu.setDepth(1);
		} else {
			SysMenu parentMenu = this.findParent(menus, menu);
			menu.setDepth(parentMenu.getDepth() + 1);
		}
		for (SysMenu childMenu: menu.getChildrenListMenus()) {			
			constuctMenuDepth(childMenu, menus);
		}
	}
	
	/**
	 * 构建菜单列表，菜单的名称体现了菜单的层级关系(通过空格)
	 * @param result
	 * @param menu
	 */
	private void constuctMenus(List<SysMenu> result, SysMenu menu) {
		int blankCount = menu.getDepth()-1;
		String blankStr = "";
		for (int i=0; i<blankCount; i++) {
			blankStr = blankStr + "----";
		}
		menu.setName(blankStr + menu.getName());
		result.add(menu);
		Collections.sort(menu.getChildrenListMenus());
		for (SysMenu childMenu: menu.getChildrenListMenus()) {			
			constuctMenus(result, childMenu);
		}
	}
	
	@RequestMapping(value = "unique", method = RequestMethod.GET)
	public @ResponseBody Boolean unique(SysMenu searchVo) {
		List<SysMenu> list = menuService.selectByUnique(searchVo);
		if (list != null && list.size() > 0) {
			for (SysMenu menu : list) {
				if (searchVo.getId() == null || searchVo.getId().intValue() != menu.getId().intValue()) {
					return false;
				}
			}
		}
		return true;
	}
	
	@RequiresPermissions("menu:view")
	@RequestMapping(value = "all", method = RequestMethod.GET)
	public @ResponseBody Result<List<SysMenu>> all(SysMenu searchVo) {
		List<SysMenu> list = menuService.selectByProperties(searchVo);
		return new ResultBuilder<List<SysMenu>>().data(list).build();
	}
	
	@RequiresPermissions("menu:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysMenu menu, Model model){
		menuService.save(menu);
		return "redirect:/api/v1/menu";
	}
	
	@RequiresPermissions("menu:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysMenu menu,Model model){
		menuService.updateNotNull(menu);
		return "redirect:/api/v1/menu";
	}
	
	@RequiresPermissions("menu:delete")
	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		menuService.deletMenu(id);
		return new ResultBuilder<String>().data("").build();
	}
	
	@RequiresPermissions("menu:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysMenu sysUser) {
        String ids = sysUser.getIds();
        for(String id: ids.split(",")) {
            menuService.deletMenu(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
    
}
