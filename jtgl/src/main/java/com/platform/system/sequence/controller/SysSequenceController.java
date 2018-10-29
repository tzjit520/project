package com.platform.system.sequence.controller;

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

import com.platform.system.sequence.model.SysSequence;
import com.platform.system.sequence.service.SysSequenceService;

@Controller
@RequestMapping("/api/v1/sequence")
public class SysSequenceController extends BaseController {
	
	@Autowired
	private SysSequenceService sequenceService;

    // 根据属性分页查询数据
	@RequiresPermissions("sequence:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysSequence sequence, Model model) throws Exception {
		PageModel<SysSequence> page = sequenceService.selectByPage(sequence);
		model.addAttribute("page", page);
		model.addAttribute("sequence", sequence);
		return "platform/sequence/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("sequence:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<SysSequence>> findAll(SysSequence sequence) throws Exception {
		return new ResultBuilder<List<SysSequence>>().data(sequenceService.selectByProperties(sequence)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("sequence:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		SysSequence sequence = new SysSequence();
		if(id != null && id != 0){
			sequence = sequenceService.selectById(id);
		}
		model.addAttribute("sequence", sequence);
		return "platform/sequence/save";
	}

	// 唯一性校验
    @RequiresPermissions("sequence:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(SysSequence sequence) {
        List<SysSequence> list = sequenceService.selectByUnique(sequence);
        if(list != null && list.size() > 0) {
            for(SysSequence sysSequence:list) {
                if(sequence.getId() == null||sysSequence.getId().intValue() != sequence.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
    //获取序列
 	@RequestMapping(value="getCode", method = RequestMethod.GET)
 	public @ResponseBody Result<String> getCode(String code) throws Exception {
 		return new ResultBuilder<String>().data(sequenceService.getCode(code)).build();
 	}
 	
	// 保存数据
	@RequiresPermissions("sequence:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysSequence sysSequence) {
		sequenceService.save(sysSequence);
		return "redirect:/api/v1/sequence";
	}
	
	// 更新数据
	@RequiresPermissions("sequence:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysSequence sequence) {
		sequenceService.updateNotNull(sequence);
		return "redirect:/api/v1/sequence";
	}
	
	// 删除数据
	@RequiresPermissions("sequence:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		sequenceService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("sequence:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysSequence sequence) {
        String ids = sequence.getIds();
        for(String id : ids.split(",")) {
            sequenceService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
