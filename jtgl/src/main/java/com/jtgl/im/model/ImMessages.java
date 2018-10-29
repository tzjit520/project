package com.jtgl.im.model;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class ImMessages extends BaseEntity<ImMessages> {

	private String msgContent; // 消息内容
	private Integer receivStatus; // 接收状态，0已接收，1未接收，-1撤回
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private java.util.Date sendTime; // 发送时间
	private Integer messageTypeId; // 消息类型ID,跟im_t_message_type表关联
	private Integer fromUserId; // 发送者ID,跟im_t_users表关联
	private Integer toUserId; // 接收者ID,跟im_t_users表关联

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
	
	public Integer getMessageTypeId() {
		return messageTypeId;
	}
	
	public void setMessageTypeId(Integer messageTypeId) {
		this.messageTypeId = messageTypeId;
	}
	
	public Integer getFromUserId() {
		return fromUserId;
	}
	
	public void setFromUserId(Integer fromUserId) {
		this.fromUserId = fromUserId;
	}
	
	public Integer getToUserId() {
		return toUserId;
	}
	
	public void setToUserId(Integer toUserId) {
		this.toUserId = toUserId;
	}
	
}
