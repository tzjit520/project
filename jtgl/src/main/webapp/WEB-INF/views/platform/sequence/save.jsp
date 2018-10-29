<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>序列管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty sequence.id?'添加':'修改'}序列</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="sequence" action="${ctx}/api/v1/sequence" onsubmit="return submitForm()" role="form" id="sequenceForm" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty sequence.id?'POST':'PUT'}">

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
						<label for="formartStr" class="col-xs-1 control-label">规则：</label>
						<div class="col-xs-2">
							<form:input path="formartStr" id="formartStr" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="seqNumber" class="col-xs-1 control-label">起始值：</label>
						<div class="col-xs-2">
							<form:input path="seqNumber" id="seqNumber" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label for="seqStep" class="col-xs-1 control-label">步长：</label>
						<div class="col-xs-2">
							<form:input path="seqStep" id="seqStep" cssClass="form-control" />
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
							<button class="btn btn-info" type="button" onclick="window.location.href='${ctx}/api/v1/sequence'">返回</button>
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
	    	$("#sequenceForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			error.insertAfter(element);
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			code: {
	    				required: true,
	    				remote: "${ctx}/api/v1/sequence/unique?id=${sequence.id}"
	    			},
	    			name: {
	    				required: true,
	    				remote: "${ctx}/api/v1/sequence/unique?id=${sequence.id}"
	    			},
	    			formartStr: {
	    				required: true
	    			},
	    			seqNumber: {
	    				required: true
	    			}
	    		},
	    		messages: {
	    			code: {
	    				required: "编码不能为空",
	    				remote: '编码已存在'
	    			},
	    			name: {
	    				required: "名称不能为空",
	    				remote: '名称已存在'
	    			},
	    			formartStr: {
	    				required: "规则不能为空"
	    			},
	    			seqNumber: {
	    				required: "起始值不能为空"
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


