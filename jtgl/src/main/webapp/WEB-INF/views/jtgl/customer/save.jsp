<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>客户管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty customer.id?'添加':'修改'}客户</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="customer" action="${ctx}/api/v1/customer" role="form" id="customerForm" 
					onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty customer.id?'POST':'PUT'}">

					<div class="form-group">
						<label for="code" class="col-xs-1 control-label">客户编号:</label>
						<div class="col-xs-2">
							<form:input path="code" id="code" cssClass="form-control required" />
						</div>
						<label for="name" class="col-xs-1 control-label">客户名称:</label>
						<div class="col-xs-2">
							<form:input path="name" id="name" cssClass="form-control required" />
						</div>
						<label for="shortName" class="col-xs-1 control-label">客户简称:</label>
						<div class="col-xs-2">
							<form:input path="shortName" id="shortName" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="contactor" class="col-xs-1 control-label">联系人:</label>
						<div class="col-xs-2">
							<form:input path="contactor" id="contactor" cssClass="form-control" />
						</div>
						<label for="mobile" class="col-xs-1 control-label">联系电话:</label>
						<div class="col-xs-2">
							<form:input path="mobile" id="mobile" cssClass="form-control" />
						</div>
						<label for="postal" class="col-xs-1 control-label">邮政编码:</label>
						<div class="col-xs-2">
							<form:input path="postal" id="postal" cssClass="form-control" />
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
						<label for="address" class="col-xs-1 control-label">详细地址:</label>
						<div class="col-xs-5">
							<form:textarea path="address" id="address" rows="2" cssClass="form-control" />
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
	    	initProvince("${customer.province}");
	    	doProvAndCityRelation("${customer.city}");
	    	doCityAndCountyRelation("${customer.county}");
			
			$("#customerForm").validate({
				ignore : null,
				ignore : 'input[type="hidden"]',
				errorPlacement : function(error, element) {
					error.insertAfter(element);
				},
				errorClass : 'help-block',
				rules : {
					code : {
						required : true
					},
					name : {
						required : true
					}
				},
				messages : {
					code : {
						required : "客户编号不能为空"
					},
					name : {
						required : "客户名称不能为空"
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


