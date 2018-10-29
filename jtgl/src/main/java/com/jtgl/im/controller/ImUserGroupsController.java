package com.jtgl.im.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.stereotype.Controller;

import com.platform.page.PageModel;
import org.springframework.ui.Model;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.controller.BaseController;

import com.jtgl.im.model.ImUserGroups;
import com.jtgl.im.service.ImUserGroupsService;

@Controller
@RequestMapping("/api/v1/imUserGroups")
public class ImUserGroupsController extends BaseController {
	
	@Autowired
	private ImUserGroupsService imUserGroupsService;

    // 根据属性分页查询数据
	@RequiresPermissions("imUserGroups:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImUserGroups searchVo, Model model) throws Exception {
		PageModel<ImUserGroups> page = imUserGroupsService.selectByPage(searchVo);
		model.addAttribute("page", page);
		return "";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("imUserGroups:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<ImUserGroups>> findAll(ImUserGroups searchVo) throws Exception {
		return new ResultBuilder<List<ImUserGroups>>().data(imUserGroupsService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("imUserGroups:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public Result<ImUserGroups> findById(@PathVariable Integer id) throws Exception {
		ImUserGroups ImUserGroups = imUserGroupsService.selectById(id);
		return new ResultBuilder<ImUserGroups>().data(ImUserGroups).build();
	}

	// 唯一性校验
    @RequiresPermissions("imUserGroups:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(ImUserGroups searchVo) {
        List<ImUserGroups> list = imUserGroupsService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImUserGroups imUserGroups:list) {
                if(searchVo.getId() == null||imUserGroups.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("imUserGroups:add")
	@RequestMapping(method = RequestMethod.POST)
	public Result<String> save(ImUserGroups imUserGroups) {
		imUserGroupsService.save(imUserGroups);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("imUserGroups:update")
	@RequestMapping(method = RequestMethod.PUT)
	public Result<String> update(ImUserGroups imUserGroups) {
		imUserGroupsService.updateNotNull(imUserGroups);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("imUserGroups:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Result<String> delete(@PathVariable Integer id) {
		imUserGroupsService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("imUserGroups:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public Result<String> batchDelete(ImUserGroups imUserGroups) {
        String ids = imUserGroups.getIds();
        for(String id : ids.split(",")) {
            imUserGroupsService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
