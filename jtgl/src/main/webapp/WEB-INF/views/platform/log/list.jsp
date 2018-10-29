<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>日志管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">日志管理</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="log" class="form-horizontal group-border hover-stripped" method="get" log="form" id="seachForm" cssStyle="padding-bottom:20px;">
					<form:hidden path="pageIndex" id="pageIndex" />
					<form:hidden path="pageSize" id="pageSize" />
					<div class="form-group">
						<label for="level" class="col-xs-1 control-label">日志级别：</label>
						<div class="col-xs-2">
							<form:input path="level" id="level" cssClass="form-control" />
						</div>
						<label for="remoteIp" class="col-xs-1 control-label">访问地址：</label>
						<div class="col-xs-2">
							<form:input path="remoteIp" id="remoteIp" cssClass="form-control" />
						</div>
						<div class="col-xs-5">
							<input type="button" class="btn btn-primary" onclick="page()" value="查询">
							<shiro:hasPermission name="log:delete">
								<input type="button" id="btnDel" class="btn btn-danger" value="删除">
							</shiro:hasPermission>
						</div>
					</div>
				</form:form>
				<table class="table table-bordered table-hover table-striped" style="word-break:break-all; word-wrap:break-all;">
					<thead>
						<tr>
							<th style="width: 5px">
								<input type="checkbox" id="parentCheckbox">
							</th>
							<th style="width:80px">日志类型</th>
							<th style="width:80px">日志等级</th>
							<th style="width:80px">操作人</th>
							<th style="width:150px">操作时间</th>
							<th style="width:120px">访问地址</th>
							<th	style="width:120px">请求URI</th>
							<th style="width:80px">操作方式</th>
							<th style="width:150px">调用模块/方法</th>
							<th style="width:120px">请求花费时间</th>
							<!-- <th>请求数据</th>
								<th>响应数据</th>
								<th>异常信息</th> -->
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.data}" var="log">
							<tr>
								<td>
									<input type="checkbox" value="${log.id}" name="child_items">
								</td>
								<td>${log.type}</td>
								<td>${log.level}</td>
								<td>${fns:getUserById(log.createBy).name}</td>
								<td>
									<fmt:formatDate value="${log.createDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								<td>${log.remoteIp}</td>
								<td>${log.requestUri}</td>
								<td>${log.method}</td>
								<td>${log.module}</td>
								<td>${log.requestTime}ms</td>
								<%-- <td>${log.requestData}</td>
									<td>${log.responseData}</td>
									<td>${log.exception}</td> --%>
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
							var url = '${ctx}/api/v1/log';
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
			$("#seachForm").attr("action","${ctx}/api/v1/log");
			$("#seachForm").submit();
		}
    </script>
</body>
</html>


