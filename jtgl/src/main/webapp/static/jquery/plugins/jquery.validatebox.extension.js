/**
 * jQuery EasyUI 1.4.2
 * 
 * Copyright (c) 2009-2015 www.jeasyui.com. All rights reserved.
 * 
 * Licensed under the GPL license: http://www.gnu.org/licenses/gpl.txt To use it
 * on other terms please contact us at info@jeasyui.com
 * 
 */

$.extend($.fn.validatebox.defaults.rules,{
	CHS : {
		validator : function(value, param) {
			return /^[\u0391-\uFFE5]+$/.test(value);
		},
		message : '请输入汉字'
	},
	english : {// 验证英语
		validator : function(value) {
			return /^[A-Za-z]+$/i.test(value);
		},
		message : '请输入英文'
	},
	englishLength : {// 验证长度加英文
		validator : function(value) {
			return /^[A-Za-z\d_]{1,30}$/i.test(value);
		},
		message : '请输入英文数字或下划线,长度在1~30之间'
	},
	ip : {// 验证IP地址
		validator : function(value) {
			return /\d+\.\d+\.\d+\.\d+/.test(value);
		},
		message : 'IP地址格式不正确'
	},
	ZIP : {
		validator : function(value, param) {
			return /^[0-9]\d{5}$/.test(value);
		},
		message : '邮政编码不存在'
	},
	QQ : {
		validator : function(value, param) {
			return /^[1-9]\d{4,10}$/.test(value);
		},
		message : 'QQ号码不正确'
	},
	mobile : {
		validator : function(value, param) {
			return /^(?:13\d|15\d|18\d|17\d)-?\d{5}(\d{3}|\*{3})$/
					.test(value);
		},
		message : '手机号码不正确'
	},
	tel : {
		validator : function(value, param) {
			return /^(\d{3}-|\d{4}-)?(\d{8}|\d{7})?(-\d{1,6})?$/
					.test(value);
		},
		message : '电话号码不正确'
	},
	formatdate : {
		validator : function(value) {
			if(value.length>7){
				return /\d{4}-((([1-9])|(1[0-2])|(0[1-9]))-(([1-9])|(1[0-9])|(2[0-9])|(3[0-1])|(0[1-9]))|(([1-9])|(1[0-9])|(2[0-9])|(3[0-1])|(0[1-9])))$/
				.test(value);				
			}else{
				return /\d{4}-((([1-9])|(1[0-2])|(0[1-9])))$/
				.test(value);
			}
		},
		message : '日期格式不正确,规定格式：yyyy-mm / yyyy-mm-dd / yyyy-m /yyyy-m-d /yyyy-mm-d /yyyy-m-dd'
	},
	formatMoth : {
		validator : function(value) {
			return /\d{4}(0[1-9]|1[0-2])$/
			.test(value);
		},
		message : '日期格式不正确,规定格式：yyyymm'
	},
	format_Moth : {
		validator : function(value) {
			return /\d{4}-(0[1-9]|1[0-2])$/
			.test(value);
		},
		message : '日期格式不正确,规定格式：yyyy-mm'
	},
	mobileAndTel : {
		validator : function(value, param) {
			return /(^([0\+]\d{2,3})\d{3,4}\-\d{3,8}$)|(^([0\+]\d{2,3})\d{3,4}\d{3,8}$)|(^([0\+]\d{2,3}){0,1}13\d{9}$)|(^\d{3,4}\d{3,8}$)|(^\d{3,4}\-\d{3,8}$)/
					.test(value);
		},
		message : '请正确输入电话号码'
	},
	number : {
		validator : function(value, param) {
			return /^[0-9]+.?[0-9]*$/.test(value);
		},
		message : '请输入数字'
	},
	money : {
		validator : function(value, param) {
			return (/^(([1-9]\d*)|\d)(\.\d{1,2})?$/)
					.test(value);
		},
		message : '请输入正确的金额'

	},
	mone : {
		validator : function(value, param) {
			return (/^(([1-9]\d*)|\d)(\.\d{1,2})?$/)
					.test(value);
		},
		message : '请输入整数或小数'

	},
	integer : {
		validator : function(value, param) {
			return /^[+]?[1-9]\d*$/.test(value);
		},
		message : '请输入最小为1的整数'
	},
	integ : {
		validator : function(value, param) {
			return /^[+]?[0-9]\d*$/.test(value);
		},
		message : '请输入整数'
	},
	range : {
		validator : function(value, param) {
			if (/^[1-9]\d*$/.test(value)) {
				return value >= param[0] && value <= param[1]
			} else {
				return false;
			}
		},
		message : '输入的数字在{0}到{1}之间'
	},
	minLength : {
		validator : function(value, param) {
			return value.length >= param[0]
		},
		message : '至少输入{0}个字'
	},
	maxLength : {
		validator : function(value, param) {
			return value.length <= param[0]
		},
		message : '最多{0}个字'
	},
	// select即选择框的验证
	selectValid : {
		validator : function(value, param) {
			if (value == '' || value == param[0]) {
				return false;
			} else {
				return true;
			}
		},
		message : '请选择{1}'
	},
	idCode : {
		validator : function(value, param) {
			return /(^\d{18}$)|(^\d{17}(\d|X|x)$)/
					.test(value);
		},
		message : '请输入正确的二代身份证号'
	},
	loginName : {
		validator : function(value, param) {
			return /^[\u0391-\uFFE5\w]+$/.test(value);
		},
		message : '登录名称只允许汉字、英文字母、数字及下划线。'
	},
	equalTo : {
		validator : function(value, param) {
			return value == $(param[0]).val();
		},
		message : '两次输入的字符不一至'
	},
	englishOrNum : {// 只能输入英文和数字
		validator : function(value) {
			return /^[a-zA-Z0-9_ ]{1,}$/.test(value);
		},
		message : '请输入英文、数字、下划线或者空格'
	},
	xiaoshu : {
		validator : function(value) {
			return /^(([1-9]+)|([0-9]+\.[0-9]{1,2}))$/
					.test(value);
		},
		message : '最多保留两位小数！'
	},
	ddPrice : {
		validator : function(value, param) {
			if (/^[1-9]\d*$/.test(value)) {
				return value >= param[0] && value <= param[1];
			} else {
				return false;
			}
		},
		message : '请输入1到100之间正整数'
	},
	jretailUpperLimit : {
		validator : function(value, param) {
			if (/^[0-9]+([.]{1}[0-9]{1,2})?$/.test(value)) {
				return parseFloat(value) > parseFloat(param[0])
						&& parseFloat(value) <= parseFloat(param[1]);
			} else {
				return false;
			}
		},
		message : '请输入0到100之间的最多俩位小数的数字'
	},
	rateCheck : {
		validator : function(value, param) {
			if (/^[0-9]+([.]{1}[0-9]{1,2})?$/.test(value)) {
				return parseFloat(value) > parseFloat(param[0])
						&& parseFloat(value) <= parseFloat(param[1]);
			} else {
				return false;
			}
		},
		message : '请输入0到1000之间的最多俩位小数的数字'
	},
	startWith: {
        validator: function(value,param){
            return value.indexOf(param[0])==0;
        },
        message: '{1}'
    },
    
    //例子: <input class="easyui-numberbox textbox" data-options="min:0,precision:2,validType:'customValidate[customeValidate,\'请输入大于100的数字！\']'">
    customValidate: {
    	//param[0] : 自定义验证方法
    	//param[1] : 错误message
        validator: function(value,param){
            var rt= param[0](value);//调用函数
            return rt ==null;//如果无返回信息,说明校验通过
        },
        message: '{1}' //显示校验错误信息
    },
    
    customDGValidate: {
    	//param[0] : 自定义验证方法
    	//param[1] : 可编辑表格id
    	//param[2] : 要比较的字段
    	//param[3] : 错误message
        validator: function(value,param){
            var rt= param[0](value,param[1],param[2]);//调用函数
            return rt ==null;//如果无返回信息,说明校验通过
        },
        message: '{3}' //显示校验错误信息
    }
});

/**
 * 是否大于要比较字段的值
 * @param value
 * @param dgId		可编辑表格 id
 * @param tgtFld	要比较的字段
 * @returns
 */
function gt4DG(value,dgId,tgtFld){
	var opts = $('#'+dgId).edatagrid('options');
	var editIndex = opts.editIndex;
	var targetEditor = $('#'+dgId).edatagrid('getEditor',{'index':editIndex,'field':tgtFld});
	if(targetEditor != null && targetEditor!= undefined){
		var editor_type = targetEditor.type;
		var targetVal;
		if( editor_type == 'combobox' ){
			targetVal = targetEditor.target.combobox('getValue');
		} else if( editor_type == 'numberbox' ){
			targetVal = targetEditor.target.numberbox('getValue');
		} else if( editor_type == 'validatebox' ){
			targetVal = targetEditor.target.val();
		}
		if(Number(value) > Number(targetVal)){
			return '1';
		}
	}
	
	return null;
}

/**
 * 是否小于要比较字段的值
 * @param value
 * @param dgId		可编辑表格 id
 * @param tgtFld	要比较的字段
 * @returns
 */
function lt4DG(value,dgId,tgtFld){
	
	var opts = $('#'+dgId).edatagrid('options');
	var editIndex = opts.editIndex;
	var targetEditor = $('#'+dgId).edatagrid('getEditor',{'index':editIndex,'field':tgtFld});
	if(targetEditor != null && targetEditor!= undefined){
		var editor_type = targetEditor.type;
		var targetVal;
		if( editor_type == 'combobox' ){
			targetVal = targetEditor.target.combobox('getValue');
		} else if( editor_type == 'numberbox' ){
			targetVal = targetEditor.target.numberbox('getValue');
		} else if( editor_type == 'validatebox' ){
			targetVal = targetEditor.target.val();
		}
		if(Number(value) <Number(targetVal)){
			return '1';
		}
	}
	return null;
}

/**
 * 是否小于要比较字段的值
 * @param value
 * @param dgId		可编辑表格 id
 * @param tgtFld	要比较的字段
 * @returns
 */
function eq4DG(value,dgId,tgtFld){
	var opts = $('#'+dgId).edatagrid('options');
	var editIndex = opts.editIndex;
	var targetEditor = $('#'+dgId).edatagrid('getEditor',{'index':editIndex,'field':tgtFld});
	if(targetEditor != null && targetEditor!= undefined){
		var editor_type = targetEditor.type;
		var targetVal;
		if( editor_type == 'combobox' ){
			targetVal = targetEditor.target.combobox('getText');
		} else if( editor_type == 'numberbox' ){
			targetVal = targetEditor.target.numberbox('getValue');
		} else if( editor_type == 'validatebox' ){
			targetVal = targetEditor.target.val();
		}
		if (targetVal == null || targetVal == "") {
		    return null;
		}
		if(value == targetVal){
			return '1';
		}
	}
	return null;
}

