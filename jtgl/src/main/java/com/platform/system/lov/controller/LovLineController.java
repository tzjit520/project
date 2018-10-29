package com.platform.system.lov.controller;

import java.util.List;

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
import com.platform.system.lov.model.SysLov;
import com.platform.system.lov.model.SysLovLine;
import com.platform.system.lov.service.SysLovLineService;
import com.platform.system.lov.service.SysLovService;
import com.platform.utils.LovUtils;

@Controller
@RequestMapping("/api/v1/lovLine")
public class LovLineController extends BaseController {

	@Autowired
	private SysLovLineService lovLineService;
	
	@Autowired
	private SysLovService lovService;
	
	@RequiresPermissions("lovLine:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysLovLine sysLovLine, Model model) throws Exception {
		PageModel<SysLovLine> page = lovLineService.selectByPage(sysLovLine);
		model.addAttribute("lovLine", sysLovLine);
		model.addAttribute("page", page);
		model.addAttribute("lovList", lovService.selectByProperties(new SysLov()));
		return "platform/lovline/list";
	}

	@RequestMapping(value="getLovLine", method = RequestMethod.GET)
	public @ResponseBody Result<List<SysLovLine>> getLovLine(String code) throws Exception {
		return new ResultBuilder<List<SysLovLine>>().data(LovUtils.getLineList(code)).build();
	}
	
	@RequiresPermissions("lovLine:view")
    @RequestMapping(value="all",method = RequestMethod.GET)
    public @ResponseBody Result<List<SysLovLine>> findAll(SysLovLine searchVo) throws Exception {
		List<SysLovLine> list = lovLineService.selectAll(searchVo);
		return new ResultBuilder<List<SysLovLine>>().data(list).build();
	}

	@RequiresPermissions("lovLine:view")
	@RequestMapping(value="{id}",method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		SysLovLine sysLovLine = new SysLovLine();
		if(id != null && id.intValue() != 0){
			sysLovLine = lovLineService.selectById(id);
		}
		model.addAttribute("lovList", lovService.selectByProperties(new SysLov()));
		model.addAttribute("lovLine", sysLovLine);
		return "platform/lovline/save";
	}

    @RequiresPermissions("lovLine:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(SysLovLine searchVo) {
        List<SysLovLine> list = lovLineService.selectByUnique(searchVo);
        if(list!=null&&list.size()>0) {
            for(SysLovLine sysLovLine:list) {
                if(searchVo.getId()==null||sysLovLine.getId().intValue()!=searchVo.getId().intValue()) {
                    return true;
                }
            }
        }
        return false;
    }
	
	@RequiresPermissions("lovLine:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysLovLine sysLovLine) {
		lovLineService.save(sysLovLine);
		return "redirect:/api/v1/lovLine";
	}
	
	@RequiresPermissions("lovLine:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysLovLine sysLovLine) {
		lovLineService.updateNotNull(sysLovLine);
		return "redirect:/api/v1/lovLine";
	}
	
	@RequiresPermissions("lovLine:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		lovLineService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

	@RequiresPermissions("lovLine:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysLovLine sysLovLine) {
        String ids = sysLovLine.getIds();
        for(String id:ids.split(",")) {
            lovLineService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
	
}
