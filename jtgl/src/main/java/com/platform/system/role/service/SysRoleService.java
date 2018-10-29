package com.platform.system.role.service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.permission.model.SysPermission;
import com.platform.system.role.mapper.SysRoleMapper;
import com.platform.system.role.model.SysRole;
import com.platform.system.role.model.SysRolePermission;
import com.platform.system.user.model.SysUser;
import com.platform.system.user.model.SysUserRole;
import com.platform.system.user.service.SysUserRoleService;

@Service
public class SysRoleService extends BaseService<SysRoleMapper,SysRole> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private SysRolePermissionService rolePermissionService;

    @Autowired
    private SysUserRoleService userRoleService;
	
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysRole> selectByPage(SysRole vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysRole> results = this.selectByProperties(vo);

		PageModel<SysRole> page = new PageModel<SysRole>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	public List<SysRole> selectRoleList(String code){
		return this.getMapper().selectRoleList(code);
	}
	
	@Transactional
	public void updateRole(SysRole sysRole) {
	    this.updatePermissionByRole(sysRole);
        this.updateUserByRole(sysRole);
        this.updateNotNull(sysRole);
	}

	@Transactional
    public void deleteRole(Integer id) {
    	
        userRoleService.deleteByRoleId(id);
        rolePermissionService.deleteByRoleId(id);
        this.delete(id);
    }

	@Transactional
    public void updatePermissionByRole(SysRole sysRole) {
        SysRolePermission searchPermission = new SysRolePermission();
        searchPermission.setRoleId(sysRole.getId());
        List<SysRolePermission> savedPermissionList = rolePermissionService.selectAll(searchPermission);
        //待处理
        List<SysPermission> pendingPermissionList = sysRole.getPermissionList();
        List<SysRolePermission> addList = new ArrayList<SysRolePermission>();
        List<SysRolePermission> deleteList = new ArrayList<SysRolePermission>();

        //查看add
        for(SysPermission sysPermission:pendingPermissionList) {
            boolean isFind = false;
            for(SysRolePermission rolePermission:savedPermissionList) {
                if(rolePermission.getPermissionId().intValue()==sysPermission.getId().intValue()) {
                    isFind = true;
                }
            }
            if(!isFind) {
                SysRolePermission sysRolePermission = new SysRolePermission();
                sysRolePermission.setRoleId(sysRole.getId());
                sysRolePermission.setPermissionId(sysPermission.getId());
                addList.add(sysRolePermission);
            }
        }

        //查看删除功能权限
        for(SysRolePermission rolePermission:savedPermissionList) {
            boolean isFind = false;
            for(SysPermission sysPermission:pendingPermissionList) {
                if(rolePermission.getPermissionId().intValue()==sysPermission.getId().intValue()) {
                    isFind = true;
                }
            }
            if(!isFind) {
                deleteList.add(rolePermission);
            }
        }

        for(SysRolePermission sysRolePermission:addList) {
            rolePermissionService.save(sysRolePermission);
        }
        for(SysRolePermission sysRolePermission:deleteList) {
            rolePermissionService.delete(sysRolePermission.getId());
        }
    }

	@Transactional
    public void updateUserByRole(SysRole sysRole) {
        SysUserRole searchUser = new SysUserRole();
        searchUser.setRoleId(sysRole.getId());
        List<SysUserRole> savedUserList = userRoleService.selectAll(searchUser);
        //待处理
        List<SysUser> pendingUserList = sysRole.getUserList();
        List<SysUserRole> addList = new ArrayList<SysUserRole>();
        List<SysUserRole> deleteList = new ArrayList<SysUserRole>();

        //查看add
        for(SysUser sysUser:pendingUserList) {
            boolean isFind = false;
            for(SysUserRole userRole:savedUserList) {
                if(userRole.getUserId().intValue()==sysUser.getId().intValue()) {
                    isFind = true;
                }
            }
            if(!isFind) {
                SysUserRole sysUserRole = new SysUserRole();
                sysUserRole.setRoleId(sysRole.getId());
                sysUserRole.setUserId(sysUser.getId());
                addList.add(sysUserRole);
            }
        }

        //查看删除功能权限
        for(SysUserRole userRole:savedUserList) {
            boolean isFind = false;
            for(SysUser sysUser:pendingUserList) {
                if(userRole.getUserId().intValue()==sysUser.getId().intValue()) {
                    isFind = true;
                }
            }
            if(!isFind) {
                deleteList.add(userRole);
            }
        }

        for(SysUserRole sysUserRole:addList) {
            userRoleService.save(sysUserRole);
        }
        for(SysUserRole sysUserRole:deleteList) {
            userRoleService.delete(sysUserRole.getId());
        }
    }

    @Transactional
	public void saveRole(SysRole sysRole) {
		this.saveNotNull(sysRole);
		for(SysPermission permission : sysRole.getPermissionList()) {
			SysRolePermission rolePermission = new SysRolePermission();
			rolePermission.setRoleId(sysRole.getId());
			rolePermission.setPermissionId(permission.getId());
			rolePermissionService.save(rolePermission);
		}

        for(SysUser user : sysRole.getUserList()) {
            SysUserRole userRole = new SysUserRole();
            userRole.setRoleId(sysRole.getId());
            userRole.setUserId(user.getId());
           userRoleService.save(userRole);
        }
	}
}
