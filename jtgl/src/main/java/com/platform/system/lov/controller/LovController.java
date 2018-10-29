package com.platform.system.lov.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.ehcache.EhCacheManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.common.constants.CommonConstants;
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
@RequestMapping("/api/v1/lov")
public class LovController extends BaseController {

	@Autowired
	private SysLovService lovService;
	
	@Autowired
    private SysLovLineService lovLineService;

	@Autowired
	private EhCacheManager ehCacheManager;
	
	@RequiresPermissions("lov:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysLov sysLov, Model model) throws Exception {
		PageModel<SysLov> page = lovService.selectByPage(sysLov);
		model.addAttribute("lov", sysLov);
		model.addAttribute("page", page);
		return "platform/lov/list";
	}
	
	@RequestMapping(value="getLov", method = RequestMethod.GET)
	public @ResponseBody Result<SysLov> getLov(String code) throws Exception {
		return new ResultBuilder<SysLov>().data(LovUtils.getLov(code)).build();
	}
	
	@RequiresPermissions("lov:view")
	@RequestMapping(value="{id}",method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		SysLov sysLov = new SysLov();
		if(id != null && id.intValue() != 0){
			sysLov = lovService.selectById(id);
		}
		model.addAttribute("lov", sysLov);
		return "platform/lov/save";
	}

	@RequiresPermissions("lov:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<SysLov>> findAll(SysLov searchVo) throws Exception {
		return new ResultBuilder<List<SysLov>>().data(lovService.selectByProperties(searchVo)).build();
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value="global",method = RequestMethod.GET)
	public Result<Map<String,List<Map<String,Object>>>> findGlobal(SysLov searchVo) throws Exception {
		Cache cache = ehCacheManager.getCache(CommonConstants.LOV_CACHE_NAME);
		if(cache.keys().contains(CommonConstants.LOV_CACHE_NAME)) {
			return new ResultBuilder<Map<String,List<Map<String,Object>>>>().data((Map<String,List<Map<String,Object>>>)cache.get(CommonConstants.LOV_CACHE_NAME)).build();
		}
		else {
			return new ResultBuilder<Map<String,List<Map<String,Object>>>>().data(lovService.findGlobal(searchVo)).build();
		}
	}

	@RequiresPermissions("lov:view")
	@RequestMapping(value="tree",method = RequestMethod.GET)
	//将数据库的菜单表做排序处理，排序考虑到了层级关系 gird会根据parentid 来计算深度
	public @ResponseBody Result<List<SysLov>> findTree(SysLov searchVo) throws Exception {
		List<SysLov> finalList = new ArrayList<SysLov>();
		List<SysLov> list = lovService.selectByProperties(searchVo);
		List<SysLovLine> lovLineList  = lovLineService.selectByProperties(new SysLovLine());
		for(SysLov sysLov:list) {
			//设置树的深度 因为前台无法通过id做判断 父子是不同的表 id有可能重复
			sysLov.setDepth(0);
			finalList.add(sysLov);
			for(SysLovLine sysLovLine : lovLineList) {
				//因为表格中 树展开的下一层是 sysLovLine而非sysLov 为了让grid识别 转换成sysLov
				if(sysLovLine.getLovId().intValue() == sysLov.getId().intValue()) {
					SysLov sysLovChange = new SysLov();
					sysLovChange.setId(sysLovLine.getId());
					sysLovChange.setName(sysLovLine.getName());
					sysLovChange.setCode(sysLovLine.getCode());
					//深度设置为-1 代表最底层
					sysLovChange.setDepth(-1);
					finalList.add(sysLovChange);
				}
			}
		}
		return new ResultBuilder<List<SysLov>>().data(finalList).build();
	}

    @RequiresPermissions("lov:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(SysLov searchVo) {
        List<SysLov> list = lovService.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(SysLov sysLov:list) {
                if(searchVo.getId() == null || sysLov.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	@RequiresPermissions("lov:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysLov sysLov) {
		lovService.saveLov(sysLov);
		return "redirect:/api/v1/lov";
	}
	
	@RequiresPermissions("lov:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysLov sysLov) {
		lovService.updateLov(sysLov);
		return "redirect:/api/v1/lov";
	}
	
	@RequiresPermissions("lov:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		lovLineService.deleteByLovId(id);
		lovService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

	@RequiresPermissions("lov:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysLov sysLov) {
        String ids = sysLov.getIds();
        for(String id:ids.split(",")) {
        	lovLineService.deleteByLovId(Integer.parseInt(id));
            lovService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
}
