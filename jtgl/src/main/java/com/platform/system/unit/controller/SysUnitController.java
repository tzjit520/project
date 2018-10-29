package com.platform.system.unit.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
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
import com.platform.system.unit.model.SysUnit;
import com.platform.system.unit.service.SysUnitService;
import com.platform.system.user.model.SysUser;

@Controller
@RequestMapping("api/v1/unit")
public class SysUnitController extends BaseController{

	@Autowired
	private SysUnitService unitService;
	
	@RequiresPermissions("unit:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysUnit unit, Model model) {
		List<SysUnit> list = unitService.selectByProperties(unit);
		model.addAttribute("list", list);
		model.addAttribute("unit", unit);
        return "platform/unit/list";
	}
	
	@RequiresPermissions("unit:view")
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Integer parentId, Model model) {
		SysUnit sysUnit = new SysUnit();
		//查询所有机构
		List<SysUnit> units = unitService.selectByProperties(new SysUnit());
		if(id != null && id.intValue() != 0){
			sysUnit = unitService.selectById(id);
			//过滤掉自己
			units = unitService.selectByProperties(new SysUnit(id, -2));
		}else{
			sysUnit.setParentId(parentId);
		}
		// 构建组织机构树
		List<SysUnit> rootUnits = new ArrayList<SysUnit>();
		for (SysUnit unit : units) {
			SysUnit parent = findParent(units, unit);
			if (parent != null) {
				parent.getChildrenListUnits().add(unit);
			}
		}
		// 只找到根节点的组织机构，将其加入rootUnits
		for (SysUnit unit : units) {
			if (unit.getParentId() == null) {
				rootUnits.add(unit);
			}
		}
		// 设定每个组织机构的深度 
		for (SysUnit rootUnit : rootUnits) {
			constuctUnitDepth(rootUnit, units);
		}
		List<SysUnit> result = new ArrayList<SysUnit>();
		// 遍历组织机构树，生成返回的List，根据组织机构的depth对组织机构名称进行添加空格处理
		// 先进行排序 
		Collections.sort(rootUnits);
		for (SysUnit unit: rootUnits) {			
			constuctUnits(result, unit);
		}
		model.addAttribute("unit", sysUnit);
		model.addAttribute("result", result);
		return "platform/unit/save";
	}
	
	/**
	 * 找到某个组织机构的父节点
	 */
	private SysUnit findParent(List<SysUnit> units, SysUnit unit) {
		if (unit.getParentId() == null) {
			return null;
		} else {
			for (SysUnit tempUnit : units) {
				if (unit.getParentId().intValue() == tempUnit.getId().intValue()) {
					return tempUnit;
				}
			}
		}
		return null;
	}
	
	/**
	 * 设置组织机构的深度
	 * @param unit
	 * @param units
	 */
	private void constuctUnitDepth(SysUnit unit, List<SysUnit> units) {
		if (unit.getParentId() == null) {
			unit.setDepth(1);
		} else {
			SysUnit parentUnit = this.findParent(units, unit);
			unit.setDepth(parentUnit.getDepth() + 1);
		}
		for (SysUnit childUnit: unit.getChildrenListUnits()) {			
			constuctUnitDepth(childUnit, units);
		}
	}
	
	/**
	 * 构建组织机构列表，组织机构的名称体现了组织机构的层级关系(通过空格)
	 * @param result
	 * @param unit
	 */
	private void constuctUnits(List<SysUnit> result, SysUnit unit) {
		int blankCount = unit.getDepth()-1;
		String blankStr = "";
		for (int i = 0; i < blankCount; i++) {
			blankStr = blankStr + "----";
		}
		unit.setName(blankStr + unit.getName());
		result.add(unit);
		Collections.sort(unit.getChildrenListUnits());
		for (SysUnit childUnit: unit.getChildrenListUnits()) {			
			constuctUnits(result, childUnit);
		}
	}
	
	@RequestMapping(value = "unique", method = RequestMethod.GET)
	public @ResponseBody Boolean unique(SysUnit searchVo) {
		List<SysUnit> list = unitService.selectByUnique(searchVo);
		if (list != null && list.size() > 0) {
			for (SysUnit unit : list) {
				if (unit.getId() == null || searchVo.getId().intValue() != unit.getId().intValue()) {
					return false;
				}
			}
		}
		return true;
	}
	
	@RequiresPermissions("unit:view")
	@RequestMapping(value = "all", method = RequestMethod.GET)
	public @ResponseBody Result<List<SysUnit>> all(SysUnit searchVo) {
		List<SysUnit> list = unitService.selectByProperties(searchVo);
		return new ResultBuilder<List<SysUnit>>().data(list).build();
	}

	@RequiresPermissions("unit:view")
	@RequestMapping(value = "treeData", method = RequestMethod.GET)
	public @ResponseBody Result<List<Map<String,Object>>> treeData(SysUnit searchVo) {
		List<SysUnit> list = unitService.selectByProperties(searchVo);
		List<Map<String,Object>> listParentNodesMap = new ArrayList<Map<String,Object>>();
		//初始化父节点
		for (SysUnit sysUnit : list) {
			if(sysUnit.getParentId() != null){
				continue;
			}
			Map<String,Object> parentNodeMap = new HashMap<String, Object>();
			parentNodeMap.put("id", sysUnit.getId());
			parentNodeMap.put("text", sysUnit.getName());
			parentNodeMap.put("type", "parent");
			//子节点
			List<Map<String,Object>> listNodesMap = new ArrayList<Map<String,Object>>();
			for (SysUnit childUnit : list) {
				if(childUnit.getParentId() != null && childUnit.getParentId().intValue() == sysUnit.getId()){
					Map<String,Object> nodes = new HashMap<String, Object>();
					nodes.put("id", childUnit.getId());
					nodes.put("text", childUnit.getName());
					nodes.put("type", "child");
					listNodesMap.add(nodes);
				}
			}
			parentNodeMap.put("nodes", listNodesMap);
			listParentNodesMap.add(parentNodeMap);
		}
		return new ResultBuilder<List<Map<String,Object>>>().data(listParentNodesMap).build();
	}
	
	@RequiresPermissions("unit:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysUnit unit, Model model){
		unitService.save(unit);
		return "redirect:/api/v1/unit";
	}
	
	@RequiresPermissions("unit:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysUnit unit,Model model){
		unitService.update(unit);
		return "redirect:/api/v1/unit";
	}
	
	@RequiresPermissions("unit:delete")
	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		unitService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}
	
	@RequiresPermissions("unit:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysUser sysUser) {
        String ids = sysUser.getIds();
        for(String id: ids.split(",")) {
        	unitService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
}
