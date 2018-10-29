package com.jtgl.im.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class ImGroupMsgToUser extends BaseEntity<ImGroupMsgToUser> {

	private Integer userId; // 接收者ID，跟im_t_users表关联
	private Integer groupMsgId; // 群组消息ID，跟im_t_group_msg_content表关联
	private Integer receivStatus; // 接收状态，0已接收，1未接收，-1撤回

	public Integer getUserId() {
		return userId;
	}
	
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	
	public Integer getGroupMsgId() {
		return groupMsgId;
	}
	
	public void setGroupMsgId(Integer groupMsgId) {
		this.groupMsgId = groupMsgId;
	}
	
	public Integer getReceivStatus() {
		return receivStatus;
	}
	
	public void setReceivStatus(Integer receivStatus) {
		this.receivStatus = receivStatus;
	}
	
}
