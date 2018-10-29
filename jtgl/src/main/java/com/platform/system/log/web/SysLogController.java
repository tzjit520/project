package com.platform.system.log.web;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;
import com.platform.system.log.model.SysLog;
import com.platform.system.log.service.SysLogService;

@Controller
@RequestMapping("/api/v1/log")
public class SysLogController extends BaseController {

	@Autowired
	private SysLogService logService;
	
	@RequiresPermissions("log:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysLog sysLog, Model model) throws Exception {
		PageModel<SysLog> page = logService.selectByPage(sysLog);
		model.addAttribute("page", page);
		model.addAttribute("log", sysLog);
		return "platform/log/list";
	}
	
	@RequiresPermissions("log:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysLog log) {
        String ids = log.getIds();
        for(String id:ids.split(",")) {
            logService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
}
