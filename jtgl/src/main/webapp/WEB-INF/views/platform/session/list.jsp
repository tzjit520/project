<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>会话管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">会话列表</h1><hr/>
			</div>
			<div class="panel-body">
              	<form class="form-horizontal group-border hover-stripped" method="get" role="form" id="form" style="margin-bottom:20px;">
					<div class="form-group">
						<div class="col-xs-12">
							<shiro:hasPermission name="session:delete">
								<input type="button" id="btnDel" class="btn btn-danger" value="踢出用户">
							</shiro:hasPermission>
						</div>
					</div>
				</form>
				<table class="table table-bordered">
					<thead>
						<tr>
							<th style="width: 5px">
								<input type="checkbox" id="parentCheckbox">
							</th>
							<th>用户名</th>
							<th>登录IP</th>
							<th>会话ID</th>
							<th>会话开始时间</th>
							<th>最后访问时间</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${resultList}" var="map">
							<tr>
								<td>
									<input type="checkbox" value="${map.sessionID}" name="child_items">
								</td>
								<td>${map.loginName}</td>
								<td>${map.loginIP}</td>
								<td>${map.sessionID}</td>
								<td>
									<fmt:formatDate value="${map.sessionStartTime}" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								<td>
									<fmt:formatDate value="${map.sessionLastAccessTime}" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
	  	//删除数据
	    $('#btnDel').click(function() {
	    	var node_count = $("[name=child_items]:checked").length;
			if(node_count <= 0){
				$alert("请最少选择一个用户!",'提示');
				return ;
			}else{
				bootbox.confirm({
					title: "删除提示",
					message: "确定踢出选中的用户?",
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
							var url = '${ctx}/api/v1/session';
							$.ajax({
				    			type: 'post',
				    			url: url,
				    			data: {
				    				_method : "delete",
				    				ids: ids
			    				},
				    			success:function(data){
				    				if(data.code == 0){
				    					$.jBox.tip("踢出成功", '提示');
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
			$("#seachForm").attr("action","${ctx}/api/v1/role");
			$("#seachForm").submit();
		}
    </script>
</body>
</html>


