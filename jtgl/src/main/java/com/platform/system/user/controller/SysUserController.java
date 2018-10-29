package com.platform.system.user.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.jtgl.demo.model.FileMeta;
import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;
import com.platform.system.role.model.SysRole;
import com.platform.system.role.service.SysRoleService;
import com.platform.system.unit.model.SysUnit;
import com.platform.system.unit.service.SysUnitService;
import com.platform.system.user.model.SysUser;
import com.platform.system.user.service.SysUserService;
import com.platform.utils.UserUtils;

@Controller
@RequestMapping("api/v1/user")
public class SysUserController extends BaseController{
	
	@Autowired
	private SysUserService userService;
	
	@Autowired
	private SysUnitService unitService;
	
	@Autowired
	private SysRoleService roleService;
	
	@Value("${uploadPath}")
	private String uploadPath;//上传文件的路径
	
	/**
     * 根据权限查询所有用户  
     * @param permission 例：tool:update|tool:add|...
     */
	@RequestMapping(value="getUserList", method = RequestMethod.GET)
	public @ResponseBody Result<List<SysUser>> getUserList(String permission, Model model) {
		if(StringUtils.isBlank(permission)) {
			return new ResultBuilder<List<SysUser>>().data(new ArrayList<SysUser>()).build();
		}
		List<SysUser> listUser = userService.selectUserListByPermission(permission);
		System.out.println("拥有["+permission+"]权限的用户有");
		for (SysUser user : listUser) {
			System.out.println(user.getCode()+"----:"+user.getName());
		}
		return new ResultBuilder<List<SysUser>>().data(listUser).build();
	}
	
	@RequiresPermissions("user:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysUser user, Model model) {
		PageModel<SysUser> page = userService.selectByPage(user);
		model.addAttribute("page", page);
		model.addAttribute("user", user);
        return "platform/user/list";
	}
	
	@RequiresPermissions("user:view")
	@RequestMapping(value="userIndex", method = RequestMethod.GET)
	public String iframe(SysUser user, Model model) {
        return "platform/user/userIndex";
	}
	
	@RequiresPermissions("user:view")
	@RequestMapping(value="profile", method = RequestMethod.GET)
	public String profile(Model model) {
		SysUser user = UserUtils.getUser();
		model.addAttribute("user", user);
        return "platform/user/profile";
	}
	
	@RequiresPermissions("user:view")
	@RequestMapping(value = "{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) {
		//部门集合
		List<SysUnit> listDept = new ArrayList<SysUnit>();
		SysUser user = new SysUser();
		if(id != 0){
			user = userService.selectById(id);
			if(user.getUnitId() != null && user.getUnitId().intValue() != 0){
				//根据公司id查询部门
				listDept = unitService.selectByProperties(new SysUnit(user.getUnitId()));
			}
			//用户所拥有的角色
			if(user.getRoleList() != null && user.getRoleList().size() > 0){
				user.setRoleId(user.getRoleList().get(0).getId());
			}
		}else{
			user.setLoginFlag(1);
		}
		Subject subject = SecurityUtils.getSubject();
		List<SysRole> listRoles = new ArrayList<SysRole>();
		if(!subject.hasRole("admin")){
			//不查询admin角色
			listRoles = roleService.selectRoleList("admin");
		}else{
			//查询所有的角色
			listRoles = roleService.selectRoleList(null);
		}
		//公司
		List<SysUnit> listCompany = unitService.selectByProperties(new SysUnit(0));
		model.addAttribute("user", user);
		model.addAttribute("listRoles", listRoles);
		model.addAttribute("listCompany", listCompany);
		model.addAttribute("listDept", listDept);
		return "platform/user/save";
	}
	
	@RequestMapping(value = "unique", method = RequestMethod.GET)
	public @ResponseBody Boolean unique(SysUser searchVo) {
		List<SysUser> list = userService.selectByUnique(searchVo);
		if (list != null && list.size() > 0) {
			for (SysUser user : list) {
				if (searchVo.getId() == null || searchVo.getId().intValue() != user.getId().intValue()) {
					return false;
				}
			}
		}
		return true;
	}
	
	@RequiresPermissions("user:view")
	@RequestMapping(value = "all", method = RequestMethod.GET)
	public @ResponseBody Result<List<SysUser>> all(SysUser searchVo) {
		List<SysUser> list = userService.selectByProperties(searchVo);
		return new ResultBuilder<List<SysUser>>().data(list).build();
	}
	
	@RequiresPermissions("user:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysUser user, Model model){
		userService.saveUser(user);
		return "redirect:/api/v1/user";
	}
	
	@RequiresPermissions("user:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysUser user,Model model){
		userService.updateUser(user);
		return "redirect:/api/v1/user";
	}
	
	@RequiresPermissions("user:update")
	@RequestMapping(value="changeInfo", method = RequestMethod.PUT)
	public @ResponseBody Result<String> changeInfo(SysUser user){
		userService.updateUser(user);
		return new ResultBuilder<String>().data("").build();
	}
	
	@RequiresPermissions("user:delete")
	@RequestMapping(value = "{id}", method = RequestMethod.DELETE)
	public @ResponseBody Result<String> delete(@PathVariable Integer id) {
		userService.delete(id);
		return new ResultBuilder<String>().data("").build();
	}
	
	@RequiresPermissions("user:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysUser sysUser) {
        String ids = sysUser.getIds();
        for(String id: ids.split(",")) {
            userService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }
    
    @RequestMapping(value = "upload", method = RequestMethod.POST)
	public @ResponseBody Result<FileMeta> upload(MultipartHttpServletRequest request) throws Exception{
    	Iterator<String> itr = request.getFileNames();
    	MultipartFile mpf = null;
    	FileMeta fileMeta = new FileMeta();
    	if(itr.hasNext()){
    		mpf = request.getFile(itr.next());
    		//文件名
    		String fileName = mpf.getOriginalFilename();
    		fileMeta.setName(fileName);
    		fileMeta.setSize(mpf.getSize() / 1024 + " Kb");
    		fileMeta.setType(mpf.getContentType());
    		
    		fileMeta.setBytes(mpf.getBytes());
    		File folder = new File(uploadPath + "headImg/");
    		if (!folder.exists()) {
    			folder.mkdirs();
    		}
    		String location = uploadPath + "headImg/" + fileName;
    		File file = new File(location);
    		//拷贝路径
    		FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(file));
    		
    		//设置上传路径
    		fileMeta.setLocation("headImg/" + fileName);
    	}
        
		return new ResultBuilder<FileMeta>().data(fileMeta).build();
	}
    
	@RequestMapping(value = "import", method = RequestMethod.POST)
	public @ResponseBody Result<List<String>> importUser(MultipartFile file) {
		// 错误信息
		List<String> listErrorMessage = new ArrayList<String>();
		try {
			if (file == null) {
				listErrorMessage.add("文件不存在!");
				return new ResultBuilder<List<String>>().data(listErrorMessage).build();
			}
			// 文件名
			String fileName = file.getOriginalFilename();
			// 文件扩展名
			String extName = StringUtils.substring(fileName,
					StringUtils.lastIndexOf(fileName, ".") + 1);
			if (!"xls".equalsIgnoreCase(extName)
					&& !"xlsx".equalsIgnoreCase(extName)) {
				listErrorMessage.add("只允许上传xls或xlsx格式文件!");
				return new ResultBuilder<List<String>>().data(listErrorMessage).build();
			}
			// 导入用户
			userService.importUser(file.getInputStream(), listErrorMessage);
		} catch (Exception e) {
			listErrorMessage.add(e.getMessage());
		}
		return new ResultBuilder<List<String>>().data(listErrorMessage).build();
	}
}
