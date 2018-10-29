<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>定时任务</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty scheduleJob.id?'添加':'修改'}定时任务</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="scheduleJob" action="${ctx}/api/v1/task" role="form" id="scheduleJobForm" onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty scheduleJob.id?'POST':'PUT'}">
					<div class="form-group">
						<label for="jobName" class="col-xs-1 control-label">任务名称：</label>
						<div class="col-xs-2">
							<form:input path="jobName" id="jobName" cssClass="form-control required" />
						</div>
						<label for="beanName" class="col-xs-1 control-label">bean名称：</label>
						<div class="col-xs-2">
							<form:input path="beanName" id="beanName" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="className" class="col-xs-1 control-label">目标类：</label>
						<div class="col-xs-2">
							<form:input path="className" id="className" cssClass="form-control" />
						</div>
						<label for="methodName" class="col-xs-1 control-label">目标方法：</label>
						<div class="col-xs-2">
							<form:input path="methodName" id="methodName" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="cronExpression" class="col-xs-1 control-label">cron表达式：</label>
						<div class="col-xs-2">
							<form:input path="cronExpression" id="cronExpression" cssClass="form-control required" />
						</div>
						<label class="col-xs-1 control-label">是否并发执行：</label>
						<div class="col-xs-2">
							<c:forEach items="${fns:getLineList('isConcurrent')}" var="item">
								<label class="radio-inline">
									<form:radiobutton path="concurrent" value="${item.code}"/>${item.name}
								</label>
							</c:forEach>
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-xs-1 control-label">任务描述：</label>
						<div class="col-xs-5">
							<form:textarea path="remark" id="remark" cssClass="form-control" rows="2" />
						</div>
					</div>
					<div class="form-group">
						<label for="status" class="col-xs-1 control-label">任务状态：</label>
						<div class="col-xs-2">
							<form:select path="status" id="status" cssClass="form-control select2">
								<form:options items="${fns:getLineList('scheduleStatus')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label"></label>
						<div class="col-xs-2">
							<button class="btn btn-primary" type="submit">保存</button>
							<button class="btn btn-info" type="button" onclick="window.location.href='${ctx}/api/v1/task'">返回</button>
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
	    	$("#scheduleJobForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			error.insertAfter(element);
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			jobName: {
	    				required: true
	    			},
	    			methodName: {
	    				required: true
	    			},
	    			cronExpression: {
	    				required: true
	    			}
	    		},
	    		messages: {
	    			jobName: {
	    				required: "任务名称不能为空"
	    			},
	    			methodName: {
	    				required: "目标方法不能为空"
	    			},
	    			cronExpression: {
	    				required: "cron表达式不能为空"
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


