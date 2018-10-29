package com.jtgl.item.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jtgl.item.model.Item;
import com.jtgl.item.model.ItemType;
import com.jtgl.item.service.ItemService;
import com.jtgl.item.service.ItemTypeService;
import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;

@Controller
@RequestMapping("/api/v1/item")
public class ItemController extends BaseController {
	
	@Autowired
	private ItemService itemService;
	
	@Autowired
	private ItemTypeService itemTypeService;

    // 根据属性分页查询数据
	@RequiresPermissions("item:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(Item searchVo, Model model) throws Exception {
		PageModel<Item> page = itemService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("item", searchVo);
		return "jtgl/item/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("item:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<Item>> findAll(Item searchVo) throws Exception {
		return new ResultBuilder<List<Item>>().data(itemService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("item:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		Item item = new Item();
		if(id != null && id != 0){
			item = itemService.selectById(id);
		}
		model.addAttribute("item", item);
		model.addAttribute("listItemType", itemTypeService.selectByProperties(new ItemType()));
		return "jtgl/item/save";
	}

	// 唯一性校验
    @RequiresPermissions("item:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(Item searchVo) {
        List<Item> list = itemService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(Item item:list) {
                if(searchVo.getId() == null||item.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("item:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(Item item) {
		itemService.save(item);
		return "redirect:/api/v1/item";
	}
	
	// 更新数据
	@RequiresPermissions("item:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(Item item) {
		itemService.updateNotNull(item);
		return "redirect:/api/v1/item";
	}
	
	// 删除数据
	@RequiresPermissions("item:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		itemService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("item:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(Item item) {
        String ids = item.getIds();
        for(String id : ids.split(",")) {
            itemService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
