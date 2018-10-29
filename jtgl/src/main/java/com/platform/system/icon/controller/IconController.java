package com.platform.system.icon.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.platform.controller.BaseController;

@Controller
@RequestMapping("api/v1/icon")
public class IconController extends BaseController{

	@RequestMapping(method = RequestMethod.GET)
	public String list(String value, Model model) {
		String[] icons = {
			"im-home2","im-file","im-pacman","im-clock2",	
			"im-bubbles2", "im-cog2","im-heart","im-indent-increase",	
			"im-twitter", "im-vimeo","im-image","im-folder",	
			"im-location2",	"fa-share-sign", "fa-flickr", "fa-tasks",	
			"im-cog","im-stack","st-support","st-user",	
			"st-users","im-tags","fa-cog","fa-edit-sign",	
			"fa-twitter-sign","fa-th-large","en-database","en-chat",	
			"en-book","en-flag","en-suitcase","en-network",
			"en-leaf","br-alarm","en-network","en-music3",
			"fa-book","fa-link","fa-cloud-upload","fa-flickr"
		};
		model.addAttribute("value", value);
		model.addAttribute("icons", icons);
        return "platform/icon/list";
	}
	
}
