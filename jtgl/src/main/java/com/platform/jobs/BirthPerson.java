package com.platform.jobs;

/**
 * 今天生日人员信息
 */
public class BirthPerson {
	
	private String name; // 姓名
	private int age; // 年龄
	private String phone; // 电话
	private String nlDate; // 当前农历日期
	private String brithDay; // 生日日期
	private int xsAge; // 虚岁
	private int zsAge; // 周岁
	private long days; // 从出生到现在过了多少天
	private String blessings; // 祝福语
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getNlDate() {
		return nlDate;
	}
	public void setNlDate(String nlDate) {
		this.nlDate = nlDate;
	}
	public String getBrithDay() {
		return brithDay;
	}
	public void setBrithDay(String brithDay) {
		this.brithDay = brithDay;
	}
	public int getXsAge() {
		return xsAge;
	}
	public void setXsAge(int xsAge) {
		this.xsAge = xsAge;
	}
	public int getZsAge() {
		return zsAge;
	}
	public void setZsAge(int zsAge) {
		this.zsAge = zsAge;
	}
	public long getDays() {
		return days;
	}
	public void setDays(long days) {
		this.days = days;
	}
	public String getBlessings() {
		return blessings;
	}
	public void setBlessings(String blessings) {
		this.blessings = blessings;
	}
	
}
