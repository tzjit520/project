package com.jtgl.draw.model;

import com.jtgl.group.model.Group;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class DrawPrize extends BaseEntity<DrawPrize> {

	private Integer drawId; // 抽奖ID
	private String prizeName; // 奖项名称(特等奖 / 一等奖 / 二等奖 / 三等奖 / 幸运奖....)
	private Integer probability; // 概率
	private Integer groupId; // 奖品组
	private Integer maxNumber; // 最多中奖人数
	private Integer winnNumber; // 剩余中奖次数
	
	private Draw draw; // 抽奖对象
	private Group group; // 奖品组对象

	public Integer getDrawId() {
		return drawId;
	}
	
	public void setDrawId(Integer drawId) {
		this.drawId = drawId;
	}
	
	public String getPrizeName() {
		return prizeName;
	}
	
	public void setPrizeName(String prizeName) {
		this.prizeName = prizeName;
	}
	
	public Integer getProbability() {
		return probability;
	}
	
	public void setProbability(Integer probability) {
		this.probability = probability;
	}
	
	public Integer getGroupId() {
		return groupId;
	}
	
	public void setGroupId(Integer groupId) {
		this.groupId = groupId;
	}
	
	public Integer getMaxNumber() {
		return maxNumber;
	}
	
	public void setMaxNumber(Integer maxNumber) {
		this.maxNumber = maxNumber;
	}
	
	public Integer getWinnNumber() {
		return winnNumber;
	}
	
	public void setWinnNumber(Integer winnNumber) {
		this.winnNumber = winnNumber;
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
	
}
