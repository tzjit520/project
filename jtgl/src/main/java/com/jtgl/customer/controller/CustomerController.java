package com.jtgl.customer.controller;

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

import com.jtgl.customer.model.Customer;
import com.jtgl.customer.service.CustomerService;

@Controller
@RequestMapping("/api/v1/customer")
public class CustomerController extends BaseController {
	
	@Autowired
	private CustomerService customerService;

    // 根据属性分页查询数据
	@RequiresPermissions("customer:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(Customer searchVo, Model model) throws Exception {
		PageModel<Customer> page = customerService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("customer", searchVo);
		return "jtgl/customer/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("customer:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<Customer>> findAll(Customer searchVo) throws Exception {
		return new ResultBuilder<List<Customer>>().data(customerService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("customer:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		Customer customer = new Customer();
		if(id != null && id != 0){
			customer = customerService.selectById(id);
		}
		model.addAttribute("customer", customer);
		return "jtgl/customer/save";
	}

	// 唯一性校验
    @RequiresPermissions("customer:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(Customer searchVo) {
        List<Customer> list = customerService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(Customer customer:list) {
                if(searchVo.getId() == null||customer.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("customer:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(Customer customer) {
		customerService.save(customer);
		return "redirect:/api/v1/customer";
	}
	
	// 更新数据
	@RequiresPermissions("customer:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(Customer customer) {
		customerService.updateNotNull(customer);
		return "redirect:/api/v1/customer";
	}
	
	// 删除数据
	@RequiresPermissions("customer:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		customerService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("customer:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(Customer customer) {
        String ids = customer.getIds();
        for(String id : ids.split(",")) {
            customerService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
