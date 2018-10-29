<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>用户管理</title>
<%@ include file="/templates/include.jsp"%>
<script src="<%=request.getContextPath()%>/static/assets/plugins/forms/icheck/jquery.icheck.js"></script>
</head>

<body>
	<div class="content-wrapper">
		<div class="col-xs-12 heading">
			<h1 class="page-header">${empty user.id?'添加':'修改'}用户</h1><hr/>
		</div>
		<div class="outlet">
			<div class="panel-body">
				<form id="fileupload" action="${ctx}/api/v1/user/upload" method="POST" enctype="multipart/form-data" class="form-horizontal group-border hover-stripped">
					<div class="form-group">
						<label class="col-xs-1 control-label">头像：</label>
						<div class="col-xs-5">
							<input type="file" name="file" id="file">
							<span class="help-block" id="f_error"></span>
						</div>
						<div class="col-xs-5">
							<c:if test="${empty user.headimgurl}">
								<img alt="" src="${ctx}/uploads/headImg/boy.png" id="headImg" width="50" height="50">
							</c:if>
							<c:if test="${!empty user.headimgurl}">
								<img alt="" src="${ctx}/uploads/headImg/${user.headimgurl}" id="headImg" width="50" height="50">
							</c:if>
						</div>
					</div>
					<div class="form-group"></div>
				</form>
				
				<form:form modelAttribute="user" action="${ctx}/api/v1/user" role="form" id="userForm" onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<form:hidden path="headimgurl" id="headimgurl" />
					<input type="hidden" name="_method" value="${empty user.id?'POST':'PUT'}">
					
					<div class="form-group">
						<label for="code" class="col-xs-1 control-label">用户名：</label>
						<div class="col-xs-2">
							<form:input path="code" id="code" cssClass="form-control required" />
						</div>
						<label for="name" class="col-xs-1 control-label">姓名：</label>
						<div class="col-xs-2">
							<form:input path="name" id="name" cssClass="form-control required"/>
						</div>
					</div>
					<div class="form-group">
						<label for="workNumber" class="col-xs-1 control-label">工号：</label>
						<div class="col-xs-2">
							<form:input path="workNumber" id="workNumber" cssClass="form-control" />
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
						<label for="password" class="col-xs-1 control-label">密码：</label>
						<div class="col-xs-2">
							<form:password path="password" id="password" cssClass="form-control" placeholder="输入密码" />
						</div>
						<label for="email" class="col-xs-1 control-label">邮箱：</label>
						<div class="col-xs-2">
							<form:input path="email" id="email" cssClass="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label for="mobile" class="col-xs-1 control-label">手机：</label>
						<div class="col-xs-2">
							<form:input path="mobile" id="mobile" cssClass="form-control" />
						</div>
						<label for="telephone" class="col-xs-1 control-label">电话：</label>
						<div class="col-xs-2">
							<form:input path="telephone" id="telephone" cssClass="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">公司：</label>
						<div class="col-xs-2">
							<form:select path="unitId" id="unitId" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${listCompany}" itemValue="id" itemLabel="name" />
							</form:select>
						</div>
						<label class="col-xs-1 control-label">部门：</label>
						<div class="col-xs-2">
							<form:select path="deptId" id="deptId" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${listDept}" itemValue="id" itemLabel="name" />
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-xs-1 control-label">描述：</label>
						<div class="col-xs-5">
							<form:textarea path="remark" id="remark" cssClass="form-control" rows="2"/>
						</div>
					</div>
					<div class="form-group">
						<label for="roleId" class="col-xs-1 control-label">角色：</label>
						<div class="col-xs-2">
							<c:choose>
								<c:when test="${empty user.id}">
									<form:select path="roleId" id="roleId" cssClass="form-control select2">
										<form:option value="">请选择</form:option>
										<form:options items="${listRoles}" itemValue="id" itemLabel="name" />
									</form:select>
								</c:when>
								<c:otherwise>
									<form:select path="roleId" id="roleId" disabled="true" cssClass="form-control select2">
										<form:option value="">请选择</form:option>
										<form:options items="${listRoles}" itemValue="id" itemLabel="name" />
									</form:select>
								</c:otherwise>
							</c:choose>
						</div>
						<label for="status" class="col-xs-1 control-label">状态：</label>
						<div class="col-xs-2">
							<form:select path="status" id="status" cssClass="form-control select2">
								<form:options items="${fns:getLineList('statuses')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">是否锁定：</label>
						<div class="col-xs-5">
							<label class="radio-inline">
								<form:radiobutton path="loginFlag" value="1" />可登录
							</label>
							<label class="radio-inline">
								<form:radiobutton path="loginFlag" value="0" />长期锁定
							</label>
							<label class="radio-inline">
								<form:radiobutton path="loginFlag" value="2" />短期锁定
							</label>
						</div>
					</div>
					<div class="form-group">
						<label for="lockDay" class="col-xs-1 control-label">锁定天数：</label>
						<div class="col-xs-2">
							<form:input path="lockDay" id="lockDay" cssClass="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label"></label>
						<div class="col-xs-10">
							<button class="btn btn-primary" type="submit">保存</button>
							<button class="btn btn-info" type="button" onclick="history.go(-1)">返回</button>
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>

	<script type="text/javascript">
		//表单提交
	    function submitForm(){
	    	return true;
	    }
	    
	    $(document).ready(function() {
	
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
		    	  	var fileName = data.result.data.name;
		    	  	var location = data.result.data.location;
		    	  	$("#headImg").attr("src", "${ctx}/upload/"+location);
		    	  	$("#headimgurl").val(fileName);
			  	}else{
			  		$("#f_error").html("图片上传失败");
			  	}
			});
	    	    
	    	
	    	$('#unitId').change(function(){   
	    		var companyId = this.value;
	    		if(companyId != ''){
		    		$.ajax({
		    			type: 'get',
		    			url: '${ctx}/api/v1/unit/all',
		    			data: {"parentId":companyId},
		    			success: function(result){
		    				if(result.code == 0){
		    					$("#deptId").select2("val", ""); 
		    					var options = '<option value="">请选择</option>';
		    					for(var i = 0; i < result.data.length; i++){
		    						options +=  "<option value='"+result.data[i].id+"'>"+result.data[i].name+"</option>";
		    					}
		    					$("#deptId").html(options);
		    				}
		    			},error:function(e){
		    				alert("error"+e);
		    			}
		    		})
	    		}else{
	    			$("#deptId option:not(:first)").remove();
	    		}
			})
				
	    	$(":file").filestyle({
	    		buttonText: "上传头像",
	    		classButton: "btn btn-primary",
	    		classInput: "form-control file-upload",
	    		classIcon: "fa-plus-sign"
	    	});
	    	 
	    	//------------- Form validation -------------//
	    	$.validator.addMethod('filesize', function(value, element, param) {
	    	    // param = size (en bytes) 
	    	    // element = element to validate (<input>)
	    	    // value = value of the element (file name)
	    	    return (element.files[0].size <= param*1024) 
	    	});
	
	    	$("#userForm").validate({
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
	    			code: {
	    				required: true,
	    				remote: "${ctx}/api/v1/user/unique?id=${user.id}"
	    			},
	    			name: {
	    				required: true,
	    				remote: "${ctx}/api/v1/user/unique?id=${user.id}"
	    			},
	    			password: {
	    				//required: true,
	    				minlength: 6
	    			},
	    			email: {
	    				email: true
	    			},
	    			mobile: {
	    				rangelength: [11, 11]
	    			},
	    			telephone: {
	    		      rangelength: [7, 11]
	    		    }
	    		},
	    		messages: {
	    			code: {
	    				required: "用户名不能为空",
	    				remote: '用户名已存在'
	    			},
	    			name: {
	    				required: "姓名不能为空",
	    				remote: '姓名已存在'
	    			},
	    			password: {
	    				//required: "密码不能为空",
	    				minlength: "密码最少6位"
	    			},
	    			email: {
	    				email: "邮箱格式不正确"
	    			},
	    			mobile: {
	    				rangelength: $.validator.format("手机必须11位") 
	    			},
	    			telephone: {
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


