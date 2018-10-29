<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>代码生成</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">代码生成</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="sysTable" class="form-horizontal group-border hover-stripped" method="get" role="form" id="seachForm" cssStyle="padding-bottom:20px;">
					<form:hidden path="pageIndex" id="pageIndex" />
					<form:hidden path="pageSize" id="pageSize" />
					<div class="form-group">
						<label for="tableName" class="col-xs-1 control-label">表名：</label>
						<div class="col-xs-2">
							<form:input path="tableName" id="tableName" cssClass="form-control" />
						</div>
						<div class="col-xs-5">
							<input type="button" class="btn btn-primary" onclick="page()" value="查询">
							<shiro:hasPermission name="generator:view">
								<input type="button" class="btn btn-purple" id="gcModel" value="生成代码" />
							</shiro:hasPermission>
						</div>
					</div>
				</form:form>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th style="width: 5px">
								<input type="checkbox" id="parentCheckbox">
							</th>
							<th>表名</th>
							<th>数据记录数</th>
							<th>描述</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.data}" var="tab">
							<tr>
								<td>
									<input type="checkbox" value="${tab.tableName}" name="child_items">
								</td>
								<td>${tab.tableName}</td>
								<td>${tab.rows}</td>
								<td>${tab.comment}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="form-group" style="margin-top: -20px">
					<div id="page"></div>
				</div>
				<!-- 生成代码 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
					<div class="modal-dialog" style="width: 600px">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModal2Label">生成代码</h4>
							</div>
							<div class="modal-body">
								<form id="generatorForm" name="generatorForm" class="form-horizontal" style="padding-left: 20px;">
									<div class="form-group">
										<label for="packageName" class="col-xs-2 control-label">包名:</label>
										<div class="col-xs-5">
											<input type="text" id="packageName" name="packageName" class="form-control required">
										</div>
										<div class="col-xs-5">
											<button type="button" class="btn btn-primary" onclick="generatorCode()">确定</button>
											<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
	    $(function(){
		    $("#generatorForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			error.insertAfter(element);
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			packageName: {
	    				required: true
	    			}
	    		},
	    		messages: {
	    			packageName: {
	    				required: "包名不能为空"
	    			}
	    		},
	    		highlight: function(element) {
	    			$(element).addClass("validator_error");
	    	    },
	    	    unhighlight: function(element,errorClass) {
	    	    	$(element).addClass("validator_success");
	    		}
	    	});
		    
		    $("#gcModel").click(function(){
		    	var node_count = $("[name=child_items]:checked").length;
				if(node_count <= 0){
					$alert("请最少选择一张表!",'提示');
					return ;
				}else{
					$('#myModal').modal('show');
				}
		    });
		})

		//代码生成
		function generatorCode(){
	    	var nodes = $("[name=child_items]:checked");
			var tableNames = "";
			for(var i = 0 ; i < nodes.length ; i++){
				var node = nodes[i];
				if(i == 0){
					tableNames += node.value;
				}else{
					tableNames += ","+ node.value;
				}
			}
			$("#tableNames").val(tableNames);
			var packageName = $("#packageName").val();
	    	$.ajax({
				type: "POST",
    			url: "${ctx}/api/v1/generator",
    			data: {
    				"tableNames": tableNames,
    				"packageName": packageName
    			},
    			success:function(result){
    				if(result.code == 0){
    					$('#myModal').modal('hide');
    					$alert("代码生成成功","提示");
    				}
    			}
    		});
	    }
	    
		createPageNav({
		  $container: $("#page"),
			pageCount: '${page.pageCount}',//总页数
			currentNum: '${page.pageIndex}',//当前页码
			totalCount: '${page.total}', //总数量
			pageSize: '${page.pageSize}',//每页显示多少条
			maxCommonLen: 8,
			beforeFun: page
		});

		function page(num, pageSize){
			if(num == undefined){
				num = 1;
			}
			if(pageSize == undefined){
				pageSize = 15;
			}
			$("#pageIndex").val(num);
			$("#pageSize").val(pageSize);
			$("#seachForm").attr("action","${ctx}/api/v1/generator");
			$("#seachForm").submit();
		}
    </script>
</body>
</html>


