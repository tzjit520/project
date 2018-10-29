package com.jtgl.test.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jtgl.test.model.TestUser;
import com.jtgl.test.service.TestUserService;
import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;

@Controller
@RequestMapping("/api/v1/test")
public class TestUserController extends BaseController{

	@Autowired
	private TestUserService testUserService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(TestUser testUser, Model model) throws Exception {
		PageModel<TestUser> page = testUserService.selectByPage(testUser);
		model.addAttribute("page", page);
		model.addAttribute("testUser", testUser);
		return "demo/test/user/list";
	}
	
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) {
		TestUser testUser = new TestUser();
		if(id != null && id != 0){
			testUser = testUserService.selectById(id);
		}
		model.addAttribute("testUser", testUser);
		return "demo/test/user/save";
	}
	
	@RequestMapping(value = "unique", method = RequestMethod.GET)
	public @ResponseBody Boolean unique(TestUser searchVo) {
		List<TestUser> list = testUserService.selectByUnique(searchVo);
		if (list != null && list.size() > 0) {
			for (TestUser testUser : list) {
				if (searchVo.getId() == null || searchVo.getId().intValue() != testUser.getId().intValue()) {
					return false;
				}
			}
		}
		return true;
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String save(TestUser testUser){
		testUserService.save(testUser);
		return "redirect:/api/v1/test";
	}
	
	@RequestMapping(method = RequestMethod.PUT)
	public String update(TestUser testUser){
		testUserService.updateNotNull(testUser);
		return "redirect:/api/v1/test";
	}

    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(TestUser testUser) {
        String ids = testUser.getIds();
        for(String id: ids.split(",")) {
        	testUserService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
	
	/**
	 * 多数据源查询数据
	 */
	@RequestMapping(value="queryAll",method=RequestMethod.GET)
	public String queryAll(Model model, TestUser user){
		try {
			List<TestUser> listUser = testUserService.selectByProperties(user);
			model.addAttribute("listUser_db1", listUser);
			
			//切换数据源
			setDataSource("mysql");
			
			List<TestUser> listUser1 = testUserService.selectByProperties(user);
			logger.info(listUser1.toString());
			model.addAttribute("listUser_db2", listUser1);
			
		}finally{
			setDataSource("default");
		}
		return "demo/qita/dataSource";
	}

}
