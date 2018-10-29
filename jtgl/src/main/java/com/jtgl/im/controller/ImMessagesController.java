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

import com.jtgl.im.model.ImMessages;
import com.jtgl.im.service.ImMessagesService;

@Controller
@RequestMapping("/api/v1/imMessages")
public class ImMessagesController extends BaseController {
	
	@Autowired
	private ImMessagesService imMessagesService;

    // 根据属性分页查询数据
	@RequiresPermissions("imMessages:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImMessages searchVo, Model model) throws Exception {
		PageModel<ImMessages> page = imMessagesService.selectByPage(searchVo);
		model.addAttribute("page", page);
		return "";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("imMessages:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<ImMessages>> findAll(ImMessages searchVo) throws Exception {
		return new ResultBuilder<List<ImMessages>>().data(imMessagesService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("imMessages:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public Result<ImMessages> findById(@PathVariable Integer id) throws Exception {
		ImMessages ImMessages = imMessagesService.selectById(id);
		return new ResultBuilder<ImMessages>().data(ImMessages).build();
	}

	// 唯一性校验
    @RequiresPermissions("imMessages:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(ImMessages searchVo) {
        List<ImMessages> list = imMessagesService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImMessages imMessages:list) {
                if(searchVo.getId() == null||imMessages.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("imMessages:add")
	@RequestMapping(method = RequestMethod.POST)
	public Result<String> save(ImMessages imMessages) {
		imMessagesService.save(imMessages);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("imMessages:update")
	@RequestMapping(method = RequestMethod.PUT)
	public Result<String> update(ImMessages imMessages) {
		imMessagesService.updateNotNull(imMessages);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("imMessages:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Result<String> delete(@PathVariable Integer id) {
		imMessagesService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("imMessages:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public Result<String> batchDelete(ImMessages imMessages) {
        String ids = imMessages.getIds();
        for(String id : ids.split(",")) {
            imMessagesService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
