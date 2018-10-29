package com.jtgl.im.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class ImFriends extends BaseEntity<ImFriends> {

	private Long friendId; // 好友ID,跟im_t_users表关联
	private Long userId; // 自己ID,跟im_t_users表关联
	private String name; // 备注昵称
	private Long friendTypeId; // 好友类型,跟im_t_friend_type表关联
	private Long friendGroupId; // 所属分组,跟im_t_friend_groups表关联

	public Long getFriendId() {
		return friendId;
	}
	
	public void setFriendId(Long friendId) {
		this.friendId = friendId;
	}
	
	public Long getUserId() {
		return userId;
	}
	
	public void setUserId(Long userId) {
		this.userId = userId;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public Long getFriendTypeId() {
		return friendTypeId;
	}
	
	public void setFriendTypeId(Long friendTypeId) {
		this.friendTypeId = friendTypeId;
	}
	
	public Long getFriendGroupId() {
		return friendGroupId;
	}
	
	public void setFriendGroupId(Long friendGroupId) {
		this.friendGroupId = friendGroupId;
	}
	
}
