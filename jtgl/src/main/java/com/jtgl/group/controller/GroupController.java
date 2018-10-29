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

import com.jtgl.group.model.Group;
import com.jtgl.group.service.GroupService;

@Controller
@RequestMapping("/api/v1/group")
public class GroupController extends BaseController {
	
	@Autowired
	private GroupService groupService;

    // 根据属性分页查询数据
	@RequiresPermissions("group:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(Group searchVo, Model model) throws Exception {
		PageModel<Group> page = groupService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("group", searchVo);
		return "jtgl/group/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("group:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<Group>> findAll(Group searchVo) throws Exception {
		return new ResultBuilder<List<Group>>().data(groupService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("group:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		Group group = new Group();
		if(id != null && id != 0){
			group = groupService.selectById(id);
		}
		model.addAttribute("group", group);
		return "jtgl/group/save";
	}

	// 唯一性校验
    @RequiresPermissions("group:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(Group searchVo) {
        List<Group> list = groupService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(Group group:list) {
                if(searchVo.getId() == null||group.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("group:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(Group group) {
		groupService.save(group);
		return "redirect:/api/v1/group";
	}
	
	// 更新数据
	@RequiresPermissions("group:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(Group group) {
		groupService.updateNotNull(group);
		return "redirect:/api/v1/group";
	}
	
	// 删除数据
	@RequiresPermissions("group:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		groupService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("group:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(Group group) {
        String ids = group.getIds();
        for(String id : ids.split(",")) {
            groupService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
