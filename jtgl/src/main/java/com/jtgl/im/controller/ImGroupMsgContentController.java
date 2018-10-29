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

import com.jtgl.im.model.ImGroupMsgContent;
import com.jtgl.im.service.ImGroupMsgContentService;

@Controller
@RequestMapping("/api/v1/imGroupMsgContent")
public class ImGroupMsgContentController extends BaseController {
	
	@Autowired
	private ImGroupMsgContentService imGroupMsgContentService;

    // 根据属性分页查询数据
	@RequiresPermissions("imGroupMsgContent:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ImGroupMsgContent searchVo, Model model) throws Exception {
		PageModel<ImGroupMsgContent> page = imGroupMsgContentService.selectByPage(searchVo);
		model.addAttribute("page", page);
		return "";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("imGroupMsgContent:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<ImGroupMsgContent>> findAll(ImGroupMsgContent searchVo) throws Exception {
		return new ResultBuilder<List<ImGroupMsgContent>>().data(imGroupMsgContentService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("imGroupMsgContent:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public Result<ImGroupMsgContent> findById(@PathVariable Integer id) throws Exception {
		ImGroupMsgContent ImGroupMsgContent = imGroupMsgContentService.selectById(id);
		return new ResultBuilder<ImGroupMsgContent>().data(ImGroupMsgContent).build();
	}

	// 唯一性校验
    @RequiresPermissions("imGroupMsgContent:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(ImGroupMsgContent searchVo) {
        List<ImGroupMsgContent> list = imGroupMsgContentService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ImGroupMsgContent imGroupMsgContent:list) {
                if(searchVo.getId() == null||imGroupMsgContent.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("imGroupMsgContent:add")
	@RequestMapping(method = RequestMethod.POST)
	public Result<String> save(ImGroupMsgContent imGroupMsgContent) {
		imGroupMsgContentService.save(imGroupMsgContent);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 更新数据
	@RequiresPermissions("imGroupMsgContent:update")
	@RequestMapping(method = RequestMethod.PUT)
	public Result<String> update(ImGroupMsgContent imGroupMsgContent) {
		imGroupMsgContentService.updateNotNull(imGroupMsgContent);
		return new ResultBuilder<String>().data("").build();
	}
	
	// 删除数据
	@RequiresPermissions("imGroupMsgContent:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public Result<String> delete(@PathVariable Integer id) {
		imGroupMsgContentService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("imGroupMsgContent:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public Result<String> batchDelete(ImGroupMsgContent imGroupMsgContent) {
        String ids = imGroupMsgContent.getIds();
        for(String id : ids.split(",")) {
            imGroupMsgContentService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
