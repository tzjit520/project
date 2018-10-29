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
				<h1 class="page-header">机构管理</h1><hr/>
			</div>
			<div class="panel-body">
				<table id="treeTable" class="table table-bordered">
					<thead>
						<tr>
							<th>名称</th>
							<th>编码</th>
							<th>类型</th>
							<th>排序</th>
							<th>描述</th>
							<th style="width:350px">操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="unit">
							<tr id="${unit.id}" pId="${unit.parentId}">
								<td controller="true">${unit.name}</td>
								<td>${unit.code}</td>
								<td>${fns:getLineValue(unit.type,'unitTypes')}</td>
								<td>${unit.sort}</td>
								<td>${unit.remark}</td>
								<td>
									<shiro:hasPermission name="unit:add">
										<button class="btn btn-success" onclick="window.location.href='${ctx}/api/v1/unit/0?parentId=${unit.id}'">添加下级机构</button>
									</shiro:hasPermission>
									<shiro:hasPermission name="unit:update">
										<button class="btn btn-purple" onclick="window.location.href='${ctx}/api/v1/unit/${unit.id}'">修改</button>
									</shiro:hasPermission>
									<shiro:hasPermission name="unit:delete">
										<button class="btn btn-danger" onclick="javascript:deleteUnit(${unit.id})">删除</button>
									</shiro:hasPermission>
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
	    $(function(){
            var option = {
                expandLevel : 2,
                beforeExpand : function($treeTable, id) {},
                onSelect : function($treeTable, id) {}
            };
            $('#treeTable').treeTable(option);
		})

		//删除数据
	    var deleteUnit = function(id) {
			bootbox.confirm({
				title: "删除提示", 
				message: "确定删除该机构?",
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
						var url = '${ctx}/api/v1/unit';
						$.ajax({
			    			type: 'post',
			    			url: url+"/"+id,
			    			data: {
			    				_method : "delete"
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
		};
		
    </script>

</body>
</html>


