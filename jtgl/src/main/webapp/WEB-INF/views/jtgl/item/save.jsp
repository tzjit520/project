<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>产品管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty item.id?'添加':'修改'}产品</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="item" action="${ctx}/api/v1/item" role="form" id="itemForm" 
					onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty item.id?'POST':'PUT'}">
					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">产品名称:</label>
						<div class="col-xs-5">
							<form:input path="name" id="name" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="code" class="col-xs-1 control-label">产品编码:</label>
						<div class="col-xs-2">
							<form:input path="code" id="code" cssClass="form-control required" />
						</div>
						<label for="itemAlias" class="col-xs-1 control-label">产品简称:</label>
						<div class="col-xs-2">
							<form:input path="itemAlias" id="itemAlias" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="itemTypeId" class="col-xs-1 control-label">产品类型:</label>
						<div class="col-xs-2">
							<form:select path="itemTypeId" id="itemTypeId" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${listItemType}" itemLabel="name" itemValue="id"/>
							</form:select>
						</div>
						<label for="uom" class="col-xs-1 control-label">单位:</label>
						<div class="col-xs-2">
							<form:input path="uom" id="uom" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="startDate" class="col-xs-1 control-label">上架日期:</label>
						<div class="col-xs-2">
							<div class="input-group date" id="startDateDatetimepicker">
								<form:input path="startDate" id="startDate" class="form-control" />
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<label for="endDate" class="col-xs-1 control-label">下架日期:</label>
						<div class="col-xs-2">
							<div class="input-group date" id="endDateDatetimepicker">
								<form:input path="endDate" id="endDate" class="form-control" />
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label for="listPrice" class="col-xs-1 control-label">零售单价:</label>
						<div class="col-xs-2">
							<form:input path="listPrice" id="listPrice" cssClass="form-control required" />
						</div>
						<label for="sellingPrice" class="col-xs-1 control-label">销售单价:</label>
						<div class="col-xs-2">
							<form:input path="sellingPrice" id="sellingPrice" cssClass="form-control required" />
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
					code : {
						required : "产品编号不能为空"
					},
					name : {
						required : "产品名称不能为空"
					},
					listPrice : {
						required : "零售单价不能为空"
					},
					sellingPrice : {
						required : "销售单价不能为空"
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


