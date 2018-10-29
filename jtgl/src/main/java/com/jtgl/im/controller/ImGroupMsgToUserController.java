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

import com.jtgl.im.model.ImGroupMsgToUser;
import com.jtgl.im.service.ImGroupMsgToUserService;

@Controller
@RequestMapping("/api/v1/imGroupMsgToUser")
public class ImGroupMsgToUserController extends BaseController {
	
	@Autowired
	private ImGroupMsgToUserService imGroupMsgToUserService;

    // 根据属性分页查询数据
	@RequiresPermissions("imGroupMsgToUser:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImGroupMsgToUser searchVo, Model model) throws Exception {
		PageModel<ImGroupMsgToUser> page = imGroupMsgToUserService.selectByPage(searchVo);
		model.addAttribute("page", page);
		return "";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("imGroupMsgToUser:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<ImGroupMsgToUser>> findAll(ImGroupMsgToUser searchVo) throws Exception {
		return new ResultBuilder<List<ImGroupMsgToUser>>().data(imGroupMsgToUserService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("imGroupMsgToUser:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public Result<ImGroupMsgToUser> findById(@PathVariable Integer id) throws Exception {
		ImGroupMsgToUser ImGroupMsgToUser = imGroupMsgToUserService.selectById(id);
		return new ResultBuilder<ImGroupMsgToUser>().data(ImGroupMsgToUser).build();
	}

	// 唯一性校验
    @RequiresPermissions("imGroupMsgToUser:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(ImGroupMsgToUser searchVo) {
        List<ImGroupMsgToUser> list = imGroupMsgToUserService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImGroupMsgToUser imGroupMsgToUser:list) {
                if(searchVo.getId() == null||imGroupMsgToUser.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("imGroupMsgToUser:add")
	@RequestMapping(method = RequestMethod.POST)
	public Result<String> save(ImGroupMsgToUser imGroupMsgToUser) {
		imGroupMsgToUserService.save(imGroupMsgToUser);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("imGroupMsgToUser:update")
	@RequestMapping(method = RequestMethod.PUT)
	public Result<String> update(ImGroupMsgToUser imGroupMsgToUser) {
		imGroupMsgToUserService.updateNotNull(imGroupMsgToUser);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("imGroupMsgToUser:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Result<String> delete(@PathVariable Integer id) {
		imGroupMsgToUserService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("imGroupMsgToUser:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public Result<String> batchDelete(ImGroupMsgToUser imGroupMsgToUser) {
        String ids = imGroupMsgToUser.getIds();
        for(String id : ids.split(",")) {
            imGroupMsgToUserService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
