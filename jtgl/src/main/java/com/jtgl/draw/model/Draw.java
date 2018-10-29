package com.jtgl.draw.model;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class Draw extends BaseEntity<Draw> {

	private String drawName; // 抽奖名称
	private String drawTitle; // 抽奖标题
	private String drawType; // 抽奖类型(消费抽奖consumer_draw / 会员活动抽奖raffle)
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private java.util.Date startDate; // 活动开始时间
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private java.util.Date endDate; // 活动结束时间
	private Integer expiredDay; // 过期天数
	private String drawRatio; // 抽奖比率(百分比、千分比)

	public String getDrawName() {
		return drawName;
	}
	
	public void setDrawName(String drawName) {
		this.drawName = drawName;
	}
	
	public String getDrawTitle() {
		return drawTitle;
	}
	
	public void setDrawTitle(String drawTitle) {
		this.drawTitle = drawTitle;
	}
	
	public String getDrawType() {
		return drawType;
	}
	
	public void setDrawType(String drawType) {
		this.drawType = drawType;
	}
	
	public java.util.Date getStartDate() {
		return startDate;
	}
	
	public void setStartDate(java.util.Date startDate) {
		this.startDate = startDate;
	}
	
	public java.util.Date getEndDate() {
		return endDate;
	}
	
	public void setEndDate(java.util.Date endDate) {
		this.endDate = endDate;
	}
	
	public Integer getExpiredDay() {
		return expiredDay;
	}
	
	public void setExpiredDay(Integer expiredDay) {
		this.expiredDay = expiredDay;
	}
	
	public String getDrawRatio() {
		return drawRatio;
	}
	
	public void setDrawRatio(String drawRatio) {
		this.drawRatio = drawRatio;
	}
	
}
