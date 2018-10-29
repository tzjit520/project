<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>功能管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty permission.id?'添加':'修改'}功能</h1><hr/>
			</div>
			<div class="row">
				<div class="panel-body">
					<form:form modelAttribute="permission" action="${ctx}/api/v1/permission" role="form" id="permissionForm" onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
						<form:hidden path="id" id="id" />
						<input type="hidden" name="_method" value="${empty permission.id?'POST':'PUT'}">
						<div class="form-group">
							<label for="resourceId" class="col-xs-1 control-label">资源名：</label>
							<div class="col-xs-2">
								<form:select path="resourceId" id="resourceId" cssClass="form-control select2 required">
									<form:option value="">请选择</form:option>
									<form:options items="${listResource}" itemValue="id" itemLabel="name" />
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<label for="operationId" class="col-xs-1 control-label">操作名：</label>
							<div class="col-xs-2">
								<form:select path="operationId" id="operationId" cssClass="form-control select2 required">
									<form:option value="">请选择</form:option>
									<form:options items="${listOperation}" itemValue="id" itemLabel="name" />
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<label for="remark" class="col-xs-1 control-label">描述：</label>
							<div class="col-xs-2">
								<form:textarea path="remark" id="remark" cssClass="form-control" rows="2" />
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
							<div class="col-xs-2">
								<button class="btn btn-primary" type="submit">保存</button>
								<button class="btn btn-info" type="button" onclick="window.location.href='${ctx}/api/v1/permission'">返回</button>
							</div>
						</div>
					</form:form>
				</div>
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
	    	$("#permissionForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			error.insertAfter(element);
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			resourceId: {
	    				required: true
	    			},
	    			operationId: {
	    				required: true
	    			}
	    		},
	    		messages: {
	    			resourceId: {
	    				required: "资源名不能为空"
	    			},
	    			operationId: {
	    				required: "操作名不能为空"
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


