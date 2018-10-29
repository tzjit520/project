package com.platform.system.memu.model;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

@EntityAnotation(logicalDelete = true)
public class SysMenu extends BaseEntity<SysMenu> implements Comparable<SysMenu> {

	private static final long serialVersionUID = 5131478990411556289L;

	private String css;				// css样式，指明图标和字体颜色
    private String name;			// 菜单名称
    private String code;			// 菜单编码
    private Integer sort;			// 排序字段
    private Integer type;			// 菜单类型，1-内部链接，2-外部链接
    private String url;				// 链接
    private Integer parentId;			// 父节点ID
    private String parentName;		// 父节点名称
    private String permission;		// 访问菜单所需权限
    private Integer depth;			// 菜单层级，1为第一层
    private SysMenu parentMenu;		// 父菜单
    private Set<SysMenu> childrenMenus = new LinkedHashSet<>();		// 子菜单
    private List<SysMenu> childrenListMenus = new ArrayList<>();		// 子菜单
    
    public SysMenu() {
		super();
	}

	public SysMenu(Integer id, Integer parentId) {
		super();
		this.parentId = parentId;
		super.id = id;
	}

	public String getCss() {
        return css;
    }

    public void setCss(String css) {
        this.css = css;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getPermission() {
        return permission;
    }

    public void setPermission(String permission) {
        this.permission = permission;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public Integer getDepth() {
        return depth;
    }

    public void setDepth(Integer depth) {
        this.depth = depth;
    }

    public SysMenu getParentMenu() {
        return parentMenu;
    }

    public void setParentMenu(SysMenu parentMenu) {
        this.parentMenu = parentMenu;
    }

    public Set<SysMenu> getChildrenMenus() {
        return childrenMenus;
    }

    public void setChildrenMenus(Set<SysMenu> childrenMenus) {
        this.childrenMenus = childrenMenus;
    }

	public List<SysMenu> getChildrenListMenus() {
		return childrenListMenus;
	}

	public void setChildrenListMenus(List<SysMenu> childrenListMenus) {
		this.childrenListMenus = childrenListMenus;
	}
	
	@Override
	public int compareTo(SysMenu menu) {
		if (menu.getSort() != null && this.getSort() != null) {
			return this.getSort() - menu.getSort();
		}
		return 0;
	}
    
	@JsonIgnore
	public static void sortList(List<SysMenu> list, List<SysMenu> sourcelist, Integer id, boolean cascade){
		
		for (SysMenu menu : sourcelist) {
			if (menu.getParentId() != null && menu.getParentId().intValue() == id.intValue()){
				list.add(menu);
				if (cascade){
					// 判断是否还有子节点, 有则继续获取子节点
					for (SysMenu childMenu : sourcelist) {
						if (childMenu.getParentId() != null && childMenu.getParentId().intValue() == menu.getId().intValue()){
							sortList(list, sourcelist, menu.getId(), true);
							break;
						}
					}
				}
			}
		}
	}
	
}