package com.platform.system.role.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.platform.page.PageModel;
import com.platform.system.permission.model.SysPermission;
import com.platform.system.permission.service.SysPermissionService;
import com.platform.system.resource.model.SysResource;
import com.platform.system.resource.service.SysResourceService;
import com.platform.system.role.model.SysRole;
import com.platform.system.role.model.SysRolePermission;
import com.platform.system.role.service.SysRolePermissionService;
import com.platform.system.role.service.SysRoleService;
import com.platform.system.user.model.SysUser;
import com.platform.system.user.model.SysUserRole;
import com.platform.system.user.service.SysUserRoleService;
import com.platform.system.user.service.SysUserService;

@Controller
@RequestMapping("api/v1/role")
public class SysRoleController extends BaseController{
	
	@Autowired
	private SysRoleService roleService;

	@Autowired
	private SysResourceService resourceService;
	
	@Autowired
	private SysPermissionService permissionService;
	
	@Autowired
	private SysRolePermissionService rolePermissionService;
	
	@Autowired
	private SysUserService userService;
	
	@Autowired
    private SysUserRoleService userRoleService;
	
	@RequiresPermissions("role:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysRole role, Model model) {
		PageModel<SysRole> page = roleService.selectByPage(role);
		model.addAttribute("page", page);
		model.addAttribute("role", role);
        return "platform/role/list";
	}
	
	@RequiresPermissions("role:view")
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) {
		SysRole role = new SysRole();
		//角色所拥有的权限
		Map<Integer, Object> rolePermissionMap = new HashMap<Integer, Object>();
		Map<Integer, Object> userMap = new HashMap<Integer, Object>();
		if(id != 0){
			role = roleService.selectById(id);
			//角色所拥有的权限
			SysRolePermission rp = new SysRolePermission();
			rp.setRoleId(id);
			List<SysRolePermission> listRolePermission = rolePermissionService.selectAll(rp);
			for (SysRolePermission sysRolePermission : listRolePermission) {
				rolePermissionMap.put(sysRolePermission.getPermissionId(), sysRolePermission);
			}
			//角色下面的用户
			SysUserRole searchUser = new SysUserRole();
	        searchUser.setRoleId(id);
	        List<SysUserRole> userList = userRoleService.selectAll(searchUser);
			for (SysUserRole userRole : userList) {
				userMap.put(userRole.getUserId(), userRole);
			}
		}
		//所有用户
		role.setUserList(userService.selectByProperties(new SysUser()));
		//资源权限
		role.setPermissionList(permissionService.selectByProperties(new SysPermission()));
		//资源
		List<SysResource> listSysResource = resourceService.selectByProperties(new SysResource());
		model.addAttribute("role", role);
		model.addAttribute("listSysResource", listSysResource);
		model.addAttribute("rolePermissionMap", rolePermissionMap);
		model.addAttribute("userMap", userMap);
		return "platform/role/save";
	}
	
	@RequestMapping(value = "unique", method = RequestMethod.GET)
	public @ResponseBody Boolean unique(SysRole searchVo) {
		List<SysRole> list = roleService.selectByUnique(searchVo);
		if (list != null && list.size() > 0) {
			for (SysRole role : list) {
				if (searchVo.getId() == null || searchVo.getId().intValue() != role.getId().intValue()) {
					return false;
				}
			}
		}
		return true;
	}
	
	@RequiresPermissions("role:view")
	@RequestMapping(value = "all", method = RequestMethod.GET)
	public @ResponseBody Result<List<SysRole>> all(SysRole searchVo) {
		List<SysRole> list = roleService.selectByProperties(searchVo);
		return new ResultBuilder<List<SysRole>>().data(list).build();
	}
	
	@RequiresPermissions("role:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysRole role, Model model){
		roleService.saveRole(role);
		return "redirect:/api/v1/role";
	}
	
	@RequiresPermissions("role:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysRole role,Model model){
		roleService.updateRole(role);
		return "redirect:/api/v1/role";
	}
	
	@RequiresPermissions("role:delete")
	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		roleService.deleteRole(id);
		return new ResultBuilder<String>().data("").build();
	}
	
	@RequiresPermissions("role:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysRole sysUser) {
        String ids = sysUser.getIds();
        for(String id: ids.split(",")) {
            roleService.deleteRole(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
    
}
