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

import com.jtgl.draw.model.DrawPrize;
import com.jtgl.draw.service.DrawPrizeService;

@Controller
@RequestMapping("/api/v1/drawPrize")
public class DrawPrizeController extends BaseController {
	
	@Autowired
	private DrawPrizeService drawPrizeService;

    // 根据属性分页查询数据
	@RequiresPermissions("draw:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(DrawPrize searchVo, Model model) throws Exception {
		PageModel<DrawPrize> page = drawPrizeService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("drawPrize", searchVo);
		return "jtgl/drawPrize/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("draw:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<DrawPrize>> findAll(DrawPrize searchVo) throws Exception {
		return new ResultBuilder<List<DrawPrize>>().data(drawPrizeService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("draw:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		DrawPrize drawPrize = new DrawPrize();
		if(id != null && id != 0){
			drawPrize = drawPrizeService.selectById(id);
		}
		model.addAttribute("drawPrize", drawPrize);
		return "jtgl/drawPrize/save";
	}

	// 唯一性校验
    @RequiresPermissions("draw:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(DrawPrize searchVo) {
        List<DrawPrize> list = drawPrizeService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(DrawPrize drawPrize:list) {
                if(searchVo.getId() == null||drawPrize.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("draw:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(DrawPrize drawPrize) {
		drawPrizeService.save(drawPrize);
		return "redirect:/api/v1/drawPrize";
	}
	
	// 更新数据
	@RequiresPermissions("draw:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(DrawPrize drawPrize) {
		drawPrizeService.updateNotNull(drawPrize);
		return "redirect:/api/v1/drawPrize";
	}
	
	// 删除数据
	@RequiresPermissions("draw:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		drawPrizeService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("draw:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(DrawPrize drawPrize) {
        String ids = drawPrize.getIds();
        for(String id : ids.split(",")) {
            drawPrizeService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
