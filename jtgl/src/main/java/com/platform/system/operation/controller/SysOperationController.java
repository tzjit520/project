package com.platform.system.operation.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;
import com.platform.system.operation.model.SysOperation;
import com.platform.system.operation.service.SysOperationService;

@Controller
@RequestMapping("api/v1/operation")
public class SysOperationController extends BaseController{
	
	@Autowired
	private SysOperationService operationService;

	@RequiresPermissions("operation:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysOperation operation, Model model) {
		PageModel<SysOperation> page = operationService.selectByPage(operation);
		model.addAttribute("page", page);
		model.addAttribute("operation", operation);
        return "platform/operation/list";
	}
	
	@RequiresPermissions("operation:view")
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) {
		SysOperation operation = new SysOperation();
		if(id != 0){
			operation = operationService.selectById(id);
		}
		model.addAttribute("operation", operation);
		return "platform/operation/save";
	}
	
	@RequestMapping(value = "unique", method = RequestMethod.GET)
	public @ResponseBody Boolean unique(SysOperation searchVo) {
		List<SysOperation> list = operationService.selectByUnique(searchVo);
		if (list != null && list.size() > 0) {
			for (SysOperation operation : list) {
				if (searchVo.getId() == null || searchVo.getId().intValue() != operation.getId().intValue()) {
					return false;
				}
			}
		}
		return true;
	}
	
	@RequiresPermissions("operation:view")
	@RequestMapping(value = "all", method = RequestMethod.GET)
	public @ResponseBody Result<List<SysOperation>> all(SysOperation searchVo) {
		List<SysOperation> list = operationService.selectByProperties(searchVo);
		return new ResultBuilder<List<SysOperation>>().data(list).build();
	}
	
	@RequiresPermissions("operation:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysOperation operation, Model model){
		operationService.save(operation);
		return "redirect:/api/v1/operation";
	}
	
	@RequiresPermissions("operation:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysOperation operation,Model model){
		operationService.updateNotNull(operation);
		return "redirect:/api/v1/operation";
	}
	
	@RequiresPermissions("operation:delete")
	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		operationService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}
	
	@RequiresPermissions("operation:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysOperation sysUser) {
        String ids = sysUser.getIds();
        for(String id: ids.split(",")) {
            operationService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
    
}
