package com.jtgl.mail.model;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class Mail extends BaseEntity<Mail> {

	private String title; // 邮箱标题
	private String content; // 不带html标签的内容
	private String contentHtml; // 带html标签的内容
	private Integer fromUserId; // 发件人ID
	private String toUserId; // 收件人ID
	private Integer emailType; // 邮箱类型。1收件箱，2已发送，3草稿
	private Integer mark; // 0普通邮箱，1星标邮箱
	private Integer sendStatus; // 发送状态。0失败，1成功
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private java.util.Date sendTime; // 发送时间
	private Integer isRead; // 读取状态。0未读，1已读

	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public Integer getFromUserId() {
		return fromUserId;
	}
	
	public void setFromUserId(Integer fromUserId) {
		this.fromUserId = fromUserId;
	}
	
	public String getToUserId() {
		return toUserId;
	}
	
	public void setToUserId(String toUserId) {
		this.toUserId = toUserId;
	}
	
	public Integer getEmailType() {
		return emailType;
	}

	public void setEmailType(Integer emailType) {
		this.emailType = emailType;
	}

	public Integer getMark() {
		return mark;
	}
	
	public void setMark(Integer mark) {
		this.mark = mark;
	}
	
	public Integer getSendStatus() {
		return sendStatus;
	}
	
	public void setSendStatus(Integer sendStatus) {
		this.sendStatus = sendStatus;
	}
	
	public java.util.Date getSendTime() {
		return sendTime;
	}
	
	public void setSendTime(java.util.Date sendTime) {
		this.sendTime = sendTime;
	}
	
	public Integer getIsRead() {
		return isRead;
	}
	
	public void setIsRead(Integer isRead) {
		this.isRead = isRead;
	}

	public String getContentHtml() {
		return contentHtml;
	}

	public void setContentHtml(String contentHtml) {
		this.contentHtml = contentHtml;
	}
	
}
