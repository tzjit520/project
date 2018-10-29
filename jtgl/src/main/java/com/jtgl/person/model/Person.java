package com.jtgl.person.model;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@EntityAnotation(logicalDelete = true)
public class Person extends BaseEntity<Person> {

	private static final long serialVersionUID = 4491993588497069653L;
	private Integer parentId; // 上级ID
	private String number; // 人员编号
	private String name; // 姓名
	private String shortName; // 简称（称谓）
	private String sex; // 性别
	private Integer age; // 年龄
	private String identification; // 身份证
	private String phone; // 电话
	private String emergencyContactPhone; // 紧急联系电话
	private String qq; // QQ
	private String weixin; // 微信
	private String mail; // 邮箱
	private Float height; // 身高
	private Float weight; // 体重
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
	private java.util.Date birthday; // 出生日期
	private String province; // 省份
	private String city; // 城市
	private String county; // 区/县
	private String mapX; // X坐标(纬度Lat)
	private String mapY; // Y坐标(经度Lng)
	private String nation; // 民族
	private String zodiac; // 生肖
	private String constellations; // 星座
	private String bloodType; // 血型
	private String educationBackground; // 学历
	private String graduateInstitution; // 毕业院校
	private String profession; // 职业
	private String position; // 职位
	private String educationExperience; // 教育经历
	private Integer educationYears; // 教育年限
	private String maritalStatus; // 婚姻状况
	private String registeredAddress; // 户口所在地
	private String address; // 详细地址
	private String hobbiesInterests; // 兴趣爱好
	private String dream; // 梦想
	private String photo; // 照片
	
	private Person parentPerson;// 父节点对象
    private Integer childCount;// 子节点数量

	public Integer getParentId() {
		return parentId;
	}

	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}

	public String getNumber() {
		return number;
	}
	
	public void setNumber(String number) {
		this.number = number;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getShortName() {
		return shortName;
	}
	
	public void setShortName(String shortName) {
		this.shortName = shortName;
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
	
	public String getIdentification() {
		return identification;
	}
	
	public void setIdentification(String identification) {
		this.identification = identification;
	}
	
	public String getPhone() {
		return phone;
	}
	
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getEmergencyContactPhone() {
		return emergencyContactPhone;
	}
	
	public void setEmergencyContactPhone(String emergencyContactPhone) {
		this.emergencyContactPhone = emergencyContactPhone;
	}
	
	public String getQq() {
		return qq;
	}
	
	public void setQq(String qq) {
		this.qq = qq;
	}
	
	public String getWeixin() {
		return weixin;
	}
	
	public void setWeixin(String weixin) {
		this.weixin = weixin;
	}
	
	public String getMail() {
		return mail;
	}
	
	public void setMail(String mail) {
		this.mail = mail;
	}
	
	public Float getHeight() {
		return height;
	}
	
	public void setHeight(Float height) {
		this.height = height;
	}
	
	public Float getWeight() {
		return weight;
	}
	
	public void setWeight(Float weight) {
		this.weight = weight;
	}
	
	public java.util.Date getBirthday() {
		return birthday;
	}
	
	public void setBirthday(java.util.Date birthday) {
		this.birthday = birthday;
	}
	
	public String getNation() {
		return nation;
	}
	
	public void setNation(String nation) {
		this.nation = nation;
	}
	
	public String getZodiac() {
		return zodiac;
	}
	
	public void setZodiac(String zodiac) {
		this.zodiac = zodiac;
	}
	
	public String getConstellations() {
		return constellations;
	}
	
	public void setConstellations(String constellations) {
		this.constellations = constellations;
	}
	
	public String getBloodType() {
		return bloodType;
	}
	
	public void setBloodType(String bloodType) {
		this.bloodType = bloodType;
	}
	
	public String getEducationBackground() {
		return educationBackground;
	}
	
	public void setEducationBackground(String educationBackground) {
		this.educationBackground = educationBackground;
	}
	
	public String getGraduateInstitution() {
		return graduateInstitution;
	}
	
	public void setGraduateInstitution(String graduateInstitution) {
		this.graduateInstitution = graduateInstitution;
	}
	
	public String getProfession() {
		return profession;
	}
	
	public void setProfession(String profession) {
		this.profession = profession;
	}
	
	public String getPosition() {
		return position;
	}
	
	public void setPosition(String position) {
		this.position = position;
	}
	
	public String getEducationExperience() {
		return educationExperience;
	}
	
	public void setEducationExperience(String educationExperience) {
		this.educationExperience = educationExperience;
	}
	
	public Integer getEducationYears() {
		return educationYears;
	}
	
	public void setEducationYears(Integer educationYears) {
		this.educationYears = educationYears;
	}
	
	public String getMaritalStatus() {
		return maritalStatus;
	}
	
	public void setMaritalStatus(String maritalStatus) {
		this.maritalStatus = maritalStatus;
	}
	
	public String getRegisteredAddress() {
		return registeredAddress;
	}
	
	public void setRegisteredAddress(String registeredAddress) {
		this.registeredAddress = registeredAddress;
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

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getHobbiesInterests() {
		return hobbiesInterests;
	}
	
	public void setHobbiesInterests(String hobbiesInterests) {
		this.hobbiesInterests = hobbiesInterests;
	}
	
	public String getDream() {
		return dream;
	}
	
	public void setDream(String dream) {
		this.dream = dream;
	}
	
	public String getPhoto() {
		return photo;
	}
	
	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Person getParentPerson() {
		return parentPerson;
	}

	public void setParentPerson(Person parentPerson) {
		this.parentPerson = parentPerson;
	}

	public Integer getChildCount() {
		return childCount;
	}

	public void setChildCount(Integer childCount) {
		this.childCount = childCount;
	}
	
}
