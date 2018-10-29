package com.platform.system.user.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;
import com.platform.system.role.model.SysRolePermission;
import com.platform.system.role.service.SysRolePermissionService;

@RestController
@RequestMapping("/api/v1/user/role")
public class SysUserRoleController extends BaseController {

	@Autowired
	private SysRolePermissionService rolePermissionService;
	
	@RequiresPermissions("user:view")
	@RequestMapping(method = RequestMethod.GET)
	public Result<PageModel<SysRolePermission>> findByPage(SysRolePermission searchVo) throws Exception {
		PageModel<SysRolePermission> rolePage = rolePermissionService.selectByPage(searchVo);
		return new ResultBuilder<PageModel<SysRolePermission>>().data(rolePage).build();
	}
	
	@RequiresPermissions("user:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<SysRolePermission>> findAll(SysRolePermission searchVo) throws Exception {
		List<SysRolePermission> rolePage = rolePermissionService.selectAll(searchVo);
		return new ResultBuilder<List<SysRolePermission>>().data(rolePage).build();
	}
	
}
