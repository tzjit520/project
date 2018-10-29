package com.jtgl.draw.controller;

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

import com.jtgl.draw.model.DrawFrequency;
import com.jtgl.draw.service.DrawFrequencyService;

@Controller
@RequestMapping("/api/v1/drawFrequency")
public class DrawFrequencyController extends BaseController {
	
	@Autowired
	private DrawFrequencyService drawFrequencyService;

    // 根据属性分页查询数据
	@RequiresPermissions("draw:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(DrawFrequency searchVo, Model model) throws Exception {
		PageModel<DrawFrequency> page = drawFrequencyService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("drawFrequency", searchVo);
		return "jtgl/drawFrequency/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("draw:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<DrawFrequency>> findAll(DrawFrequency searchVo) throws Exception {
		return new ResultBuilder<List<DrawFrequency>>().data(drawFrequencyService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("draw:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		DrawFrequency drawFrequency = new DrawFrequency();
		if(id != null && id != 0){
			drawFrequency = drawFrequencyService.selectById(id);
		}
		model.addAttribute("drawFrequency", drawFrequency);
		return "jtgl/drawFrequency/save";
	}

	// 唯一性校验
    @RequiresPermissions("draw:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(DrawFrequency searchVo) {
        List<DrawFrequency> list = drawFrequencyService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(DrawFrequency drawFrequency:list) {
                if(searchVo.getId() == null||drawFrequency.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("draw:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(DrawFrequency drawFrequency) {
		drawFrequencyService.save(drawFrequency);
		return "redirect:/api/v1/drawFrequency";
	}
	
	// 更新数据
	@RequiresPermissions("draw:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(DrawFrequency drawFrequency) {
		drawFrequencyService.updateNotNull(drawFrequency);
		return "redirect:/api/v1/drawFrequency";
	}
	
	// 删除数据
	@RequiresPermissions("draw:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		drawFrequencyService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("draw:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(DrawFrequency drawFrequency) {
        String ids = drawFrequency.getIds();
        for(String id : ids.split(",")) {
            drawFrequencyService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
