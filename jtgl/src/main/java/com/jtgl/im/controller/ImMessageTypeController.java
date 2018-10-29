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

import com.jtgl.im.model.ImMessageType;
import com.jtgl.im.service.ImMessageTypeService;

@Controller
@RequestMapping("/api/v1/imMessageType")
public class ImMessageTypeController extends BaseController {
	
	@Autowired
	private ImMessageTypeService imMessageTypeService;

    // 根据属性分页查询数据
	@RequiresPermissions("imMessageType:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImMessageType searchVo, Model model) throws Exception {
		PageModel<ImMessageType> page = imMessageTypeService.selectByPage(searchVo);
		model.addAttribute("page", page);
		return "";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("imMessageType:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<ImMessageType>> findAll(ImMessageType searchVo) throws Exception {
		return new ResultBuilder<List<ImMessageType>>().data(imMessageTypeService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("imMessageType:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public Result<ImMessageType> findById(@PathVariable Integer id) throws Exception {
		ImMessageType ImMessageType = imMessageTypeService.selectById(id);
		return new ResultBuilder<ImMessageType>().data(ImMessageType).build();
	}

	// 唯一性校验
    @RequiresPermissions("imMessageType:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(ImMessageType searchVo) {
        List<ImMessageType> list = imMessageTypeService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImMessageType imMessageType:list) {
                if(searchVo.getId() == null||imMessageType.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("imMessageType:add")
	@RequestMapping(method = RequestMethod.POST)
	public Result<String> save(ImMessageType imMessageType) {
		imMessageTypeService.save(imMessageType);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("imMessageType:update")
	@RequestMapping(method = RequestMethod.PUT)
	public Result<String> update(ImMessageType imMessageType) {
		imMessageTypeService.updateNotNull(imMessageType);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("imMessageType:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Result<String> delete(@PathVariable Integer id) {
		imMessageTypeService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("imMessageType:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public Result<String> batchDelete(ImMessageType imMessageType) {
        String ids = imMessageType.getIds();
        for(String id : ids.split(",")) {
            imMessageTypeService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
