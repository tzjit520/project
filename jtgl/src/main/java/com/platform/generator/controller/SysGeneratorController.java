package com.platform.generator.controller;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.common.constants.StatusCode;
import com.platform.controller.BaseController;
import com.platform.generator.model.SysTable;
import com.platform.generator.service.SysGeneratorService;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;


/**
 * 代码生成器
 */
@Controller
@RequestMapping("/api/v1/generator")
public class SysGeneratorController extends BaseController{
	
	private Logger logger = Logger.getLogger(getClass());
	
	@Autowired
	private SysGeneratorService sysGeneratorService;

	@RequiresPermissions("generator:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysTable sysTable, Model model) {
		PageModel<SysTable> userPage = sysGeneratorService.selectByPage(sysTable);
		model.addAttribute("page", userPage);
		model.addAttribute("sysTable", sysTable);
        return "platform/generator/list";
	}

	/**
	 * 生成代码
	 */
	@RequiresPermissions("generator:view")
	@RequestMapping(method = RequestMethod.POST)
	public @ResponseBody Result<String> save(SysTable sysTable) {
		// 获取用户指定的表名
		List<String> targetTableList = new ArrayList<String>();
		String[] tables = sysTable.getTableNames().split(",");
		for (int i = 0; i < tables.length; i++) {
			String tableName = tables[i];
			targetTableList.add(tableName);
		}
		// 生成文件
		try {
			sysGeneratorService.generateCodes(targetTableList, sysTable.getPackageName());
		} catch (Exception e) {
			logger.error(e);
			return new ResultBuilder<String>().message(StatusCode.GENERATOR_CODE_ERROR,StatusCode.GENERATOR_CODE_ERROR_MSG).build();
		}
		return new ResultBuilder<String>().data("").build();
	}
}
