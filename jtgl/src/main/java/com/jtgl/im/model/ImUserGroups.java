package com.jtgl.im.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class ImUserGroups extends BaseEntity<ImUserGroups> {

	private String name; // 群名称
	private Integer adminId; // 群主ID,跟im_t_users表关联
	private String icon; // 群图标
	private String notice; // 群公告
	private String intro; // 群简介

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getAdminId() {
		return adminId;
	}

	public void setAdminId(Integer adminId) {
		this.adminId = adminId;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

}
