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

import com.jtgl.im.model.ImFriends;
import com.jtgl.im.service.ImFriendsService;

@Controller
@RequestMapping("/api/v1/imFriends")
public class ImFriendsController extends BaseController {
	
	@Autowired
	private ImFriendsService imFriendsService;

    // 根据属性分页查询数据
	@RequiresPermissions("imFriends:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImFriends searchVo, Model model) throws Exception {
		PageModel<ImFriends> page = imFriendsService.selectByPage(searchVo);
		model.addAttribute("page", page);
		return "";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("imFriends:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<ImFriends>> findAll(ImFriends searchVo) throws Exception {
		return new ResultBuilder<List<ImFriends>>().data(imFriendsService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("imFriends:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public Result<ImFriends> findById(@PathVariable Integer id) throws Exception {
		ImFriends ImFriends = imFriendsService.selectById(id);
		return new ResultBuilder<ImFriends>().data(ImFriends).build();
	}

	// 唯一性校验
    @RequiresPermissions("imFriends:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(ImFriends searchVo) {
        List<ImFriends> list = imFriendsService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImFriends imFriends:list) {
                if(searchVo.getId() == null||imFriends.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("imFriends:add")
	@RequestMapping(method = RequestMethod.POST)
	public Result<String> save(ImFriends imFriends) {
		imFriendsService.save(imFriends);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("imFriends:update")
	@RequestMapping(method = RequestMethod.PUT)
	public Result<String> update(ImFriends imFriends) {
		imFriendsService.updateNotNull(imFriends);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("imFriends:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Result<String> delete(@PathVariable Integer id) {
		imFriendsService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("imFriends:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public Result<String> batchDelete(ImFriends imFriends) {
        String ids = imFriends.getIds();
        for(String id : ids.split(",")) {
            imFriendsService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
