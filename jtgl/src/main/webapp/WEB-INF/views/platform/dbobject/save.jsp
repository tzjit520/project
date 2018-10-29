<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>数据对象管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty dbobject.id?'添加':'修改'}数据对象</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="dbobject" action="${ctx}/api/v1/dbobject" onsubmit="return submitForm()" dbobject="form" id="dbobjectForm" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty dbobject.id?'POST':'PUT'}">

					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">名称：</label>
						<div class="col-xs-2">
							<form:input path="name" id="name" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="code" class="col-xs-1 control-label">编码：</label>
						<div class="col-xs-2">
							<form:input path="code" id="code" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="sqlStatements" class="col-xs-1 control-label">SQL：</label>
						<div class="col-xs-2">
							<form:textarea path="sqlStatements" id="sqlStatements" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-xs-1 control-label">描述：</label>
						<div class="col-xs-2">
							<form:input path="remark" id="remark" cssClass="form-control" />
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
							<button class="btn btn-info" type="button" onclick="window.location.href='${ctx}/api/v1/dbobject'">返回</button>
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
	    	$("#dbobjectForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			error.insertAfter(element);
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			code: {
	    				required: true,
	    				remote: "${ctx}/api/v1/dbobject/unique?id=${dbobject.id}"
	    			},
	    			name: {
	    				required: true,
	    				remote: "${ctx}/api/v1/dbobject/unique?id=${dbobject.id}"
	    			},
	    			sqlStatements: {
	    				required: true
	    			}
	    		},
	    		messages: {
	    			code: {
	    				required: "数据对象编码不能为空",
	    				remote: '数据对象编码已存在'
	    			},
	    			name: {
	    				required: "数据对象名称不能为空",
	    				remote: '数据对象名称已存在'
	    			},
	    			sqlStatements: {
	    				required: "SQL不能为空"
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


