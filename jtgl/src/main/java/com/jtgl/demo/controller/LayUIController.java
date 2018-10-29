package com.jtgl.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.platform.controller.BaseController;

@Controller
@RequestMapping("/api/v1/layui")
public class LayUIController extends BaseController {

	//表单
	@RequestMapping(value = "/layout", method = RequestMethod.GET)
	public String layout(Model model) {
		return "demo/layui/layout";
	}
		
	//表单
	@RequestMapping(value = "/form", method = RequestMethod.GET)
	public String form(Model model) {
		return "demo/layui/form";
	}
		
	//按钮
	@RequestMapping(value = "/button", method = RequestMethod.GET)
	public String button(Model model) {
		return "demo/layui/button";
	}
		
	//表格
	@RequestMapping(value = "/table", method = RequestMethod.GET)
	public String home(Model model) {
		return "demo/layui/table";
	}
	
	//日期
	@RequestMapping(value = "/date", method = RequestMethod.GET)
	public String date(Model model) {
		return "demo/layui/date";
	}
	
	//分页
	@RequestMapping(value = "/page", method = RequestMethod.GET)
	public String page(Model model) {
		return "demo/layui/page";
	}
	
	//轮播
	@RequestMapping(value = "/carousel", method = RequestMethod.GET)
	public String carousel(Model model) {
		return "demo/layui/carousel";
	}
	
	//富文本
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(Model model) {
		return "demo/layui/edit";
	}
	
	//上传
	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public String upload(Model model) {
		return "demo/layui/upload";
	}
	
	//layer组件
	@RequestMapping(value = "/layer", method = RequestMethod.GET)
	public String layer(Model model) {
		return "demo/layer/list";
	}
}
