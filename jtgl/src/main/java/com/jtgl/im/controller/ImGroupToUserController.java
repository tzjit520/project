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

import com.jtgl.im.model.ImGroupToUser;
import com.jtgl.im.service.ImGroupToUserService;

@Controller
@RequestMapping("/api/v1/imGroupToUser")
public class ImGroupToUserController extends BaseController {
	
	@Autowired
	private ImGroupToUserService imGroupToUserService;

    // 根据属性分页查询数据
	@RequiresPermissions("imGroupToUser:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImGroupToUser searchVo, Model model) throws Exception {
		PageModel<ImGroupToUser> page = imGroupToUserService.selectByPage(searchVo);
		model.addAttribute("page", page);
		return "";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("imGroupToUser:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<ImGroupToUser>> findAll(ImGroupToUser searchVo) throws Exception {
		return new ResultBuilder<List<ImGroupToUser>>().data(imGroupToUserService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("imGroupToUser:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public Result<ImGroupToUser> findById(@PathVariable Integer id) throws Exception {
		ImGroupToUser ImGroupToUser = imGroupToUserService.selectById(id);
		return new ResultBuilder<ImGroupToUser>().data(ImGroupToUser).build();
	}

	// 唯一性校验
    @RequiresPermissions("imGroupToUser:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(ImGroupToUser searchVo) {
        List<ImGroupToUser> list = imGroupToUserService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImGroupToUser imGroupToUser:list) {
                if(searchVo.getId() == null||imGroupToUser.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("imGroupToUser:add")
	@RequestMapping(method = RequestMethod.POST)
	public Result<String> save(ImGroupToUser imGroupToUser) {
		imGroupToUserService.save(imGroupToUser);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("imGroupToUser:update")
	@RequestMapping(method = RequestMethod.PUT)
	public Result<String> update(ImGroupToUser imGroupToUser) {
		imGroupToUserService.updateNotNull(imGroupToUser);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("imGroupToUser:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Result<String> delete(@PathVariable Integer id) {
		imGroupToUserService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("imGroupToUser:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public Result<String> batchDelete(ImGroupToUser imGroupToUser) {
        String ids = imGroupToUser.getIds();
        for(String id : ids.split(",")) {
            imGroupToUserService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
