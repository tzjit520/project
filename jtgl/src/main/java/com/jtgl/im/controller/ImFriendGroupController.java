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

import com.jtgl.im.model.ImFriendGroup;
import com.jtgl.im.service.ImFriendGroupService;

@Controller
@RequestMapping("/api/v1/imFriendGroup")
public class ImFriendGroupController extends BaseController {
	
	@Autowired
	private ImFriendGroupService imFriendGroupService;

    // 根据属性分页查询数据
	@RequiresPermissions("imFriendGroup:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImFriendGroup searchVo, Model model) throws Exception {
		PageModel<ImFriendGroup> page = imFriendGroupService.selectByPage(searchVo);
		model.addAttribute("page", page);
		return "";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("imFriendGroup:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<ImFriendGroup>> findAll(ImFriendGroup searchVo) throws Exception {
		return new ResultBuilder<List<ImFriendGroup>>().data(imFriendGroupService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("imFriendGroup:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public Result<ImFriendGroup> findById(@PathVariable Integer id) throws Exception {
		ImFriendGroup ImFriendGroup = imFriendGroupService.selectById(id);
		return new ResultBuilder<ImFriendGroup>().data(ImFriendGroup).build();
	}

	// 唯一性校验
    @RequiresPermissions("imFriendGroup:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(ImFriendGroup searchVo) {
        List<ImFriendGroup> list = imFriendGroupService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImFriendGroup imFriendGroup:list) {
                if(searchVo.getId() == null||imFriendGroup.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("imFriendGroup:add")
	@RequestMapping(method = RequestMethod.POST)
	public Result<String> save(ImFriendGroup imFriendGroup) {
		imFriendGroupService.save(imFriendGroup);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("imFriendGroup:update")
	@RequestMapping(method = RequestMethod.PUT)
	public Result<String> update(ImFriendGroup imFriendGroup) {
		imFriendGroupService.updateNotNull(imFriendGroup);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("imFriendGroup:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Result<String> delete(@PathVariable Integer id) {
		imFriendGroupService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("imFriendGroup:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public Result<String> batchDelete(ImFriendGroup imFriendGroup) {
        String ids = imFriendGroup.getIds();
        for(String id : ids.split(",")) {
            imFriendGroupService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
