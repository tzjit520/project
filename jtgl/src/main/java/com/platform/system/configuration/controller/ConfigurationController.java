package com.platform.system.configuration.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.platform.controller.BaseController;

/**
 * 系统配置
 */
@Controller
@RequestMapping("/api/v1/configuration")
public class ConfigurationController extends BaseController {

	@RequiresPermissions("system:view")
	@RequestMapping(method = RequestMethod.GET)
	public String list(Model model) throws Exception {
		return "platform/configuration/list";
	}

}
