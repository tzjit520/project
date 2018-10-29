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

import com.jtgl.im.model.ImGroupMsgUserToUser;
import com.jtgl.im.service.ImGroupMsgUserToUserService;

@Controller
@RequestMapping("/api/v1/imGroupMsgUserToUser")
public class ImGroupMsgUserToUserController extends BaseController {
	
	@Autowired
	private ImGroupMsgUserToUserService imGroupMsgUserToUserService;

    // 根据属性分页查询数据
	@RequiresPermissions("imGroupMsgUserToUser:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImGroupMsgUserToUser searchVo, Model model) throws Exception {
		PageModel<ImGroupMsgUserToUser> page = imGroupMsgUserToUserService.selectByPage(searchVo);
		model.addAttribute("page", page);
		return "";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("imGroupMsgUserToUser:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<ImGroupMsgUserToUser>> findAll(ImGroupMsgUserToUser searchVo) throws Exception {
		return new ResultBuilder<List<ImGroupMsgUserToUser>>().data(imGroupMsgUserToUserService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("imGroupMsgUserToUser:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public Result<ImGroupMsgUserToUser> findById(@PathVariable Integer id) throws Exception {
		ImGroupMsgUserToUser ImGroupMsgUserToUser = imGroupMsgUserToUserService.selectById(id);
		return new ResultBuilder<ImGroupMsgUserToUser>().data(ImGroupMsgUserToUser).build();
	}

	// 唯一性校验
    @RequiresPermissions("imGroupMsgUserToUser:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(ImGroupMsgUserToUser searchVo) {
        List<ImGroupMsgUserToUser> list = imGroupMsgUserToUserService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImGroupMsgUserToUser imGroupMsgUserToUser:list) {
                if(searchVo.getId() == null||imGroupMsgUserToUser.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("imGroupMsgUserToUser:add")
	@RequestMapping(method = RequestMethod.POST)
	public Result<String> save(ImGroupMsgUserToUser imGroupMsgUserToUser) {
		imGroupMsgUserToUserService.save(imGroupMsgUserToUser);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("imGroupMsgUserToUser:update")
	@RequestMapping(method = RequestMethod.PUT)
	public Result<String> update(ImGroupMsgUserToUser imGroupMsgUserToUser) {
		imGroupMsgUserToUserService.updateNotNull(imGroupMsgUserToUser);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("imGroupMsgUserToUser:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Result<String> delete(@PathVariable Integer id) {
		imGroupMsgUserToUserService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("imGroupMsgUserToUser:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public Result<String> batchDelete(ImGroupMsgUserToUser imGroupMsgUserToUser) {
        String ids = imGroupMsgUserToUser.getIds();
        for(String id : ids.split(",")) {
            imGroupMsgUserToUserService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
