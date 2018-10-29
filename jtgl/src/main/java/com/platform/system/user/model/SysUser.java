package com.platform.system.user.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.util.ByteSource;
import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;
import com.platform.system.permission.model.SysPermission;
import com.platform.system.role.model.SysRole;
import com.platform.system.unit.model.SysUnit;
import com.platform.utils.EncoderUtil;

/**
 * 用户信息表
 */
@EntityAnotation(logicalDelete = true)
public class SysUser extends BaseEntity<SysUser>{

	private static final long serialVersionUID = 2579204230528469409L;
	//组织机构表公司ID
    private Integer unitId;
    //组织机构表部门ID
    private Integer deptId;
    //登录名
    private String code;
    //姓名
    private String name;
    //工号
    private String workNumber;
    //密码
    private String password;
    //密码2
    private String password2;
    //性别
    private String sex;
    //头像图片链接地址
    private String headimgurl;
    //电话
    private String telephone;
    //手机号码
    private String mobile;
    //邮箱
    private String email;
    //是否可登录，0-长期锁定，1-可登录，2-短期锁定
    private int loginFlag;
    //锁定天数，该天数由定时器每天扫描减一，直至0为止
    private int lockDay;
    //锁定时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date lockDate;
    //token验证
    private String token;
    
    //组织机构表公司对象
    private SysUnit companyUnit;
    //组织机构表部门对象
    private SysUnit departmentUnit;
    //用户角色
    private List<SysRole> roleList = new ArrayList<SysRole>();

    private List<SysPermission> permissionList = new ArrayList<SysPermission>();
    
    private Integer roleId;

	public Integer getUnitId() {
		return unitId;
	}

	public void setUnitId(Integer unitId) {
		this.unitId = unitId;
	}

	public Integer getDeptId() {
		return deptId;
	}

	public void setDeptId(Integer deptId) {
		this.deptId = deptId;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getWorkNumber() {
		return workNumber;
	}

	public void setWorkNumber(String workNumber) {
		this.workNumber = workNumber;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPassword2() {
		return password2;
	}

	public void setPassword2(String password2) {
		this.password2 = password2;
	}

	public String getSex() {
		if(StringUtils.isEmpty(sex)){
			return "男";
		}
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getHeadimgurl() {
		return headimgurl;
	}

	public void setHeadimgurl(String headimgurl) {
		this.headimgurl = headimgurl;
	}

	public String getTelephone() {
		return telephone;
	}

	public void setTelephone(String telephone) {
		this.telephone = telephone;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getLoginFlag() {
		return loginFlag;
	}

	public void setLoginFlag(int loginFlag) {
		this.loginFlag = loginFlag;
	}

	public int getLockDay() {
		return lockDay;
	}

	public void setLockDay(int lockDay) {
		this.lockDay = lockDay;
	}

	public Date getLockDate() {
		return lockDate;
	}

	public void setLockDate(Date lockDate) {
		this.lockDate = lockDate;
	}

	public String getToken() {
		return token;
	}

	public void setToken(String token) {
		this.token = token;
	}

	public SysUnit getCompanyUnit() {
		return companyUnit;
	}

	public void setCompanyUnit(SysUnit companyUnit) {
		this.companyUnit = companyUnit;
	}

	public SysUnit getDepartmentUnit() {
		return departmentUnit;
	}

	public void setDepartmentUnit(SysUnit departmentUnit) {
		this.departmentUnit = departmentUnit;
	}

	public List<SysRole> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<SysRole> roleList) {
		this.roleList = roleList;
	}

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public List<SysPermission> getPermissionList() {
		return permissionList;
	}

	public void setPermissionList(List<SysPermission> permissionList) {
		this.permissionList = permissionList;
	}

	public SysUser(String code, String name) {
		super();
		this.code = code;
		this.name = name;
	}

	public SysUser() {
		super();
	}

	//设置初始密码   一般是添加用户的时候调用     需要手动调用
	public void initPassword(){
		if(StringUtils.isEmpty(this.getPassword())){
			this.setPassword("111111");//默认密码
		}
		//加密
		String encodeCharter = EncoderUtil.getEncodeCharter("MD5", this.getPassword(), ByteSource.Util.bytes(this.getCode()), 2);
		//加密算法 
		this.setPassword(encodeCharter);
		//如果头像为空  则赋值默认头像
		if(StringUtils.isBlank(headimgurl)){
			if("男".equals(this.getSex())){
				this.headimgurl = "boy.png";
			}else{
				this.headimgurl = "girl.png";
			}
		}
	}
}