package com.jtgl.im.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class ImFriendGroup extends BaseEntity<ImFriendGroup> {

	private Long name; // 分组名称
	private Long userId; // 用户ID,跟im_t_users表关联

	public Long getName() {
		return name;
	}
	
	public void setName(Long name) {
		this.name = name;
	}
	
	public Long getUserId() {
		return userId;
	}
	
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
}
