<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>定时任务</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">定时任务</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="scheduleJob" class="form-horizontal group-border hover-stripped" method="get" role="form" id="seachForm" cssStyle="padding-bottom:20px;">
					<form:hidden path="pageIndex" id="pageIndex" />
					<form:hidden path="pageSize" id="pageSize" />
					<div class="form-group">
						<label for="jobName" class="col-xs-1 control-label">名称：</label>
						<div class="col-xs-2">
							<form:input path="jobName" id="jobName" cssClass="form-control" />
						</div>
						<div class="col-xs-8">
							<input type="button" class="btn btn-primary" onclick="page()" value="查询">
							<shiro:hasAnyPermissions name="schedule:add,schedule:update">
								<input type="button" id="btnAdd" class="btn btn-success" onclick="window.location.href='${ctx}/api/v1/task/0'" value="添加">
								<input type="button" id="btnUpdate" class="btn btn-purple" value="修改">
								<input type="button" id="btnZT" class="btn btn-brown" value="暂停">
								<input type="button" id="btnHF" class="btn btn-lime" value="恢复">
								<input type="button" id="btnZXYC" class="btn btn-magenta" value="执行一次">
							</shiro:hasAnyPermissions>
							<shiro:hasPermission name="schedule:delete">
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
							<!-- <th>bean名称</th> -->
							<th>目标类</th>
							<th>目标方法</th>
							<th>cron表达式</th>
							<th>是否允许并发</th>
							<th>任务描述</th>
							<th>状态</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.data}" var="scheduleJob">
							<tr>
								<td>
									<input type="checkbox" value="${scheduleJob.id}" name="child_items">
								</td>
								<td>${scheduleJob.jobName}</td>
								<%-- <td>${scheduleJob.beanName}</td> --%>
								<td>${scheduleJob.className}</td>
								<td>${scheduleJob.methodName}</td>
								<td>${scheduleJob.cronExpression}</td>
								<td>${scheduleJob.concurrent==1?'是':'否'}</td>
								<td>${scheduleJob.remark}</td>
								<td class="${scheduleJob.status==1?'success':'danger'}">${scheduleJob.status==1?'正在运行':'已停止'}</td>
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
				window.location.href = "${ctx}/api/v1/task/"+id;
			}
		});
    
	  	//暂停 
	    $('#btnZT,#btnHF,#btnZXYC').click(function() {
	    	var node_count = $("[name=child_items]:checked").length;
			if(node_count <= 0){
				$alert("请选择一行!",'提示');
				return ;
			}else if(node_count > 1){
				$alert("不能选择多行!",'提示');
				return ;
			}else{
				var url = '${ctx}/api/v1/task';
				var czUrl = '';
				if(this.id == 'btnZT'){
					czUrl = url+'/stopSchedule';
				}else if(this.id == 'btnHF'){
					czUrl = url+'/startSchedule';
				}else if(this.id == 'btnZXYC'){
					czUrl = url+'/runOnce';
				}
				var id = $("[name=child_items]:checked")[0].value;
				$.ajax({
	    			type: 'get',
	    			url: czUrl,
	    			data: {
	    				id: id
    				},
	    			success:function(data){
	    				if(data.code == 0){
	    					$.jBox.tip("操作成功", '提示');
	    					setTimeout(function(){
		    					window.location.href = url;
	    					}, 1000);
	    				}else{
	    					$alert(data.message,'错误提示');
	    				}
	    			}
	    		});
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
							var url = '${ctx}/api/v1/task';
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
			$("#seachForm").attr("action","${ctx}/api/v1/task");
			$("#seachForm").submit();
		}
    </script>
</body>
</html>


