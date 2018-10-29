package com.jtgl.im.model;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class ImGroupMsgUserToUser extends BaseEntity<ImGroupMsgUserToUser> {

	private Integer fromUserId; // 发送者ID，跟im_t_users表关联
	private String fromUserNickName; // 发送者昵称
	private Integer toUserId; // 接收者ID，跟im_t_users表关联
	private String msgContent; // 消息内容
	private Integer receivStatus; // 接收状态，0已接收，1未接收，-1撤回
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private java.util.Date sendTime; // 发送时间
	private Integer userGroupId; // 所属群组ID,跟im_t_user_groups表关联

	public Integer getFromUserId() {
		return fromUserId;
	}
	
	public void setFromUserId(Integer fromUserId) {
		this.fromUserId = fromUserId;
	}
	
	public String getFromUserNickName() {
		return fromUserNickName;
	}
	
	public void setFromUserNickName(String fromUserNickName) {
		this.fromUserNickName = fromUserNickName;
	}
	
	public Integer getToUserId() {
		return toUserId;
	}
	
	public void setToUserId(Integer toUserId) {
		this.toUserId = toUserId;
	}
	
	public String getMsgContent() {
		return msgContent;
	}
	
	public void setMsgContent(String msgContent) {
		this.msgContent = msgContent;
	}
	
	public Integer getReceivStatus() {
		return receivStatus;
	}
	
	public void setReceivStatus(Integer receivStatus) {
		this.receivStatus = receivStatus;
	}
	
	public java.util.Date getSendTime() {
		return sendTime;
	}
	
	public void setSendTime(java.util.Date sendTime) {
		this.sendTime = sendTime;
	}
	
	public Integer getUserGroupId() {
		return userGroupId;
	}
	
	public void setUserGroupId(Integer userGroupId) {
		this.userGroupId = userGroupId;
	}
	
}
