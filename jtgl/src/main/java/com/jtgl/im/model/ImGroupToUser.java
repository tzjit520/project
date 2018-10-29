package com.jtgl.im.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class ImGroupToUser extends BaseEntity<ImGroupToUser> {

	private Integer userId; // 用户ID,跟im_t_users表关联
	private Integer groupId; // 群ID,跟im_t_user_groups表关联
	private String groupNick; // 群内用户昵称

	public Integer getUserId() {
		return userId;
	}
	
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	public Integer getGroupId() {
		return groupId;
	}
	
	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}
	
	public String getGroupNick() {
		return groupNick;
	}
	
	public void setGroupNick(String groupNick) {
		this.groupNick = groupNick;
	}
	
}
