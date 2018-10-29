<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>组织机构管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty unit.id?'添加':'修改'}机构</h1><hr/>
			</div>
			<div class="row">
				<div class="panel-body">
					<form:form modelAttribute="unit" action="${ctx}/api/v1/unit" role="form" id="unitForm" onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
						<form:hidden path="id" id="id" />
						<input type="hidden" name="_method" value="${empty unit.id?'POST':'PUT'}">
						<div class="form-group">
							<label for="name" class="col-xs-1 control-label">名称：</label>
							<div class="col-xs-2">
								<form:input path="name" id="name" cssClass="form-control required" />
							</div>
							<label for="code" class="col-xs-1 control-label">编码：</label>
							<div class="col-xs-2">
								<form:input path="code" id="code" cssClass="form-control required" />
							</div>
						</div>
						<div class="form-group">
							<label for="parentId" class="col-xs-1 control-label">上级机构：</label>
							<div class="col-xs-2">
								<form:select path="parentId" id="parentId" cssClass="form-control select2">
									<form:options items="${result}" itemLabel="name" itemValue="id" />
								</form:select>
							</div>
							<label for="type" class="col-xs-1 control-label">机构类型：</label>
							<div class="col-xs-2">
								<form:select path="type" id="type" cssClass="form-control select2">
									<form:option value="">请选择</form:option>
									<form:options items="${fns:getLineList('unitTypes')}" itemValue="code" itemLabel="name"/>
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<label for="sort" class="col-xs-1 control-label">排序：</label>
							<div class="col-xs-2">
								<form:input path="sort" id="sort" cssClass="form-control" />
							</div>
							<label for="status" class="col-xs-1 control-label">状态：</label>
							<div class="col-xs-2">
								<form:select path="status" id="status" cssClass="form-control select2">
									<form:options items="${fns:getLineList('statuses')}" itemLabel="name" itemValue="code"/>
								</form:select>
							</div>
						</div>
						<div class="form-group">
							<label for="remark" class="col-xs-1 control-label">机构描述：</label>
							<div class="col-xs-5">
								<form:textarea path="remark" id="remark" cssClass="form-control" rows="2" />
							</div>
						</div>
						<div class="form-group">
							<label class="col-xs-1 control-label"></label>
							<div class="col-xs-10">
								<button class="btn btn-primary" type="submit">保存</button>
								<button class="btn btn-info" type="button" onclick="window.location.href='${ctx}/api/v1/unit'">返回</button>
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
	    	$("#unitForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			error.insertAfter(element);
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			code: {
	    				required: true,
	    				remote: "${ctx}/api/v1/unit/unique?id=${unit.id}"
	    			},
	    			name: {
	    				required: true,
	    				remote: "${ctx}/api/v1/unit/unique?id=${unit.id}"
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


