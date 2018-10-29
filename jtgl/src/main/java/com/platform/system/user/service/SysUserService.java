package com.platform.system.user.service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.user.mapper.SysUserMapper;
import com.platform.system.user.model.SysUser;
import com.platform.system.user.model.SysUserRole;
import com.platform.utils.UserUtils;

@Service
public class SysUserService extends BaseService<SysUserMapper, SysUser>{
	
	@Autowired
	private SysUserRoleService userRoleService;
	
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysUser> selectByPage(SysUser vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysUser> results = this.selectByProperties(vo);

		PageModel<SysUser> page = new PageModel<SysUser>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	@Transactional(readOnly = true)
	public List<SysUser> selectUserByAuth(SysUser sysUser) {
		return this.getMapper().selectAuthByProperties(sysUser);
	}
	
	@Transactional(readOnly = false)
	public void saveUser(SysUser user){
		//设置初始密码
		user.initPassword();
		this.save(user);
		//添加角色
		if(user.getRoleId() != null){
			SysUserRole userRole = new SysUserRole();
			userRole.setUserId(user.getId());
			userRole.setRoleId(user.getRoleId());
			userRoleService.save(userRole);
		}
	}
	
	@Transactional(readOnly = false)
	public void updateUser(SysUser user){
		
		//判断密码有没有修改
		SysUser sysUser = this.selectById(user.getId());
		String password2 = new SimpleHash("MD5", user.getPassword(), ByteSource.Util.bytes(user.getCode()), 2).toString();
		if(!sysUser.getPassword().equals(password2)){
			user.setPassword(password2);
		}
		this.updateNotNull(user);
		//清除当前用户缓存
		UserUtils.clearCache(user);
		//重新加入缓存
		UserUtils.putUserCache(user);
	}
	
	/**
     * 根据权限查询所有用户  
     * @param permission 例：tool:update|tool:add|...
     */
    public List<SysUser> selectUserListByPermission(String permission){
    	List<SysUser> listUser = this.getMapper().selectUserListByPermission(permission);
    	return listUser;
    }
    
	public void importUser(InputStream is, List<String> listErrorMessage) throws Exception {
		Workbook workBook = WorkbookFactory.create(is);
		// 单选和多选Sheet
		Sheet sheet = workBook.getSheetAt(0);
		// 题目集合
		List<SysUser> listSysUser = new ArrayList<SysUser>();
		
		// sheet不为空
		if (sheet != null) {
			for (int rowNum = 1; rowNum <= sheet.getLastRowNum(); rowNum++) {
				Row hssfRow = sheet.getRow(rowNum);
				if (hssfRow == null) {
					continue;
				}
				SysUser user = new SysUser();
				// 用户名
				Cell codeCell = hssfRow.getCell(0);
				String code = getValue(codeCell);
				if (StringUtils.isEmpty(code)) {
					listErrorMessage.add("sheet第" + (rowNum + 1) + "行【用户名】不能为空,请检查重试!");
				} else {
					//根据code查询数据库是否存在
					List<SysUser> list = this.mapper.selectByProperties(new SysUser(code, null));
					if (list != null && list.size() > 0) {
						listErrorMessage.add("sheet第" + (rowNum + 1) + "行【用户名["+code+"]】已经存在,请检查重试!");
					}else{
						user.setCode(code);
					}
				}
				// 姓名
				Cell nameCell = hssfRow.getCell(1);
				String name = getValue(nameCell);
				if (StringUtils.isEmpty(name)) {
					listErrorMessage.add("sheet第" + (rowNum + 1) + "行【姓名】不能为空,请检查重试!");
				} else {
					//根据code查询数据库是否存在
					List<SysUser> list = this.mapper.selectByProperties(new SysUser(null, name));
					if (list != null && list.size() > 0) {
						listErrorMessage.add("sheet第" + (rowNum + 1) + "行【姓名["+name+"]】已经存在,请检查重试!");
					}else{
						user.setName(name);
					}
				}
				// 工号
				Cell workNumberCell = hssfRow.getCell(2);
				String workNumber = getValue(workNumberCell);
				user.setWorkNumber(workNumber);	
				// 密码
				Cell passwordCell = hssfRow.getCell(3);
				String password = getValue(passwordCell);
				if (StringUtils.isEmpty(password)) {
					//设置初始密码
					user.initPassword();
				}else{
					user.setPassword(password);	
				}
				// 性别
				Cell sexCell = hssfRow.getCell(4);
				String sex = getValue(sexCell);
				user.setSex(sex);
				// 电话
				Cell telephoneCell = hssfRow.getCell(5);
				String telephone = getValue(telephoneCell);
				user.setTelephone(telephone);	
				// 手机
				Cell mobileCell = hssfRow.getCell(6);
				String mobile = getValue(mobileCell);
				user.setMobile(mobile);	
				// 邮箱
				Cell emailCell = hssfRow.getCell(7);
				String email = getValue(emailCell);
				user.setEmail(email);	
				// 描述
				Cell remarkCell = hssfRow.getCell(8);
				String remark = getValue(remarkCell);
				user.setRemark(remark);	
				
				listSysUser.add(user);
			}
		}
		// 错误信息小于等于0 则保存数据
		if (listErrorMessage.size() <= 0) {
			// 添加题目 保存到数据库
			for (SysUser user : listSysUser) {
				this.save(user);
			}
			listErrorMessage.add("成功导入" + listSysUser.size() + "条用户信息!");
		}
	}
	
	@SuppressWarnings("static-access")
	public String getValue(Cell hssfCell) {
		if (hssfCell == null) {
			return null;
		}
		if (hssfCell.getCellType() == hssfCell.CELL_TYPE_BOOLEAN) {
			// 返回Boolean类型的值
			return String.valueOf(hssfCell.getBooleanCellValue()).trim();
		} else if (hssfCell.getCellType() == hssfCell.CELL_TYPE_NUMERIC) {
			// 返回数值类型的值
			return String.valueOf(hssfCell.getNumericCellValue()).trim();
		} else {
			// 返回字符串类型的值
			return String.valueOf(hssfCell.getStringCellValue()).trim();
		}
	}
}
