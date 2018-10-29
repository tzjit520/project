package com.jtgl.item.model;

import java.math.BigDecimal;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class Item extends BaseEntity<Item> {

	private String code; // 编码
	private String name; // 产品名称
	private String itemAlias; // 产品简称
	private Integer itemTypeId; // 产品类型Id
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private java.util.Date startDate; // 上架时间
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private java.util.Date endDate; // 下架日期
	private String uom; // 单位
	private BigDecimal listPrice; // 零售单价
	private BigDecimal sellingPrice; // 销售单价
	private String picLocation; // 图片链接

	private ItemType itemType; // 产品类型对象
	
	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}

	public String getItemAlias() {
		return itemAlias;
	}

	public void setItemAlias(String itemAlias) {
		this.itemAlias = itemAlias;
	}

	public Integer getItemTypeId() {
		return itemTypeId;
	}

	public void setItemTypeId(Integer itemTypeId) {
		this.itemTypeId = itemTypeId;
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
	
	public String getUom() {
		return uom;
	}
	
	public void setUom(String uom) {
		this.uom = uom;
	}

	public BigDecimal getListPrice() {
		return listPrice;
	}

	public void setListPrice(BigDecimal listPrice) {
		this.listPrice = listPrice;
	}

	public BigDecimal getSellingPrice() {
		return sellingPrice;
	}

	public void setSellingPrice(BigDecimal sellingPrice) {
		this.sellingPrice = sellingPrice;
	}

	public String getPicLocation() {
		return picLocation;
	}
	
	public void setPicLocation(String picLocation) {
		this.picLocation = picLocation;
	}

	public ItemType getItemType() {
		return itemType;
	}

	public void setItemType(ItemType itemType) {
		this.itemType = itemType;
	}
	
}
