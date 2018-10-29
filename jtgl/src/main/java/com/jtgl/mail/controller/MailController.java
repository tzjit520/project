package com.jtgl.mail.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jtgl.mail.model.Mail;
import com.jtgl.mail.service.MailService;
import com.jtgl.person.model.Person;
import com.jtgl.person.service.PersonService;
import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;

@Controller
@RequestMapping("/api/v1/mail")
public class MailController extends BaseController {
	
	@Autowired
	private MailService mailService;

	@Autowired
	private PersonService personService;
	
    // 根据属性分页查询数据
	@RequiresPermissions("mail:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(Mail mail, Model model) throws Exception {
		PageModel<Mail> page = mailService.selectByPage(mail);
		model.addAttribute("page", page);
		model.addAttribute("mail", mail);
		return "jtgl/mail/list";
	}
	
	@RequiresPermissions("mail:view")
	@RequestMapping(value="index", method = RequestMethod.GET)
	public String index(Mail mail, Model model) throws Exception {
		model.addAttribute("email", mail);
		return "jtgl/mail/index";
	}

	// 根据ID查询数据
	@RequiresPermissions("mail:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		Mail mail = new Mail();
		if(id != null && id != 0){
			mail = mailService.selectById(id);
		}
		//查询所有人员
		List<Map<String, Object>> listUser = new ArrayList<Map<String,Object>>();
		List<Person> listpPerson = personService.selectByProperties(new Person());
		for (Person person : listpPerson) {
			if(StringUtils.isBlank(person.getMail())){
				continue;
			}
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", person.getId());
			map.put("name", person.getName()+"<"+person.getMail()+">");
			listUser.add(map);
		}
		model.addAttribute("listUser", listUser);
		model.addAttribute("mail", mail);
		return "jtgl/mail/write";
	}

	// 保存数据
	@RequiresPermissions("mail:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(Mail mail) {
		mailService.saveEmail(mail);
		return "redirect:/api/v1/mail?emailType=1";
	}
	
	// 更新数据
	@RequiresPermissions("mail:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(Mail mail) {
		mailService.updateNotNull(mail);
		return "redirect:/api/v1/mail?emailType=1";
	}

    // 批量删除数据
	@RequiresPermissions("mail:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(Mail mail) {
        String ids = mail.getIds();
        for(String id : ids.split(",")) {
            mailService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
