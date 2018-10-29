<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>菜单管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">菜单管理</h1><hr/>
			</div>
			<div class="panel-body">
				<table id="treeTable" class="table table-bordered">
					<thead>
						<tr>
							<th>名称</th>
							<th>编码</th>
							<th>父级名称</th>
							<th>链接</th>
							<th>链接类型</th>
							<th>权限</th>
							<th>排序</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="menu">
							<tr id="${menu.id}" pId="${menu.parentId}">
								<td controller="true">
									<i class="${menu.css}" style="font-size: 18px"></i>
									&nbsp;${menu.name}
								</td>
								<td>${menu.code}</td>
								<td>${menu.parentName}</td>
								<td title="${menu.url}">${menu.url}</td>
								<td>${fns:getLineValue(menu.type,'menuTypes')}</td>
								<td>${menu.permission}</td>
								<td>${menu.sort}</td>
								<td>
									<shiro:hasPermission name="menu:add">
										<button class="btn btn-success" onclick="window.location.href='${ctx}/api/v1/menu/0?parentId=${menu.id}'">添加下级菜单</button>
									</shiro:hasPermission>
									<shiro:hasPermission name="menu:update">
										<button class="btn btn-purple" onclick="window.location.href='${ctx}/api/v1/menu/${menu.id}'">修改</button>
									</shiro:hasPermission>
									<shiro:hasPermission name="menu:delete">
										<button class="btn btn-danger" onclick="javascript:deleteMenu(${menu.id})">删除</button>
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
			
	    	//treeTable
            var option = {
                expandLevel : 2,
                beforeExpand : function($treeTable, id) {},
                onSelect : function($treeTable, id) {}
            };
            $('#treeTable').treeTable(option);
	    	
		    $("#parentCheckbox").click(function(){
		    	$("[name=child_items]").prop("checked",this.checked);
		    })
			$("[name=child_items]").click(function(){
		    	$("#parentCheckbox").prop("checked",$("[name=child_items]").length == $("[name=child_items]:checked").length);
		    });
		
		})
		
	  	//删除数据
	    var deleteMenu = function(id) {
			bootbox.confirm({
				title: "删除提示",
				message: "确定删除该菜单?",
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
						var url = '${ctx}/api/v1/menu';
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


