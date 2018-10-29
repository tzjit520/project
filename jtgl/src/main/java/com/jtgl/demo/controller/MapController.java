package com.jtgl.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jtgl.demo.model.Map;
import com.jtgl.demo.service.MapService;
import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;

@Controller
@RequestMapping("/api/v1/map")
public class MapController extends BaseController {
	
	@Autowired
	private MapService mapService;

    // 根据属性分页查询数据
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(Map map, Model model) throws Exception {
		PageModel<Map> page = mapService.selectByPage(map);
		model.addAttribute("map", map);
		model.addAttribute("page", page);
		return "demo/map/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequestMapping(value="all",method = RequestMethod.GET)
	public Result<List<Map>> findAll(Map searchVo) throws Exception {
		return new ResultBuilder<List<Map>>().data(mapService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		Map map = new Map();
		if(id != null && id != 0){
			map = mapService.selectById(id);
		}
		model.addAttribute("map", map);
		return "demo/map/save";
	}

	// 唯一性校验
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public Boolean unique(Map searchVo) {
        List<Map> list = mapService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(Map map:list) {
                if(searchVo.getId() == null||map.getId().intValue() != searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	// 保存数据
	@RequestMapping(method = RequestMethod.POST)
	public String save(Map map) {
		mapService.save(map);
		return "redirect:/api/v1/map";
	}
	
	// 更新数据
	@RequestMapping(method = RequestMethod.PUT)
	public String update(Map map) {
		mapService.updateNotNull(map);
		return "redirect:/api/v1/map";
	}
	
	// 删除数据
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		mapService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(Map map) {
        String ids = map.getIds();
        for(String id : ids.split(",")) {
            mapService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
