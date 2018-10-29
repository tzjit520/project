package com.jtgl.draw.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;
import com.platform.system.user.model.SysUser;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class DrawFrequency extends BaseEntity<DrawFrequency> {

	private Integer drawId; // 抽奖ID
	private Integer userId; // 用户Id
	private int remainNumber; // 剩余次数

	private Draw draw; // 抽奖对象
	private SysUser user; // 用户对象
	
	public Integer getDrawId() {
		return drawId;
	}
	
	public void setDrawId(Integer drawId) {
		this.drawId = drawId;
	}
	
	public int getRemainNumber() {
		return remainNumber;
	}

	public void setRemainNumber(int remainNumber) {
		this.remainNumber = remainNumber;
	}

	public Draw getDraw() {
		return draw;
	}

	public void setDraw(Draw draw) {
		this.draw = draw;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public SysUser getUser() {
		return user;
	}

	public void setUser(SysUser user) {
		this.user = user;
	}

}
