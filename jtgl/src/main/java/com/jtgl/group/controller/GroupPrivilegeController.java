package com.jtgl.group.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;

import com.platform.page.PageModel;
import org.springframework.ui.Model;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.controller.BaseController;

import com.jtgl.group.model.GroupPrivilege;
import com.jtgl.group.service.GroupPrivilegeService;

@Controller
@RequestMapping("/api/v1/groupPrivilege")
public class GroupPrivilegeController extends BaseController {
	
	@Autowired
	private GroupPrivilegeService groupPrivilegeService;

    // 根据属性分页查询数据
	@RequiresPermissions("group:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(GroupPrivilege searchVo, Model model) throws Exception {
		PageModel<GroupPrivilege> page = groupPrivilegeService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("groupPrivilege", searchVo);
		return "jtgl/privilege/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("group:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<GroupPrivilege>> findAll(GroupPrivilege searchVo) throws Exception {
		return new ResultBuilder<List<GroupPrivilege>>().data(groupPrivilegeService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("group:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		GroupPrivilege groupPrivilege = new GroupPrivilege();
		if(id != null && id != 0){
			groupPrivilege = groupPrivilegeService.selectById(id);
		}
		model.addAttribute("groupPrivilege", groupPrivilege);
		return "jtgl/privilege/save";
	}

	// 唯一性校验
    @RequiresPermissions("group:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(GroupPrivilege searchVo) {
        List<GroupPrivilege> list = groupPrivilegeService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(GroupPrivilege groupPrivilege:list) {
                if(searchVo.getId() == null||groupPrivilege.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("group:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(GroupPrivilege groupPrivilege) {
		groupPrivilegeService.save(groupPrivilege);
		return "redirect:/api/v1/groupPrivilege";
	}
	
	// 更新数据
	@RequiresPermissions("group:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(GroupPrivilege groupPrivilege) {
		groupPrivilegeService.updateNotNull(groupPrivilege);
		return "redirect:/api/v1/groupPrivilege";
	}
	
	// 删除数据
	@RequiresPermissions("group:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		groupPrivilegeService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("group:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(GroupPrivilege groupPrivilege) {
        String ids = groupPrivilege.getIds();
        for(String id : ids.split(",")) {
            groupPrivilegeService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
