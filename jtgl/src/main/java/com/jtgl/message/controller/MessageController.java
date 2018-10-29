package com.jtgl.message.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.stereotype.Controller;

import com.platform.page.PageModel;
import org.springframework.ui.Model;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.controller.BaseController;

import com.jtgl.message.model.Message;
import com.jtgl.message.service.MessageService;

@Controller
@RequestMapping("/api/v1/message")
public class MessageController extends BaseController {
	
	@Autowired
	private MessageService messageService;

    // 根据属性分页查询数据
	@RequiresPermissions("message:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(Message searchVo, Model model) throws Exception {
		PageModel<Message> page = messageService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("message", searchVo);
		return "jtgl/message/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("message:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<Message>> findAll(Message searchVo) throws Exception {
		return new ResultBuilder<List<Message>>().data(messageService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("message:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		Message message = new Message();
		if(id != null && id != 0){
			message = messageService.selectById(id);
		}
		model.addAttribute("message", message);
		return "jtgl/message/save";
	}

	// 唯一性校验
    @RequiresPermissions("message:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(Message searchVo) {
        List<Message> list = messageService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(Message message:list) {
                if(searchVo.getId() == null||message.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequiresPermissions("message:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(Message message) {
		messageService.save(message);
		return "redirect:/api/v1/message";
	}
	
	// 更新数据
	@RequiresPermissions("message:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(Message message) {
		messageService.updateNotNull(message);
		return "redirect:/api/v1/message";
	}
	
	// 删除数据
	@RequiresPermissions("message:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		messageService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("message:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(Message message) {
        String ids = message.getIds();
        for(String id : ids.split(",")) {
            messageService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
