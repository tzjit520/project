package com.jtgl.item.controller;

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

import com.jtgl.item.model.ItemType;
import com.jtgl.item.service.ItemTypeService;

@Controller
@RequestMapping("/api/v1/itemType")
public class ItemTypeController extends BaseController {
	
	@Autowired
	private ItemTypeService itemTypeService;

    // 根据属性分页查询数据
	@RequiresPermissions("item:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(ItemType searchVo, Model model) throws Exception {
		PageModel<ItemType> page = itemTypeService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("itemType", searchVo);
		return "jtgl/item/type/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("item:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<ItemType>> findAll(ItemType searchVo) throws Exception {
		return new ResultBuilder<List<ItemType>>().data(itemTypeService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("item:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		ItemType itemType = new ItemType();
		if(id != null && id != 0){
			itemType = itemTypeService.selectById(id);
		}
		model.addAttribute("itemType", itemType);
		return "jtgl/item/type/save";
	}

	// 唯一性校验
    @RequiresPermissions("item:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(ItemType searchVo) {
        List<ItemType> list = itemTypeService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(ItemType itemType:list) {
                if(searchVo.getId() == null||itemType.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("item:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(ItemType itemType) {
		itemTypeService.save(itemType);
		return "redirect:/api/v1/itemType";
	}
	
	// 更新数据
	@RequiresPermissions("item:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(ItemType itemType) {
		itemTypeService.updateNotNull(itemType);
		return "redirect:/api/v1/itemType";
	}
	
	// 删除数据
	@RequiresPermissions("item:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		itemTypeService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("item:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(ItemType itemType) {
        String ids = itemType.getIds();
        for(String id : ids.split(",")) {
            itemTypeService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
