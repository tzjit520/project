package com.jtgl.customer.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jtgl.customer.model.Customer;
import com.jtgl.customer.model.CustomerAddress;
import com.jtgl.customer.service.CustomerAddressService;
import com.jtgl.customer.service.CustomerService;
import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;

@Controller
@RequestMapping("/api/v1/address")
public class CustomerAddressController extends BaseController {
	
	@Autowired
	private CustomerAddressService customerAddressService;
	
	@Autowired
	private CustomerService customerService;

    // 根据属性分页查询数据
	@RequiresPermissions("customer:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(CustomerAddress searchVo, Model model) throws Exception {
		PageModel<CustomerAddress> page = customerAddressService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("customerAddress", searchVo);
		return "jtgl/customer/address/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("customer:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<CustomerAddress>> findAll(CustomerAddress searchVo) throws Exception {
		return new ResultBuilder<List<CustomerAddress>>().data(customerAddressService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("customer:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		CustomerAddress customerAddress = new CustomerAddress();
		if(id != null && id != 0){
			customerAddress = customerAddressService.selectById(id);
		}
		model.addAttribute("customerAddress", customerAddress);
		model.addAttribute("listCustomer", customerService.selectByProperties(new Customer()));
		return "jtgl/customer/address/save";
	}

	// 唯一性校验
    @RequiresPermissions("customer:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(CustomerAddress searchVo) {
        List<CustomerAddress> list = customerAddressService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(CustomerAddress customerAddress:list) {
                if(searchVo.getId() == null||customerAddress.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("customer:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(CustomerAddress customerAddress) {
		customerAddressService.save(customerAddress);
		return "redirect:/api/v1/address";
	}
	
	// 更新数据
	@RequiresPermissions("customer:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(CustomerAddress customerAddress) {
		customerAddressService.updateNotNull(customerAddress);
		return "redirect:/api/v1/address";
	}
	
	// 删除数据
	@RequiresPermissions("customer:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		customerAddressService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("customer:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(CustomerAddress customerAddress) {
        String ids = customerAddress.getIds();
        for(String id : ids.split(",")) {
            customerAddressService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
