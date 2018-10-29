package com.jtgl.demo.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class Map extends BaseEntity<Map> {

	private String name; // 名称
	private String number; // 编号
	private Integer mapType; // 1：百度地图，2：高德地图
	private String province; // 省份
	private String city; // 城市
	private String area; // 行政区
	private String address; // 地址
	private String mapX; // 坐标X
	private String mapY; // 坐标Y

	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getNumber() {
		return number;
	}
	
	public void setNumber(String number) {
		this.number = number;
	}
	
	public Integer getMapType() {
		return mapType;
	}
	
	public void setMapType(Integer mapType) {
		this.mapType = mapType;
	}
	
	public String getProvince() {
		return province;
	}
	
	public void setProvince(String province) {
		this.province = province;
	}
	
	public String getCity() {
		return city;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getArea() {
		return area;
	}
	
	public void setArea(String area) {
		this.area = area;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getMapX() {
		return mapX;
	}
	
	public void setMapX(String mapX) {
		this.mapX = mapX;
	}
	
	public String getMapY() {
		return mapY;
	}
	
	public void setMapY(String mapY) {
		this.mapY = mapY;
	}
	
}
