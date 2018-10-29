package ${package}.controller;

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

import ${package}.model.${ClassName};
import ${package}.service.${ClassName}Service;

@Controller
@RequestMapping("/api/v1/${className}")
public class ${ClassName}Controller extends BaseController {
	
	@Autowired
	private ${ClassName}Service ${className}Service;

    // 根据属性分页查询数据
	@RequiresPermissions("${className}:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(${ClassName} searchVo, Model model) throws Exception {
		PageModel<${ClassName}> page = ${className}Service.selectByPage(searchVo);
		model.addAttribute("page", page);
		model.addAttribute("${ClassName}", searchVo);
		return "${className}/list";
	}
	
	// 根据属性查询所有数据，不分页
	@RequiresPermissions("${className}:view")
	@RequestMapping(value="all",method = RequestMethod.GET)
	public @ResponseBody Result<List<${ClassName}>> findAll(${ClassName} searchVo) throws Exception {
		return new ResultBuilder<List<${ClassName}>>().data(${className}Service.selectByProperties(searchVo)).build();
	}
	
	// 根据ID查询数据
	@RequiresPermissions("${className}:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		${ClassName} ${ClassName} = new ${ClassName}();
		if(id != null && id != 0){
			${ClassName} = ${className}Service.selectById(id);
		}
		model.addAttribute("${ClassName}", ${ClassName});
		return "${className}/save";
	}

	// 唯一性校验
    @RequiresPermissions("${className}:view")
    @RequestMapping(value="unique",method = RequestMethod.GET)
    public @ResponseBody Boolean unique(${ClassName} searchVo) {
        List<${ClassName}> list = ${className}Service.selectByUnique(searchVo);
        if(list != null && list.size() > 0) {
            for(${ClassName} ${className}:list) {
                if(searchVo.getId() == null||${className}.getId().intValue() != searchVo.getId().intValue()) {
                    return false;
                }
            }
        }
        return true;
    }
	
	// 保存数据
	@RequiresPermissions("${className}:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(${ClassName} ${className}) {
		${className}Service.save(${className});
		return "redirect:/api/v1/${className}";
	}
	
	// 更新数据
	@RequiresPermissions("${className}:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(${ClassName} ${className}) {
		${className}Service.updateNotNull(${className});
		return "redirect:/api/v1/${className}";
	}
	
	// 删除数据
	@RequiresPermissions("${className}:delete")
	@RequestMapping(value="{id}",method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		${className}Service.delete(id);
		return new ResultBuilder<String>().data("").build();
	}

    // 批量删除数据
	@RequiresPermissions("${className}:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(${ClassName} ${className}) {
        String ids = ${className}.getIds();
        for(String id : ids.split(",")) {
            ${className}Service.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

}
