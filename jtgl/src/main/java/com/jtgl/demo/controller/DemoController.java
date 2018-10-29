package com.jtgl.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.platform.controller.BaseController;
import com.platform.system.user.model.SysUser;
import com.platform.system.user.service.SysUserService;

@Controller
@RequestMapping("/api/v1/demo")
public class DemoController extends BaseController {

	@Autowired
	private SysUserService userService;

	//其它样例
	@RequestMapping(value = "/qt", method = RequestMethod.GET)
	public String qt(Model model) {
		return "demo/qita/list";
	}
		
	//树形列表
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String home(Model model) {
		return "home";
	}
	
	//树形列表
	@RequestMapping(value = "/ztree", method = RequestMethod.GET)
	public String ztree(Model model) {
		return "demo/ztree/list";
	}
	
	//二维码
	@RequestMapping(value = "/qrCode", method = RequestMethod.GET)
	public String qrCode(Model model) {
		return "demo/qrCode/list";
	}
	
	//邮箱
    @RequestMapping(value = "/email", method = RequestMethod.GET)
    public String email(Model model) {
    	return "demo/email/list";
    }
    
	//系统控件
    @RequestMapping(value = "/sysControl", method = RequestMethod.GET)
    public String xtkj(Model model) {
        return "demo/syscontrol/list";
    }
    
    //文件上传
    @RequestMapping(value = "/fileUpload", method = RequestMethod.GET)
    public String fileUpload(Model model) {
    	return "demo/upload/file/list";
    }
    
    //图片上传
    @RequestMapping(value = "/imgUpload", method = RequestMethod.GET)
    public String ImgUpload(Model model) {
    	return "demo/upload/img/list";
    }
    
    //系统图标
    @RequestMapping(value = "/icon", method = RequestMethod.GET)
    public String Icon(Model model) {
    	return "demo/icon/list";
    }
    
    //百度地图
    @RequestMapping(value = "/bMap", method = RequestMethod.GET)
    public String BMap(Model model) {
    	return "demo/map/bmap/list";
    }
    
    //高德地图
    @RequestMapping(value = "/gMap", method = RequestMethod.GET)
    public String GMap(Model model) {
    	return "demo/map/gmap/list";
    }
    
    //Highcharts图表
    @RequestMapping(value = "/hCharts", method = RequestMethod.GET)
    public String hCharts(Model model) {
    	return "demo/charts/hcharts/hcharts";
    }
    
    //Echarts图表
    @RequestMapping(value = "/eCharts", method = RequestMethod.GET)
    public String eCharts(Model model) {
    	return "demo/charts/echarts/echarts";
    }
    
    //视频播放
    @RequestMapping(value = "/video", method = RequestMethod.GET)
    public String video(Model model) {
    	return "demo/medio/video/video";
    }
    
    //照片墙
    @RequestMapping(value = "/photo", method = RequestMethod.GET)
    public String photo(Model model) {
    	return "demo/medio/photo/photo";
    }
    
    //聊天页面
    @RequestMapping(value = "/chat", method = RequestMethod.GET)
    public String chat(Model model) {
    	List<SysUser> listUser = userService.selectByProperties(new SysUser());
    	model.addAttribute("listUser", listUser);
    	return "demo/chat/chat";
    }
    
    
}
