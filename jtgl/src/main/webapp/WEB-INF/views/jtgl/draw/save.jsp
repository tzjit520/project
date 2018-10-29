<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>抽奖管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty draw.id?'添加':'修改'}抽奖信息</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="draw" action="${ctx}/api/v1/draw" role="form" id="itemForm" 
					onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty draw.id?'POST':'PUT'}">
					<div class="form-group">
						<label for="drawName" class="col-xs-1 control-label">抽奖名称:</label>
						<div class="col-xs-2">
							<form:input path="drawName" id="drawName" cssClass="form-control required" />
						</div>
						<label for="drawTitle" class="col-xs-1 control-label">抽奖标题:</label>
						<div class="col-xs-2">
							<form:input path="drawTitle" id="drawTitle" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="drawType" class="col-xs-1 control-label">抽奖类型:</label>
						<div class="col-xs-2">
							<form:select path="drawType" id="drawType" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:option value="activity_draw">活动抽奖</form:option>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="startDate" class="col-xs-1 control-label">开始日期:</label>
						<div class="col-xs-2">
							<div class="input-group date" id="startDateDatetimepicker">
								<form:input path="startDate" id="startDate" class="form-control" />
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<label for="endDate" class="col-xs-1 control-label">结束日期:</label>
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
						<label for="drawRatio" class="col-xs-1 control-label">抽奖比率:</label>
						<div class="col-xs-2">
							<form:select path="drawRatio" id="drawRatio" cssClass="form-control select2">
								<form:option value="percentage">百分比</form:option>
								<form:option value="odds_ratio">千分比</form:option>
							</form:select>
						</div>
						<label for="expiredDay" class="col-xs-1 control-label">过期天数:</label>
						<div class="col-xs-2">
							<form:input path="expiredDay" id="expiredDay" cssClass="form-control required" />
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
					drawName : {
						required : "抽奖名称不能为空"
					},
					drawTitle : {
						required : "抽奖标题不能为空"
					},
					drawType : {
						required : "抽奖类型不能为空"
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


