package com.platform.system.dbobject.controller;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;
import com.platform.system.dbobject.model.SysDbObject;
import com.platform.system.dbobject.service.SysDbObjectService;

@Controller
@RequestMapping("/api/v1/dbobject")
public class SysDbObjectController extends BaseController {

	@Autowired
	private SysDbObjectService dbObjectService;
	
	@RequiresPermissions("dbObject:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysDbObject sysDbObject, Model model) throws Exception {
		PageModel<SysDbObject> page = dbObjectService.selectByPage(sysDbObject);
		model.addAttribute("page", page);
		model.addAttribute("dbobject", sysDbObject);
		return "platform/dbobject/list";
	}
	
	@RequiresPermissions("dbObject:view")
	@RequestMapping(value="{id}",method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		SysDbObject sysDbObject = new SysDbObject();
		if(id != null && id.intValue() != 0){
			sysDbObject = dbObjectService.selectById(id);
		}
		model.addAttribute("dbobject", sysDbObject);
		return "platform/dbobject/save";
	}

	@RequiresPermissions("dbObject:view")
	@RequestMapping(value="translate",method = RequestMethod.GET)
	public @ResponseBody Result<List<Map<String,Object>>> translateBySql(SysDbObject searchVo) throws Exception {
		List<Map<String,Object>> list = dbObjectService.getTranslateList(searchVo);
		return new ResultBuilder<List<Map<String,Object>>>().data(list).build();
	}

    @RequiresPermissions("dbObject:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(SysDbObject searchVo) {
        List<SysDbObject> list = dbObjectService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(SysDbObject sysDbObject:list) {
                if(searchVo.getId() == null || sysDbObject.getId().intValue()!=searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	@RequiresPermissions("dbObject:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysDbObject sysDbObject) {
		dbObjectService.save(sysDbObject);
		return "redirect:/api/v1/dbobject";
	}
	
	@RequiresPermissions("dbObject:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysDbObject sysDbObject) {
		dbObjectService.updateNotNull(sysDbObject);
		return "redirect:/api/v1/dbobject";
	}
	
	@RequiresPermissions("dbObject:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		dbObjectService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

	@RequiresPermissions("dbObject:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysDbObject sysDbObject) {
        String ids = sysDbObject.getIds();
        for(String id:ids.split(",")) {
            dbObjectService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
}
