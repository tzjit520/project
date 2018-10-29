package com.platform.system.resource.controller;

import java.util.ArrayList;
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
import com.platform.page.PageModel;
import com.platform.system.operation.model.SysOperation;
import com.platform.system.permission.model.SysPermission;
import com.platform.system.permission.service.SysPermissionService;
import com.platform.system.resource.model.SysResource;
import com.platform.system.resource.service.SysResourceService;

@Controller
@RequestMapping("api/v1/resource")
public class SysResourceController extends BaseController{
	
	@Autowired
	private SysResourceService resourceService;

	@Autowired
	private SysPermissionService permissionService;
	
	@RequiresPermissions("resource:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysResource resource, Model model) {
		PageModel<SysResource> page = resourceService.selectByPage(resource);
		model.addAttribute("page", page);
		model.addAttribute("resource", resource);
        return "platform/resource/list";
	}
	
	@RequiresPermissions("resource:view")
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) {
		SysResource resource = new SysResource();
		if(id != 0){
			resource = resourceService.selectById(id);
		}
		model.addAttribute("resource", resource);
		return "platform/resource/save";
	}
	
	@RequestMapping(value="tree",method = RequestMethod.GET)
	//将数据库的菜单表做排序处理，排序考虑到了层级关系 gird会根据parentid 来计算深度
	public Result<List<SysResource>> findTree(SysResource searchVo) throws Exception {
		List<SysResource> finalList = new ArrayList<SysResource>();
		List<SysResource> list = resourceService.selectByProperties(searchVo);
		List<SysPermission> permissionList  = permissionService.selectByProperties(new SysPermission());
		for(SysResource sysResource : list) {
			sysResource.setId(sysResource.getId());
			//设置树的深度 因为前台无法通过id做判断 父子是不同的表 id有可能重复
			//sysResource.setDepth(0);
			finalList.add(sysResource);
			for(SysPermission sysPermission:permissionList) {
				//因为表格中 树展开的下一层是 permission而非resource 为了让grid识别 转换成resource
				if(sysPermission.getResourceId().longValue()==sysResource.getId().longValue()) {
					SysResource sysResourceChange = new SysResource();
					sysResourceChange.setId(sysPermission.getId());
					sysResourceChange.setName(sysPermission.getOperationName());
					sysResourceChange.setCode(sysPermission.getOperationCode());
					//深度设置为-1 代表最底层
					//sysResourceChange.setDepth(-1);
					finalList.add(sysResourceChange);
				}
			}
		}
		for (SysResource sysResource : finalList) {
			System.out.println(sysResource.getName());
			for (SysOperation operation : sysResource.getOperationList()) {
				System.out.println(operation.getName());
			}
		}
		return new ResultBuilder<List<SysResource>>().data(finalList).build();
	}
	
	@RequestMapping(value = "unique", method = RequestMethod.GET)
	public @ResponseBody Boolean unique(SysResource searchVo) {
		List<SysResource> list = resourceService.selectByUnique(searchVo);
		if (list != null && list.size() > 0) {
			for (SysResource resource : list) {
				if (searchVo.getId() == null || searchVo.getId().intValue() != resource.getId().intValue()) {
					return false;
				}
			}
		}
		return true;
	}
	
	@RequiresPermissions("resource:view")
	@RequestMapping(value = "all", method = RequestMethod.GET)
	public @ResponseBody Result<List<SysResource>> all(SysResource searchVo) {
		List<SysResource> list = resourceService.selectByProperties(searchVo);
		return new ResultBuilder<List<SysResource>>().data(list).build();
	}
	
	@RequiresPermissions("resource:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysResource resource, Model model){
		resourceService.save(resource);
		return "redirect:/api/v1/resource";
	}
	
	@RequiresPermissions("resource:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysResource resource,Model model){
		resourceService.updateNotNull(resource);
		return "redirect:/api/v1/resource";
	}
	
	@RequiresPermissions("resource:delete")
	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		resourceService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}
	
	@RequiresPermissions("resource:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysResource sysUser) {
        String ids = sysUser.getIds();
        for(String id: ids.split(",")) {
            resourceService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
    
}
