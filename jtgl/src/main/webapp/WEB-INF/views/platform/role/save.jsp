<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>角色管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="col-xs-12 heading">
			<h1 class="page-header">${empty role.id?'添加':'修改'}角色</h1><hr/>
		</div>
		<div class="outlet">
			<div class="panel-body">
				<form:form modelAttribute="role" action="${ctx}/api/v1/role" role="form" id="roleForm" onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty role.id?'POST':'PUT'}">
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
						<label for="remark" class="col-xs-1 control-label">描述：</label>
						<div class="col-xs-2">
							<form:input path="remark" id="remark" cssClass="form-control" />
						</div>
						<label for="status" class="col-xs-1 control-label">状态：</label>
						<div class="col-xs-2">
							<form:select path="status" id="status" cssClass="form-control select2">
								<form:options items="${fns:getLineList('statuses')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">功能授权：</label>
						<div class="col-xs-4">
							<div style="height: 400px; overflow-x: auto; overflow-x: hidden;">
								<table id="treeTable" class="table table-bordered">
									<thead>
										<tr id="parent">
											<th></th>
											<th>功能名称</th>
											<th>功能编码</th>
										</tr>
									</thead>
									<c:forEach items="${listSysResource}" var="resource">
										<tbody id="tbody_${resource.code}" alt="${resource.code}">
											<tr id="${resource.code}" pid="parent">
												<td controller="true" style="width: 5px; vertical-align: middle;"></td>
												<td>
													<label class="checkbox-inline" style="font-size: 13px; font-weight: bold;">
														<input type="checkbox" id="${resource.code}_parent_items" />${resource.name}
													</label>
												</td>
												<td style="font-size: 13px; font-weight: bold; vertical-align: middle;">${resource.code}</td>
											</tr>
											<c:forEach items="${role.permissionList}" var="permission">
												<!-- 资源类型相等 -->
												<c:if test="${permission.resourceId == resource.id}">
													<tr id="${resource.code}_${permission.operationCode}" pid="${resource.code}">
														<td></td>
														<td style="font-size: 13px">
															&nbsp;&nbsp;&nbsp;&nbsp;
															<label class="checkbox-inline">
																<input type="checkbox" <c:if test="${rolePermissionMap.get(permission.id) != null}">checked="checked"</c:if> id="resources_${resource.code}_${permission.operationCode}"
																	value="${permission.id}" name="${resource.code}_child_items" />
																${permission.operationName}
															</label>
														</td>
														<td>${permission.operationCode}</td>
													</tr>
												</c:if>
											</c:forEach>
										</tbody>
									</c:forEach>
								</table>
							</div>
						</div>
						<label class="col-xs-1 control-label">用户授权：</label>
						<div class="col-xs-4">
							<div style="height: 400px; overflow-x: auto; overflow-x: hidden">
								<table class="table table-bordered">
									<thead>
										<tr id="parent">
											<th>
												<input type="checkbox" disabled="disabled" />
											</th>
											<th>用户编码</th>
											<th>用户名称</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${role.userList}" var="user">
											<tr>
												<td>
													<input type="checkbox" id="users_${user.code}" <c:if test="${userMap.get(user.id) != null}">checked="checked"</c:if> value="${user.id}" />
												</td>
												<td>${user.code}</td>
												<td>${user.name}</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label"></label>
						<div class="col-xs-4">
							<button class="btn btn-primary" type="submit">保存</button>
							<button class="btn btn-info" type="button" onclick="window.location.href='${ctx}/api/v1/role'">返回</button>
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
    		//获取所有选中的资源授权复选框
	    	var permission_cks = $("input[id^='resources_']:checked");
    		for(var i = 0; i < permission_cks.length; i++){
    			var permissionId = permission_cks[i].value;
	    		var input = '<input type="hidden" name="permissionList['+i+'].id" value="'+ permissionId +'">';
	   	      	$('#roleForm').append(input);
    		}
    		//获取所有选中的用户复选框
	    	var users_cks = $("input[id^='users_']:checked");
    		for(var u = 0; u < users_cks.length; u++){
    			var userId = users_cks[u].value;
	    		var input = '<input type="hidden" name="userList['+u+'].id" value="'+ userId +'">';
	   	      	$('#roleForm').append(input);
    		}
    		return true;
	    }
    
	    $(document).ready(function() {
	    	//treeTable
            var option = {
                expandLevel : 3,
                beforeExpand : function($treeTable, id) {},
                onSelect : function($treeTable, id) {}
            };
            $('#treeTable').treeTable(option);
            
	    	
          	//功能授权复选框全选
          	$("[id^=tbody_]").each(function(){
          		var alt = $(this).attr("alt");
          		$(this).checkAll({
    	    		masterCheckbox: "#"+alt+"_parent_items",
    	    		otherCheckboxes: "[name="+alt+"_child_items]"
    	    	})
       			$("#"+alt+"_parent_items").parent().addClass($("[name="+alt+"_child_items]").length == $("[name="+alt+"_child_items]:checked").length?"checked":"");
          	})
            
	    	$("#roleForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			error.insertAfter(element);
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			code: {
	    				required: true,
	    				remote: "${ctx}/api/v1/role/unique?id=${role.id}"
	    			},
	    			name: {
	    				required: true,
	    				remote: "${ctx}/api/v1/role/unique?id=${role.id}"
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


