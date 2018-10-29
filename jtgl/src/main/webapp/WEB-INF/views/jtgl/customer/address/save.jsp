<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>客户地址管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty customerAddress.id?'添加':'修改'}客户地址</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="customerAddress" action="${ctx}/api/v1/address" role="form" id="customerForm" 
					onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty customerAddress.id?'POST':'PUT'}">

					<div class="form-group">
						<label for="customerId" class="col-xs-1 control-label">客户名称:</label>
						<div class="col-xs-2">
							<form:select path="customerId" id="customerId" cssClass="form-control required">
								<form:option value="">请选择</form:option>
								<form:options items="${listCustomer}" itemLabel="name" itemValue="id"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="postal" class="col-xs-1 control-label">邮政编码:</label>
						<div class="col-xs-2">
							<form:input path="postal" id="postal" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">省份：</label>
						<div class="col-xs-2">
							<form:select id="province" path="province" onchange="doProvAndCityRelation();" cssClass="form-control required">
								<form:option id="choosePro" value="">--请选择--</form:option>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">城市：</label>
						<div class="col-xs-2">
							<form:select id="city" path="city" onchange="doCityAndCountyRelation();" cssClass="form-control required">
								<form:option id="chooseCity" value="">--请选择--</form:option>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">区域：</label>
						<div class="col-xs-2">
							<form:select id="county" path="county" cssClass="form-control">
								<form:option id="chooseCounty" value="">--请选择--</form:option>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="address" class="col-xs-1 control-label">详细地址:</label>
						<div class="col-xs-5">
							<form:textarea path="address" id="address" rows="2" cssClass="form-control required" />
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
			//页面加载完初始化省市区下拉框
	    	initProvince("${customerAddress.province}");
	    	doProvAndCityRelation("${customerAddress.city}");
	    	doCityAndCountyRelation("${customerAddress.county}");
			
			$("#customerForm").validate({
				ignore : null,
				ignore : 'input[type="hidden"]',
				errorPlacement : function(error, element) {
					error.insertAfter(element);
				},
				errorClass : 'help-block',
				rules : {},
				messages : {
					customerId : {
						required : "客户名称不能为空"
					},
					province : {
						required : "省份不能为空"
					},
					city : {
						required : "城市不能为空"
					},
					address : {
						required : "详细地址不能为空"
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


