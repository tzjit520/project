package com.jtgl.draw.model;

import com.jtgl.group.model.Group;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;
import com.platform.system.user.model.SysUser;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class DrawResult extends BaseEntity<DrawResult> {

	private Integer userId; // 用户ID
	private Integer drawId; // 抽奖ID
	private String drawResult; // 抽奖结果(特等奖 / 一等奖 / 二等奖 / 三等奖 / 幸运奖....)
	private Integer groupId; // 奖品组Id

	private Draw draw; // 抽奖对象
	private SysUser user; // 用户对象
	private Group group; // 奖品组对象
	
	public Integer getDrawId() {
		return drawId;
	}
	
	public void setDrawId(Integer drawId) {
		this.drawId = drawId;
	}
	
	public String getDrawResult() {
		return drawResult;
	}
	
	public void setDrawResult(String drawResult) {
		this.drawResult = drawResult;
	}
	
	public Integer getGroupId() {
		return groupId;
	}
	
	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}

	public Draw getDraw() {
		return draw;
	}

	public void setDraw(Draw draw) {
		this.draw = draw;
	}

	public Group getGroup() {
		return group;
	}

	public void setGroup(Group group) {
		this.group = group;
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
