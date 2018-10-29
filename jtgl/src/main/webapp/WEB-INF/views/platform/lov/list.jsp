<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>字典类型管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">字典类型管理</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="lov" class="form-horizontal group-border hover-stripped" method="get" lov="form" id="seachForm" cssStyle="padding-bottom:20px;">
					<form:hidden path="pageIndex" id="pageIndex" />
					<form:hidden path="pageSize" id="pageSize" />
					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">名称：</label>
						<div class="col-xs-2">
							<form:input path="name" id="name" cssClass="form-control" />
						</div>
						<label for="code" class="col-xs-1 control-label">编码：</label>
						<div class="col-xs-2">
							<form:input path="code" id="code" cssClass="form-control" />
						</div>
						<div class="col-xs-5">
							<input type="button" class="btn btn-primary" onclick="page()" value="查询">
							<shiro:hasPermission name="lov:add">
								<input type="button" id="btnAdd" class="btn btn-success" onclick="window.location.href='${ctx}/api/v1/lov/0'" value="添加">
							</shiro:hasPermission>
							<shiro:hasPermission name="lov:update">
								<input type="button" id="btnUpdate" class="btn btn-purple" value="修改">
							</shiro:hasPermission>
							<shiro:hasPermission name="lov:delete">
								<input type="button" id="btnDel" class="btn btn-danger" value="删除">
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
							<th>名称</th>
							<th>编码</th>
							<th>描述</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.data}" var="lov">
							<tr>
								<td>
									<input type="checkbox" value="${lov.id}" name="child_items">
								</td>
								<td>${lov.name}</td>
								<td>${lov.code}</td>
								<td>${lov.remark}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="form-group" style="margin-top: -20px">
					<div id="page"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
		//修改数据 
	    $('#btnUpdate').click(function() {
	    	var node_count = $("[name=child_items]:checked").length;
			if(node_count <= 0){
				$alert("请选择一行!",'提示');
				return ;
			}else if(node_count > 1){
				$alert("不能选择多行进行修改!",'提示');
				return ;
			}else{
				var id = $("[name=child_items]:checked")[0].value;
				window.location.href = "${ctx}/api/v1/lov/"+id;
			}
		});
    
	  	//删除数据
	    $('#btnDel').click(function() {
	    	var node_count = $("[name=child_items]:checked").length;
			if(node_count <= 0){
				$alert("请最少选择一行!",'提示');
				return ;
			}else{
				bootbox.confirm({
					title: "删除提示",
					message: "确定删除选中的数据?",
					buttons: {
				        confirm: {
				            label: '确定',
				            className: 'btn-success'
				        },
				        cancel: {
				            label: '取消',
				            className: 'btn-danger'
				        }
				    },
				    callback: function(result) {
				    	if(result){
				    		var ids = "";
							for(var i = 0 ; i < node_count ; i++){
								var node = $("[name=child_items]:checked")[i];
								if(i == 0){
									ids += node.value;
								}else{
									ids += ","+ node.value;
								}
							}
							var url = '${ctx}/api/v1/lov';
							$.ajax({
				    			type: 'post',
				    			url: url,
				    			data: {
				    				_method : "delete",
				    				ids: ids
			    				},
				    			success:function(data){
				    				if(data.code == 0){
				    					$.jBox.tip("删除成功", '提示');
				    					setTimeout(function(){
					    					window.location.href = url;
				    					}, 1500);
				    				}else{
				    					$alert(data.message,'错误提示');
				    				}
				    			}
				    		});
				    	}
				    }
				});
			}
		});
	  
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
			$("#seachForm").attr("action","${ctx}/api/v1/lov");
			$("#seachForm").submit();
		}
    </script>
</body>
</html>


