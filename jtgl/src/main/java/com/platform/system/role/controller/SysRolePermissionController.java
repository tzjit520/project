package com.platform.system.role.controller;

import java.util.List;

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
import com.platform.system.role.model.SysRolePermission;
import com.platform.system.role.service.SysRolePermissionService;

@Controller
@RequestMapping("api/v1/rolePermission")
public class SysRolePermissionController extends BaseController{
	
	@Autowired
	private SysRolePermissionService rolePermissionService;

	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysRolePermission rolePermission, Model model) {
		PageModel<SysRolePermission> page = rolePermissionService.selectByPage(rolePermission);
		model.addAttribute("page", page);
		model.addAttribute("rolePermission", rolePermission);
        return "platform/rolePermission/list";
	}
	
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) {
		SysRolePermission rolePermission = new SysRolePermission();
		if(id != 0){
			rolePermission = rolePermissionService.selectById(id);
		}
		model.addAttribute("rolePermission", rolePermission);
		return "platform/rolePermission/save";
	}
	
	@RequestMapping(value = "unique", method = RequestMethod.GET)
	public @ResponseBody Boolean unique(SysRolePermission searchVo) {
		List<SysRolePermission> list = rolePermissionService.selectByUnique(searchVo);
		if (list != null && list.size() > 0) {
			for (SysRolePermission rolePermission : list) {
				if (searchVo.getId() == null || searchVo.getId().intValue() != rolePermission.getId().intValue()) {
					return false;
				}
			}
		}
		return true;
	}
	
	@RequestMapping(value = "all", method = RequestMethod.GET)
	public @ResponseBody Result<List<SysRolePermission>> all(SysRolePermission searchVo) {
		List<SysRolePermission> list = rolePermissionService.selectByProperties(searchVo);
		return new ResultBuilder<List<SysRolePermission>>().data(list).build();
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysRolePermission rolePermission, Model model){
		rolePermissionService.save(rolePermission);
		return "redirect:/api/v1/rolePermission";
	}
	
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysRolePermission rolePermission,Model model){
		rolePermissionService.updateNotNull(rolePermission);
		return "redirect:/api/v1/rolePermission";
	}
	
	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		rolePermissionService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}
	
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysRolePermission sysUser) {
        String ids = sysUser.getIds();
        for(String id: ids.split(",")) {
            rolePermissionService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
    
}
