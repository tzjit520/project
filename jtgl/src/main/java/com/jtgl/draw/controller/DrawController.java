package com.jtgl.draw.controller;

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

import com.jtgl.draw.constants.StatusConstants;
import com.jtgl.draw.model.Draw;
import com.jtgl.draw.service.DrawPrizeService;
import com.jtgl.draw.service.DrawResultService;
import com.jtgl.draw.service.DrawService;
import com.platform.common.exception.CommonException;
import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;
import com.platform.system.user.model.SysUser;
import com.platform.utils.UserUtils;

@Controller
@RequestMapping("/api/v1/draw")
public class DrawController extends BaseController {
	
	@Autowired
	private DrawService drawService;

	@Autowired
	private DrawResultService drawResultService;
	
	@Autowired
	private DrawPrizeService drawPrizeService;
	
    // 根据属性分页查询数据
	@RequiresPermissions("draw:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(Draw searchVo, Model model) throws Exception {
		PageModel<Draw> page = drawService.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("draw", searchVo);
		return "jtgl/draw/list";
	}
	
	//跳转到转盘页面
	@RequiresPermissions("draw:view")
	@RequestMapping(value="turntable", method = RequestMethod.GET)
	public String turntable(Model model) throws Exception {
		return "jtgl/draw/turntable";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("draw:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<Draw>> findAll(Draw searchVo) throws Exception {
		return new ResultBuilder<List<Draw>>().data(drawService.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("draw:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		Draw draw = new Draw();
		if(id != null && id != 0){
			draw = drawService.selectById(id);
		}
		model.addAttribute("draw", draw);
		return "jtgl/draw/save";
	}

	// 唯一性校验
    @RequiresPermissions("draw:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(Draw searchVo) {
        List<Draw> list = drawService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(Draw draw:list) {
                if(searchVo.getId() == null||draw.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("draw:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(Draw draw) {
		drawService.save(draw);
		return "redirect:/api/v1/draw";
	}
	
	// 更新数据
	@RequiresPermissions("draw:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(Draw draw) {
		drawService.updateNotNull(draw);
		return "redirect:/api/v1/draw";
	}
	
	// 删除数据
	@RequiresPermissions("draw:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		drawService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("draw:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(Draw draw) {
        String ids = draw.getIds();
        for(String id : ids.split(",")) {
            drawService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

	/**
	 * 客户抽奖
	 */
	@RequestMapping(value = "luckDraw", method = RequestMethod.GET)
	public @ResponseBody Result<String> luckDraw(){
		try {
			//奖项名称
			String prizeName = drawService.luckDraw();
			return new ResultBuilder<String>().data(prizeName).build();
		} catch (CommonException e) {
			return new ResultBuilder<String>().message(e.getCode(),e.getMessage()).build();
		}
	}
	
	/**
	 * 检查客户的抽奖剩余次数  
	 */
	@RequestMapping(value = "checkSurplusFrequency", method = RequestMethod.GET)
	public @ResponseBody Result<Integer> checkSurplusFrequency(){
		//当前有效的抽奖信息
		Draw draw = drawService.selectOne();
		if(draw == null){
			//无效的抽奖(该活动或已下线)
			return new ResultBuilder<Integer>().message(StatusConstants.DRAW_XX_INVALID,StatusConstants.DRAW_XX_INVALID_MSG).build();
		}
		//当前用户
		SysUser user = UserUtils.getUser();
		//剩余次数
		int remainNumber = drawService.checkSurplusFrequency(draw.getId(), user.getId());
		return new ResultBuilder<Integer>().data(remainNumber).build();
	}
	
	/**
	 * 根据用户Id所获得的奖品及数量信息  
	 */
	@RequestMapping(value = "queryPrize", method = RequestMethod.GET)
	public @ResponseBody Result<List<Map<String, Object>>> queryPrize(){
		//当前用户
		SysUser user = UserUtils.getUser();
		List<Map<String, Object>> listPrize = drawResultService.selectPrizeByUserId(user.getId());
		return new ResultBuilder<List<Map<String, Object>>>().data(listPrize).build();
	}
	
	/**
	 * 查询奖项对应的奖品信息  
	 */
	@RequestMapping(value = "queryPrizeItem", method = RequestMethod.GET)
	public @ResponseBody Result<List<Map<String, Object>>> queryPrizeItem(){
		//当前有效的抽奖信息
		Draw draw = drawService.selectOne();
		if(draw == null){
			//无效的抽奖(该活动或已下线)
			return new ResultBuilder<List<Map<String, Object>>>().message(StatusConstants.DRAW_XX_INVALID,StatusConstants.DRAW_XX_INVALID_MSG).build();
		}
		List<Map<String, Object>> listPrizeItem = drawPrizeService.selectPrizeItem(draw.getId());
		return new ResultBuilder<List<Map<String, Object>>>().data(listPrizeItem).build();
	}
	
	/**
	 * 根据抽奖基础信息ID  查询所有抽奖结果
	 */
	@RequestMapping(value = "queryAllDrawResult", method = RequestMethod.GET)
	public @ResponseBody Result<List<Map<String, Object>>> queryAllDrawResult(){
		//当前有效的抽奖信息
		Draw draw = drawService.selectOne();
		if(draw == null){
			//无效的抽奖(该活动或已下线)
			return new ResultBuilder<List<Map<String, Object>>>().message(StatusConstants.DRAW_XX_INVALID,StatusConstants.DRAW_XX_INVALID_MSG).build();
		}
		List<Map<String, Object>> listDrawResult = drawResultService.selectAllDrawResult(draw.getId());
		return new ResultBuilder<List<Map<String, Object>>>().data(listDrawResult).build();
	}
}
