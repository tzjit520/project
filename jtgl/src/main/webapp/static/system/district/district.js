//获取项目名称
var pathName=window.document.location.pathname;
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
var cityJson;
//获取地区json数据
$.ajaxSettings.async = false;//同步执行
$.getJSON(projectName+"/static/system/district/district.json",
	function(result){
		cityJson = result;
	}
);

//初始化省份
function initProvince(provinceName){
	//初始化省下拉框
	var sb = new StringBuffer();
	$.each(cityJson.province, function(index, field){
		if(provinceName && field.name == provinceName){
			sb.append("<option value='" + field.name + "' selected='selected'>" + field.name + "</option>");
		}else{
			sb.append("<option value='" + field.name + "'>" + field.name + "</option>");
		}
	});
	$("#choosePro").after(sb.toString());
}

// 省值变化时 处理市
function doProvAndCityRelation(cityName) {
	var city = $("#city");
	var county = $("#county");
	if (city.children().length > 1) {
		city.empty();
	}
	if (county.children().length > 1) {
		county.empty();
	}
	if ($("#chooseCity").length === 0) {
		city.append("<option id='chooseCity' value=''>请选择</option>");
	}
	if ($("#chooseCounty").length === 0) {
		county.append("<option id='chooseCounty' value=''>请选择</option>");
	}
	var sb = new StringBuffer();
	$.each(cityJson.province, function(index, field) {
		if (field.name == $("#province").val()) {
			$.each(field.city, function(i, item) {
				if(cityName && item.name == cityName){
					sb.append("<option value='" + item.name + "' selected='selected'>" + item.name + "</option>");
				}else{
					sb.append("<option value='" + item.name + "'>" + item.name + "</option>");
				}
			})
		}
    });
	$("#chooseCity").after(sb.toString());
} 

// 市值变化时 处理区/县
function doCityAndCountyRelation(countyName) {
	var province = $("#province").val();
	var cityVal = $("#city").val();
	var county = $("#county");
	if (county.children().length > 1) {
		county.empty();
	}
	if ($("#chooseCounty").length === 0) {
		county.append("<option id='chooseCounty' value=''>请选择</option>");
	}
	var sb = new StringBuffer();
	$.each(cityJson.province, function(index, field) {
		if (province == field.name) {
			//市
			$.each(field.city, function(i, item) {
				if(cityVal == item.name){
					//区
					$.each(item.county, function(c, c_item) {
						if(countyName && c_item.name == countyName){
							sb.append("<option value='" + c_item.name + "' selected='selected'>" + c_item.name + "</option>");
						}else{
							sb.append("<option value='" + c_item.name + "'>" + c_item.name + "</option>");
						}
					})
				}
			})
		}
    });
	$("#chooseCounty").after(sb.toString());
}

function StringBuffer(str) {
	var arr = [];
	str = str || "";
	var size = 0; // 存放数组大小
	arr.push(str);
	// 追加字符串
	this.append = function(str1) {
	    arr.push(str1);
	    return this;
	};
	// 返回字符串
	this.toString = function() {
		return arr.join("");
	};
	// 清空 
	this.clear = function(key) {
	    size = 0;
	    arr = [];
	};
	// 返回数组大小 
	this.size = function() {
		return size;
	};
	// 返回数组 
	this.toArray = function() {
		return buffer;
	};
	// 倒序返回字符串 
	this.doReverse = function() {
	    var str = buffer.join('');
	    str = str.split('');
	    return str.reverse().join('');
	};
}