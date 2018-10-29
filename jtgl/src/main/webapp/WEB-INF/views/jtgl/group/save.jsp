<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>产品分组管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty group.id?'添加':'修改'}产品分组</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="group" action="${ctx}/api/v1/group" role="form" id="itemForm" 
					onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty group.id?'POST':'PUT'}">
					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">分组名称:</label>
						<div class="col-xs-2">
							<form:input path="name" id="name" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-xs-1 control-label">描述:</label>
						<div class="col-xs-5">
							<form:textarea path="remark" id="remark" rows="2" cssClass="form-control" />
						</div>
					</div>
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

	    	$("#startDateDatetimepicker").datetimepicker({
				format : "YYYY-MM-DD",
				locale : moment.locale("zh-cn")
			});
	    	
	    	$("#endDateDatetimepicker").datetimepicker({
				format : "YYYY-MM-DD",
				locale : moment.locale("zh-cn")
			});
	    	
			$("#itemForm").validate({
				ignore : null,
				ignore : 'input[type="hidden"]',
				errorPlacement : function(error, element) {
					error.insertAfter(element);
				},
				errorClass : 'help-block',
				rules : {},
				messages : {
					name : {
						required : "分组名称不能为空"
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


