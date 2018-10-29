<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>消息管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty message.id?'添加':'修改'}消息</h1>
				<hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="message" action="${ctx}/api/v1/message" role="form" id="messageForm" onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty message.id?'POST':'PUT'}">
					<div class="form-group">
						<label for="title" class="col-xs-1 control-label">标题:</label>
						<div class="col-xs-3">
							<form:input path="title" id="title" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="contText" class="col-xs-1 control-label">内容:</label>
						<div class="col-xs-3">
							<form:textarea path="content" id="contText" rows="2" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="type" class="col-xs-1 control-label">类型:</label>
						<div class="col-xs-3">
							<form:select path="type" id="type" cssClass="form-control select2 required">
								<form:option value="1">消息</form:option>
								<form:option value="2">公告</form:option>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-xs-1 control-label">描述:</label>
						<div class="col-xs-3">
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
	    function submitForm(){
	    	return true;
	    }
    
	    $(document).ready(function() {
	    	$("#messageForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			error.insertAfter(element);
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			title: {
	    				required: true
	    			},
	    			content: {
	    				required: true
	    			}
	    		},
	    		messages: {
	    			title: {
	    				required: "标题不能为空"
	    			},
	    			content: {
	    				required: "内容不能为空"
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


