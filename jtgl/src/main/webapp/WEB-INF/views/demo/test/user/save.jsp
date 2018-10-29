<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>CRUD-DEMO</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty testUser.id?'添加':'修改'}</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="testUser" action="${ctx}/api/v1/test" role="form" id="testUserForm" onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty testUser.id?'POST':'PUT'}">

					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">姓名:</label>
						<div class="col-xs-2">
							<form:input path="name" id="name" cssClass="form-control required" />
						</div>
						<label for="nickName" class="col-xs-1 control-label">昵称:</label>
						<div class="col-xs-2">
							<form:input path="nickName" id="nickName" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="sex" class="col-xs-1 control-label">性别:</label>
						<div class="col-xs-2">
							<label class="radio-inline">
								<form:radiobutton path="sex" value="男" />男
							</label>
							<label class="radio-inline">
								<form:radiobutton path="sex" value="女" />女
							</label>
						</div>
						<label for="age" class="col-xs-1 control-label">年龄:</label>
						<div class="col-xs-2">
							<form:input path="age" id="age" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="birthday" class="col-xs-1 control-label">出生日期:</label>
						<div class="col-xs-2">
							<div class='input-group date' id='birthdayDatetimepicker'>
								<form:input path="birthday" id="birthday" class="form-control" />
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<label for="status" class="col-xs-1 control-label">状态:</label>
						<div class="col-xs-2">
							<form:select path="status" id="status" cssClass="form-control select2">
								<form:options items="${fns:getLineList('statuses')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="info" class="col-xs-1 control-label">简介:</label>
						<div class="col-xs-5">
							<form:textarea path="info" id="info" rows="2" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-xs-1 control-label">描述:</label>
						<div class="col-xs-5">
							<form:textarea path="remark" id="remark" rows="2" cssClass="form-control" />
						</div>
					</div>
					<%-- <div class="form-group">
                     <form id="uploadImgForm" action="${ctx}/api/v1/user/upload" method="POST" enctype="multipart/form-data">
                         <label class="col-xs-1 control-label">照片:</label>
                         <div class="col-xs-5 ">
                             <input type="file" name="fileImg" id="fileImg">
                         </div>
                     </form>
                    </div>
                    <div class="form-group">
                     <form id="uploadAttachmentForm" action="${ctx}/api/v1/user/upload" method="POST" enctype="multipart/form-data">
                         <label class="col-xs-1 control-label">上传附件:</label>
                         <div class="col-xs-5">
                             <input type="file" name="fileAtt" id="fileAttachment">
                         </div>
                     </form>
                    </div> --%>
					<div class="form-group">
						<div class="col-xs-offset-1">
							<input type="submit" value="保存" class="btn btn-primary ml15" />
							<input type="button" value="返回" onclick="history.go(-1)" class="btn btn-info ml15" />
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>

	<script type="text/javascript">
		//表单提交
		function submitForm() {
			return true;
		}

		$(document).ready(function() {
			/* $("#fileImg").filestyle({
				buttonText: "上传头像",
				classButton: "btn btn-primary",
				classInput: "form-control file-upload",
				classIcon: "fa-plus-sign"
			});
			
			$("#fileAttachment").filestyle({
				buttonText: "上传附件",
				classButton: "btn btn-primary",
				classInput: "form-control file-upload",
				classIcon: "fa-plus-sign"
			}); */

			$('#birthdayDatetimepicker').datetimepicker({
				format : 'YYYY-MM-DD',
				locale : moment.locale('zh-cn')
			});

			$("#testUserForm").validate({
				ignore : null,
				ignore : 'input[type="hidden"]',
				errorPlacement : function(error, element) {
					error.insertAfter(element);
				},
				errorClass : 'help-block',
				rules : {
					name : {
						required : true
					}
				},
				messages : {
					name : {
						required : "姓名不能为空"
					}
				},
				highlight : function(element) {
					$(element).addClass("validator_error");
				},
				unhighlight : function(element, errorClass) {
					$(element).addClass("validator_success");
				}
			});
		});
	</script>
</body>
</html>


