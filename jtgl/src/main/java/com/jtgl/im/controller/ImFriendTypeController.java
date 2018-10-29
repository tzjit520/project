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

import com.jtgl.im.model.ImFriendType;
import com.jtgl.im.service.ImFriendTypeService;

@Controller
@RequestMapping("/api/v1/imFriendType")
public class ImFriendTypeController extends BaseController {
	
	@Autowired
	private ImFriendTypeService imFriendTypeService;

    // 根据属性分页查询数据
	@RequiresPermissions("imFriendType:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImFriendType searchVo, Model model) throws Exception {
		PageModel<ImFriendType> page = imFriendTypeService.selectByPage(searchVo);
		model.addAttribute("page", page);
		return "";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("imFriendType:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<ImFriendType>> findAll(ImFriendType searchVo) throws Exception {
		return new ResultBuilder<List<ImFriendType>>().data(imFriendTypeService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("imFriendType:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public Result<ImFriendType> findById(@PathVariable Integer id) throws Exception {
		ImFriendType ImFriendType = imFriendTypeService.selectById(id);
		return new ResultBuilder<ImFriendType>().data(ImFriendType).build();
	}

	// 唯一性校验
    @RequiresPermissions("imFriendType:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(ImFriendType searchVo) {
        List<ImFriendType> list = imFriendTypeService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImFriendType imFriendType:list) {
                if(searchVo.getId() == null||imFriendType.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("imFriendType:add")
	@RequestMapping(method = RequestMethod.POST)
	public Result<String> save(ImFriendType imFriendType) {
		imFriendTypeService.save(imFriendType);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("imFriendType:update")
	@RequestMapping(method = RequestMethod.PUT)
	public Result<String> update(ImFriendType imFriendType) {
		imFriendTypeService.updateNotNull(imFriendType);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("imFriendType:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Result<String> delete(@PathVariable Integer id) {
		imFriendTypeService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("imFriendType:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public Result<String> batchDelete(ImFriendType imFriendType) {
        String ids = imFriendType.getIds();
        for(String id : ids.split(",")) {
            imFriendTypeService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
