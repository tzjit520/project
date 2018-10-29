package com.platform.system.permission.controller;

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
import com.platform.system.operation.model.SysOperation;
import com.platform.system.operation.service.SysOperationService;
import com.platform.system.permission.model.SysPermission;
import com.platform.system.permission.service.SysPermissionService;
import com.platform.system.resource.model.SysResource;
import com.platform.system.resource.service.SysResourceService;

@Controller
@RequestMapping("api/v1/permission")
public class SysPermissionController extends BaseController{
	
	@Autowired
	private SysPermissionService permissionService;

	@Autowired
	private SysResourceService resourceService;
	
	@Autowired
	private SysOperationService operationService;
	
	@RequiresPermissions("permission:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysPermission permission, Model model) {
		PageModel<SysPermission> page = permissionService.selectByPage(permission);
		model.addAttribute("page", page);
		model.addAttribute("permission", permission);
        return "platform/permission/list";
	}
	
	@RequiresPermissions("permission:view")
	@RequestMapping(value="view", method = RequestMethod.GET)
	public String findByPageView(SysPermission permission, Model model) {
		permission.setOperationName("查看");
		List<SysPermission> list = permissionService.selectByProperties(permission);
		String[] pers = permission.getPermission().split(",");
		Map<String, String> mapPer = new HashMap<String, String>();
		for (int i = 0; i < pers.length; i++) {
			mapPer.put(pers[i], pers[i]);
		}
		model.addAttribute("list", list);
		model.addAttribute("permission", permission);
		model.addAttribute("mapPer", mapPer);
        return "platform/permission/view";
	}
	
	@RequiresPermissions("permission:view")
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) {
		SysPermission permission = new SysPermission();
		if(id != 0){
			permission = permissionService.selectById(id);
		}
		//资源
		List<SysResource> listResource = resourceService.selectByProperties(new SysResource());
		//操作
		List<SysOperation> listOperation = operationService.selectByProperties(new SysOperation());
		model.addAttribute("listResource", listResource);
		model.addAttribute("listOperation", listOperation);
		model.addAttribute("permission", permission);
		return "platform/permission/save";
	}
	
	@RequestMapping(value = "unique", method = RequestMethod.GET)
	public @ResponseBody Boolean unique(SysPermission searchVo) {
		List<SysPermission> list = permissionService.selectByUnique(searchVo);
		if (list != null && list.size() > 0) {
			for (SysPermission permission : list) {
				if (searchVo.getId() == null || searchVo.getId().intValue() != permission.getId().intValue()) {
					return false;
				}
			}
		}
		return true;
	}
	
	@RequiresPermissions("permission:view")
	@RequestMapping(value = "all", method = RequestMethod.GET)
	public @ResponseBody Result<List<SysPermission>> all(SysPermission searchVo) {
		List<SysPermission> list = permissionService.selectByProperties(searchVo);
		return new ResultBuilder<List<SysPermission>>().data(list).build();
	}
	
	@RequiresPermissions("permission:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysPermission permission, Model model){
		permissionService.save(permission);
		return "redirect:/api/v1/permission";
	}
	
	@RequiresPermissions("permission:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysPermission permission,Model model){
		permissionService.updateNotNull(permission);
		return "redirect:/api/v1/permission";
	}
	
	@RequiresPermissions("permission:delete")
	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		permissionService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}
	
	@RequiresPermissions("permission:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysPermission sysUser) {
        String ids = sysUser.getIds();
        for(String id: ids.split(",")) {
            permissionService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
    
}
