package com.jtgl.im.controller;

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
import com.jtgl.im.model.ImUsers;
import com.jtgl.im.service.ImUsersService;

@Controller
@RequestMapping("/api/v1/imUsers")
public class ImUsersController extends BaseController {
	
	@Autowired
	private ImUsersService imUsersService;

    // 根据属性分页查询数据
	@RequiresPermissions("im:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImUsers imUsers, Model model) throws Exception {
		PageModel<ImUsers> page = imUsersService.selectByPage(imUsers);
		model.addAttribute("page", page);
		model.addAttribute("imUsers", imUsers);
		return "im/user/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("im:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<ImUsers>> findAll(ImUsers imUsers) throws Exception {
		return new ResultBuilder<List<ImUsers>>().data(imUsersService.selectByProperties(imUsers)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("im:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		ImUsers imUsers = new ImUsers();
		if(id != null && id != 0){
			imUsers = imUsersService.selectById(id);
		}
		model.addAttribute("imUsers", imUsers);
		return "im/user/save";
	}

	// 唯一性校验
    @RequiresPermissions("im:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(ImUsers searchVo) {
        List<ImUsers> list = imUsersService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImUsers imUsers:list) {
                if(searchVo.getId() == null || imUsers.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("im:add")
	@RequestMapping(method = RequestMethod.POST)
	public @ResponseBody Result<String> save(ImUsers imUsers) {
		imUsersService.save(imUsers);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("im:update")
	@RequestMapping(method = RequestMethod.PUT)
	public @ResponseBody Result<String> update(ImUsers imUsers) {
		imUsersService.updateNotNull(imUsers);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("im:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		imUsersService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("im:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(ImUsers imUsers) {
        String ids = imUsers.getIds();
        for(String id : ids.split(",")) {
            imUsersService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
