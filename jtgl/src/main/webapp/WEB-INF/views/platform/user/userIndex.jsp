<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>用户管理</title>
<%@ include file="/templates/include.jsp"%>
<script type="text/javascript" src="${ctx}/static/plugin/bootstrap/js/bootstrap-treeview.js"></script>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="panel-body">
				<!-- <div id="left" style="float: left; width: 13%">
					<div>
						<span onclick="allFolder()">
							<i class="st-support" style="margin-top: -3px"></i>
							&nbsp;组织机构
						</span>
						<a href="javascript:initTree()">
							<i class="fa-refresh" style="margin-left: 70px"></i>
						</a>
					</div>
					<div id="unitTree" style="margin-top: 10px;"></div>
				</div> -->
				<div id="right" style="float: left; width: 100%;">
					<iframe id="userContent" name="userContent" src="${ctx}/api/v1/user" width="100%" onload="javascript:this.height=this.contentWindow.document.body.scrollHeight+140" frameborder="0"></iframe>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>

	<script type="text/javascript">
		//treeview 属性
		var treeOptions = {
			color: "#428bca",
	        expandIcon: 'glyphicon glyphicon-plus-sign',
	        collapseIcon: 'glyphicon glyphicon-minus-sign',
	        nodeIcon: 'glyphicon glyphicon-heart',
	        data: []	
		};
	
	  	function initTree(){
	  		//初始化tree数据
	    	$.ajax({
				type: 'get',
				url: '${ctx}/api/v1/unit/treeData',
				data: {},
				success:function(result){
					if(result.code == 0){
						treeOptions.data = result.data;
						$('#unitTree').treeview(treeOptions);
				    	//节点被选择
				    	$('#unitTree').on('nodeSelected',function(event, data) {
				    		if(data.type == 'parent'){
					    		$('#userContent').attr("src","${ctx}/api/v1/user?unitId="+data.id);
				    		}else{
					    		$('#userContent').attr("src","${ctx}/api/v1/user?deptId="+data.id);
				    		}
			    		});
				    	//选择指定的节点，接收节点或节点ID  checkNode(node | nodeId, options)
				    	//$('#unitTree').treeview('checkNode', [5, { silent: true } ]);
					}
				},
				error: function(data){}
			});
	  	}
	  	
		$(function(){
			initTree();
		})
	</script>
</body>
</html>