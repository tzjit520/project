<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>人员管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="col-xs-12 heading">
			<h1 class="page-header">${empty person.id?'添加':'修改'}家庭成员</h1>
			<hr/>
		</div>
		<div class="outlet">
			<div class="panel-body">
				<form id="fileupload" action="${ctx}/api/v1/person/upload" method="POST" enctype="multipart/form-data" class="form-horizontal group-border hover-stripped">
					<div class="form-group">
						<label class="col-xs-1 control-label">头像：</label>
						<div class="col-xs-4" style="min-width:410px">
							<input type="file" name="file" id="file">
							<span class="help-block" id="f_error"></span>
						</div>
						<div class="col-xs-5">
							<c:if test="${empty person.photo}">
								<img alt="" src="${ctx}/upload/headImg/boy.png" id="per_photo" width="50" height="50">
							</c:if>
							<c:if test="${!empty person.photo}">
								<img alt="" src="${ctx}/upload/personImg/${person.photo}" id="per_photo" width="50" height="50">
							</c:if>
						</div>
					</div>
				</form>
				
				<form:form modelAttribute="person" action="${ctx}/api/v1/person" role="form" id="personForm" onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<form:hidden path="photo" id="photo"/>
					<input type="hidden" name="_method" value="${empty person.id?'POST':'PUT'}">
					<div class="form-group"></div>
					<div class="form-group">
						<c:if test="${!empty person.id}">
							<label for="number" class="col-xs-1 control-label">编号：</label>
							<div class="col-xs-2">
								<form:input path="number" id="number" cssClass="form-control" readonly="true"/>
							</div>
						</c:if>
						<label for="parentId" class="col-xs-1 control-label">上级人员：</label>
						<div class="col-xs-2">
							<form:select path="parentId" id="parentId" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${listPerson}" itemLabel="name" itemValue="id"/>
							</form:select>
						</div>
						<label for="name" class="col-xs-1 control-label">姓名：</label>
						<div class="col-xs-2">
							<form:input path="name" id="name" cssClass="form-control required" readonly="${!empty person.id?true:false}"/>
						</div>
					</div>
					<div class="form-group">
						<label for="shortName" class="col-xs-1 control-label">简称：</label>
						<div class="col-xs-2">
							<form:input path="shortName" id="shortName" cssClass="form-control" />
						</div>
						<label class="col-xs-1 control-label">性别：</label>
						<div class="col-xs-2">
							<label class="radio-inline">
								<form:radiobutton path="sex" value="男" />男
							</label>
							<label class="radio-inline">
								<form:radiobutton path="sex" value="女" />女
							</label>
						</div>
					</div>
					<div class="form-group">
						<label for="birthday" class="col-xs-1 control-label">出生日期：</label>
						<div class="col-xs-2">
							<div class='input-group date' id='birthdayDatetimepicker'>
								<form:input path="birthday" id="birthday" class="form-control" />
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<label for="age" class="col-xs-1 control-label">年龄：</label>
						<div class="col-xs-2">
							<form:input path="age" id="age" cssClass="form-control"/>
						</div>
						<label for="identification" class="col-xs-1 control-label">身份证：</label>
						<div class="col-xs-2">
							<form:input path="identification" id="identification" cssClass="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label for="phone" class="col-xs-1 control-label">电话：</label>
						<div class="col-xs-2">
							<form:input path="phone" id="phone" cssClass="form-control"/>
						</div>
						<label for="emergencyContactPhone" class="col-xs-1 control-label">紧急电话：</label>
						<div class="col-xs-2">
							<form:input path="emergencyContactPhone" id="emergencyContactPhone" cssClass="form-control" />
						</div>
						<label for="mail" class="col-xs-1 control-label">邮箱：</label>
						<div class="col-xs-2">
							<form:input path="mail" id="mail" cssClass="form-control" placeholder="电子邮箱" />
						</div>
					</div>
					<div class="form-group">
						<label for="height" class="col-xs-1 control-label">身高：</label>
						<div class="col-xs-2">
							<form:input path="height" id="height" cssClass="form-control" />
						</div>
						<label for="qq" class="col-xs-1 control-label">QQ：</label>
						<div class="col-xs-2">
							<form:input path="qq" id="qq" cssClass="form-control" />
						</div>
						<label for="weixin" class="col-xs-1 control-label">微信：</label>
						<div class="col-xs-2">
							<form:input path="weixin" id="weixin" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="weight" class="col-xs-1 control-label">体重：</label>
						<div class="col-xs-2">
							<form:input path="weight" id="weight" cssClass="form-control" />
						</div>
						<label for="zodiac" class="col-xs-1 control-label">生肖：</label>
						<div class="col-xs-2">
							<form:select path="zodiac" id="zodiac" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${fns:getLineList('zodiacs')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
						<label for="constellations" class="col-xs-1 control-label">星座：</label>
						<div class="col-xs-2">
							<form:select path="constellations" id="constellations" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${fns:getLineList('constellations')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="nation" class="col-xs-1 control-label">民族：</label>
						<div class="col-xs-2">
							<form:select path="nation" id="nation" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${fns:getLineList('nations')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
						<label for="bloodType" class="col-xs-1 control-label">血型：</label>
						<div class="col-xs-2">
							<form:select path="bloodType" id="bloodType" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${fns:getLineList('bloodTypes')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
						<label for="profession" class="col-xs-1 control-label">职业：</label>
						<div class="col-xs-2">
							<form:input path="profession" id="profession" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">省份：</label>
						<div class="col-xs-2">
							<form:select id="province" path="province" onchange="doProvAndCityRelation();" cssClass="form-control">
								<form:option id="choosePro" value="">--请选择--</form:option>
							</form:select>
						</div>
						<label class="col-xs-1 control-label">城市：</label>
						<div class="col-xs-2">
							<form:select id="city" path="city" onchange="doCityAndCountyRelation();" cssClass="form-control">
								<form:option id="chooseCity" value="">--请选择--</form:option>
							</form:select>
						</div>
						<label class="col-xs-1 control-label">区域：</label>
						<div class="col-xs-2">
							<form:select id="county" path="county" cssClass="form-control">
								<form:option id="chooseCounty" value="">--请选择--</form:option>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="address" class="col-xs-1 control-label">详细地址：</label>
						<div class="col-xs-2">
							<form:textarea path="address" id="address" cssClass="form-control" rows="2"/>
						</div>
						<label for="dream" class="col-xs-1 control-label">梦想：</label>
						<div class="col-xs-2">
							<form:textarea path="dream" id="dream" cssClass="form-control" rows="2"/>
						</div>
						<label for="remark" class="col-xs-1 control-label">描述：</label>
						<div class="col-xs-2">
							<form:textarea path="remark" id="remark" cssClass="form-control" rows="2"/>
						</div>
					</div>
					<div class="form-group">
						<label for="hobbiesInterests" class="col-xs-1 control-label">爱好：</label>
						<div class="col-xs-10">
							<form:hidden path="hobbiesInterests" id="hobbies"/>
							<c:forEach items="${fns:getLineList('hobbiesInterests')}" var="item">
								<label class="checkbox-inline">
									<input type="checkbox" name="hobbies" value="${item.code}"/>${item.name}
								</label>
							</c:forEach>
						</div>
					</div>
					<div class="form-group">
						<label for="status" class="col-xs-1 control-label">状态：</label>
						<div class="col-xs-2">
							<form:select path="status" id="status" cssClass="form-control select2">
								<form:options items="${fns:getLineList('statuses')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label"></label>
						<div class="col-xs-10">
							<button class="btn btn-primary" type="submit">保存</button>
							<button class="btn btn-info" type="button" onclick="window.location.href='${ctx}/api/v1/person'">返回</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
		//数组去除空的值
		Array.prototype.notempty = function(){
			for(var i = 0; i < this.length; i++){
		         if(this[i] == "" || typeof(this[i]) == "undefined"){
		        	 this.splice(i, 1);
		              i--;
		         }
			 }
			return this;
		}
		
		//表单提交
	    function submitForm(){
	    	return true;
	    }
	    
	    $(document).ready(function() {
	    	//页面加载完初始化省市区下拉框
	    	initProvince("${person.province}");
	    	doProvAndCityRelation("${person.city}");
	    	doCityAndCountyRelation("${person.county}");
	    	
	    	//兴趣爱好复选框事件
	    	var chboxes = $(':checkbox[name=hobbies]');
	        chboxes.on('ifChecked ifUnchecked', function(event) {  
	        	var val = event.target.value;
	        	var hobbies = $("#hobbies").val();//老的爱好
	            if (event.type == 'ifChecked') {
	            	if(hobbies == '' || hobbies == undefined){
						hobbies = val;
					}else{
						if(hobbies.indexOf(val) == -1){
							hobbies += ","+ val;
						}
					}
	            } else {
	            	if(hobbies.indexOf(val) != -1){
						hobbies = hobbies.replace(val,"");
					}
	            }
	            $("#hobbies").val(hobbies.split(",").notempty());
	        });
	        
	    	//兴趣爱好复选框选中
	    	var hobbies = '${person.hobbiesInterests}';
	    	var hobbiesArr = hobbies.split(",");
	    	$.each(hobbiesArr, function(index, val) {
	            $(':checkbox[name=hobbies][value='+val+']').parent().addClass("checked");       
	        });
	        
	    	//上传人员照片
		    $("#fileupload").fileupload({
		        autoUpload: true,//立即上传
		        acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i,
		        maxFileSize: 5242880 // 5 MB
			}).on('fileuploadadd', function (e, data) {
				   	data.submit();
			}).on('fileuploadprocessalways', function (e, data) {
				if(data.files.error){
				   if(data.files[0].error=='File type not allowed'){
					   $("#f_error").html("图片类型错误");
				   }
				   if(data.files[0].error=='File is too large'){
					   $("#f_error").html("图片不能大于5M");
				   }  
				}else{
					$("#f_error").html("");
				} 
			}).on('fileuploaddone', function (e, data) {
		      	if(data.result.code == 0){
		    	  	var fileName = data.result.data[0].name;
		    	  	var location = data.result.data[0].location;
		    	  	$("#per_photo").attr("src", "${ctx}/upload/"+location);
		    	  	$("#photo").val(fileName);
			  	}else{
			  		$("#f_error").html("图片上传失败");
			  	}
			});

	    	$(":file").filestyle({
	    		buttonText: "上传头像",
	    		classButton: "btn btn-primary",
	    		classInput: "form-control file-upload",
	    		classIcon: "fa-plus-sign"
	    	});
	    	
	    	$('#birthdayDatetimepicker').datetimepicker({
				format : 'YYYY-MM-DD',
				locale : moment.locale('zh-cn')
			});
	
	    	$("#personForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			wrap = element.parent();
	    			wrap1 = wrap.parent();
	    			if (wrap1.hasClass('checkbox') || wrap1.hasClass('radio-inline')) {
	    				error.insertAfter(wrap1);
	    			} else {
	    				if (element.attr('type')=='file') {
	    					error.insertAfter(element.next());
	    				} else {
	    					error.insertAfter(element);
	    				}
	    			}
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			name: {
	    				required: true,
	    				remote: "${ctx}/api/v1/person/unique?id=${person.id}"
	    			},
	    			mail: {
	    				email: true
	    			},
	    			phone: {
	    				rangelength: [7, 11]
	    			}
	    		},
	    		messages: {
	    			name: {
	    				required: "姓名不能为空",
	    				remote: '姓名已存在'
	    			},
	    			mail: {
	    				email: "邮箱格式不正确"
	    			},
	    			phone: {
	    		      	rangelength: $.validator.format("电话只能7-11位")
	    		    }
	    		},
	    		highlight: function(element) {
	    			$(element).addClass("validator_error");
	    	    },
	    	    unhighlight: function(element,errorClass) {
	    	    	$(element).addClass("validator_success");
	    		}
	    	});
		});
	</script>
</body>
</html>


