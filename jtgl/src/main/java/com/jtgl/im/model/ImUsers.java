package com.jtgl.im.model;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class ImUsers extends BaseEntity<ImUsers> {

	private String code; // 登录名
	private String nickName; // 备注昵称
	private String name; // 真实姓名
	private String password; // 密码
	private String sex; // 性别
	private Integer age; // 年龄
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private java.util.Date birthday; // 生日
	private String telePhone; // 电话
	private String email; // 邮箱
	private String headImg; // 头像
	private String signaTure; // 个性签名
	private String intro; // 简介
	private String zodiac; // 生肖
	private String constellation; // 星座
	private String bloodType; // 血型
	private String schoolTag; // 毕业学校
	private String vocation; // 职业
	private String nation; // 国家
	private String province; // 省份
	private String city; // 城市
	private String county; // 区域
	private String friendShipPolicy; // 好友添加方式
	private String friendPolicyQuestion; // 好友策略问题
	private String friendPolicyAnswer; // 好友策略答案
	private String friendPolicyPassword; // 好友策略密码

	public String getCode() {
		return code;
	}
	
	public void setCode(String code) {
		this.code = code;
	}
	
	public String getNickName() {
		return nickName;
	}
	
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPassword() {
		return password;
	}
	
	public void setPassword(String password) {
		this.password = password;
	}
	
	public String getSex() {
		return sex;
	}
	
	public void setSex(String sex) {
		this.sex = sex;
	}
	
	public Integer getAge() {
		return age;
	}
	
	public void setAge(Integer age) {
		this.age = age;
	}
	
	public java.util.Date getBirthday() {
		return birthday;
	}
	
	public void setBirthday(java.util.Date birthday) {
		this.birthday = birthday;
	}
	
	public String getTelePhone() {
		return telePhone;
	}
	
	public void setTelePhone(String telePhone) {
		this.telePhone = telePhone;
	}
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getHeadImg() {
		return headImg;
	}
	
	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}
	
	public String getSignaTure() {
		return signaTure;
	}
	
	public void setSignaTure(String signaTure) {
		this.signaTure = signaTure;
	}
	
	public String getIntro() {
		return intro;
	}
	
	public void setIntro(String intro) {
		this.intro = intro;
	}
	
	public String getZodiac() {
		return zodiac;
	}
	
	public void setZodiac(String zodiac) {
		this.zodiac = zodiac;
	}
	
	public String getConstellation() {
		return constellation;
	}
	
	public void setConstellation(String constellation) {
		this.constellation = constellation;
	}
	
	public String getBloodType() {
		return bloodType;
	}
	
	public void setBloodType(String bloodType) {
		this.bloodType = bloodType;
	}
	
	public String getSchoolTag() {
		return schoolTag;
	}
	
	public void setSchoolTag(String schoolTag) {
		this.schoolTag = schoolTag;
	}
	
	public String getVocation() {
		return vocation;
	}
	
	public void setVocation(String vocation) {
		this.vocation = vocation;
	}
	
	public String getNation() {
		return nation;
	}
	
	public void setNation(String nation) {
		this.nation = nation;
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

	public String getCounty() {
		return county;
	}

	public void setCounty(String county) {
		this.county = county;
	}

	public String getFriendShipPolicy() {
		return friendShipPolicy;
	}
	
	public void setFriendShipPolicy(String friendShipPolicy) {
		this.friendShipPolicy = friendShipPolicy;
	}
	
	public String getFriendPolicyQuestion() {
		return friendPolicyQuestion;
	}
	
	public void setFriendPolicyQuestion(String friendPolicyQuestion) {
		this.friendPolicyQuestion = friendPolicyQuestion;
	}
	
	public String getFriendPolicyAnswer() {
		return friendPolicyAnswer;
	}
	
	public void setFriendPolicyAnswer(String friendPolicyAnswer) {
		this.friendPolicyAnswer = friendPolicyAnswer;
	}
	
	public String getFriendPolicyPassword() {
		return friendPolicyPassword;
	}
	
	public void setFriendPolicyPassword(String friendPolicyPassword) {
		this.friendPolicyPassword = friendPolicyPassword;
	}
	
}
