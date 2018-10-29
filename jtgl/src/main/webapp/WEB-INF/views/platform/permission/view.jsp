<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>权限管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="col-lg-12 heading">
			<!-- <h1 class="page-header">权限管理</h1> -->
		</div>
		<div class="outlet">
			<div class="panel-body">
				<form:form modelAttribute="permission" class="form-horizontal group-border hover-stripped" action="${ctx}/api/v1/permission/view" method="get" role="form" id="seachForm"
					cssStyle="padding-bottom:10px;">
					<div class="form-group">
						<label for="resourceName" class="col-xs-2 control-label">资源名称：</label>
						<div class="col-xs-2">
							<form:input path="resourceName" id="resourceName" cssClass="form-control" />
						</div>
						<label for="operationName" class="col-xs-2 control-label">操作名称：</label>
						<div class="col-xs-2">
							<form:input path="operationName" id="operationName" cssClass="form-control" />
						</div>
						<div class="col-xs-4">
							<input type="submit" class="btn btn-primary" value="查询">
						</div>
					</div>
				</form:form>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th style="width: 5px">
								<input type="checkbox" id="parentCheckbox">
							</th>
							<th>资源名称</th>
							<th>操作名称</th>
							<th>功能编码</th>
							<!-- <th>功能描述</th> -->
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="permission">
							<tr>
								<td>
									<input type="checkbox" value="${permission.permission}" <c:if test="${mapPer.get(permission.permission) != nukll }">checked="checked"</c:if> name="child_items">
								</td>
								<td>${permission.resourceName}</td>
								<td>${permission.operationName}</td>
								<td>${permission.permission}</td>
								<%-- <td>${permission.remark}</td> --%>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<input type="hidden" id="operations" value="${permission.permission}">
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
	    $(function(){
	    	var table = $('.table');
		    var chboxes = table.find('[type=checkbox]');

		    chboxes.on('ifChecked ifUnchecked', function(event) { 
		    	var operations = $("#operations").val();
		    	var value = event.target.value;
		        if (event.type == 'ifChecked') {
		            $(this).closest('tr').addClass('highlight');
		            if(operations == ""){
						operations = value;
					}else{
						if(operations.indexOf(value) == -1){
							operations += "," + value;
						}
					}
		        } else {
		            $(this).closest('tr').removeClass('highlight');
		            if(operations.indexOf(value+",") != -1){
			            operations = operations.replace(value+",","");
		            }
		            if(operations.indexOf(value) != -1){
			            operations = operations.replace(value,"");
		            }
		        }
		        $("#operations").val(operations);
		    });
	    	
	    	var $child_items = $("[name=child_items]");
		    $("#parentCheckbox").click(function(){
		    	$child_items.prop("checked",this.checked);
		    	if(this.checked){
					var operations = $("#operations").val();
					$child_items.each(function(index,domEle){
						var value = domEle.value;
						if(operations == ""){
							operations = value;
						}else{
							if(operations.indexOf(value) == -1){
								operations += "," + value;
							}
						}
					});
					$("#operations").val(operations);
				}else{
					$("#operations").val("");
				}
		    })
		    
			$child_items.click(function(){
		    	$("#parentCheckbox").prop("checked", $child_items.length == $("[name=child_items]:checked").length);
		    	var operations = $("#operations").val();
				var value = this.value;
				if(this.checked){//选中状态
					if(operations == ""){
						operations = value;
					}else{
						if(operations.indexOf(value) == -1){
							operations += "," + value;
						}
					}
					$("#operations").val(operations);
				}else{//取消选择
					var newOperations = "";
					var operationArr = operations.split(",");
					for(var i = 0 ; i < operationArr.length ; i++){
						if(value == operationArr[i]){
							continue;
						}else{
							if(newOperations == ""){
								newOperations = operationArr[i];
							}else{
								newOperations += "," + operationArr[i];
							}
						}
					}
					$("#operations").val(newOperations);
				}
			});
		})
    </script>
</body>
</html>


