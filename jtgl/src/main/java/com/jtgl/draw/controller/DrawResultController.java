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

import com.jtgl.draw.model.DrawResult;
import com.jtgl.draw.service.DrawResultService;

@Controller
@RequestMapping("/api/v1/drawResult")
public class DrawResultController extends BaseController {
	
	@Autowired
	private DrawResultService drawResultService;

    // 根据属性分页查询数据
	@RequiresPermissions("draw:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(DrawResult searchVo, Model model) throws Exception {
		PageModel<DrawResult> page = drawResultService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("drawResult", searchVo);
		return "drawResult/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("draw:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<DrawResult>> findAll(DrawResult searchVo) throws Exception {
		return new ResultBuilder<List<DrawResult>>().data(drawResultService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("draw:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		DrawResult drawResult = new DrawResult();
		if(id != null && id != 0){
			drawResult = drawResultService.selectById(id);
		}
		model.addAttribute("drawResult", drawResult);
		return "drawResult/save";
	}

	// 唯一性校验
    @RequiresPermissions("draw:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(DrawResult searchVo) {
        List<DrawResult> list = drawResultService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(DrawResult drawResult:list) {
                if(searchVo.getId() == null||drawResult.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("draw:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(DrawResult drawResult) {
		drawResultService.save(drawResult);
		return "redirect:/api/v1/drawResult";
	}
	
	// 更新数据
	@RequiresPermissions("draw:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(DrawResult drawResult) {
		drawResultService.updateNotNull(drawResult);
		return "redirect:/api/v1/drawResult";
	}
	
	// 删除数据
	@RequiresPermissions("draw:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		drawResultService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("draw:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(DrawResult drawResult) {
        String ids = drawResult.getIds();
        for(String id : ids.split(",")) {
            drawResultService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
