<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>zTree</title>
<%@ include file="/templates/include.jsp"%>
<link rel="stylesheet" href="${ctx}/static/plugin/zTree/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="${ctx}/static/plugin/zTree/zTree_v3/js/jquery.ztree.core.js"></script>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">zTree树形列表</h1><hr/>
			</div>
			<div class="panel-body">
				<form class="form-horizontal group-border hover-stripped">
					<div class="form-group">
						<div class="col-xs-3">
							<div class="zTreeDemoBackground left">
								<ul id="treeDemo1" class="ztree"></ul>
							</div>
						</div>
						<div class="col-xs-3">
							<div class="zTreeDemoBackground left">
								<ul id="treeDemo2" class="ztree"></ul>
							</div>
						</div>
						<div class="col-xs-3">
							<div class="zTreeDemoBackground left">
								<ul id="treeDemo3" class="ztree"></ul>
							</div>
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
    	var setting1 = {
			data: {
				simpleData: {
					enable: true
				}
			}
		};

		var zNodes1 =[
			{ id:1, pId:0, name:"展开、折叠 自定义图标不同", open:true, iconOpen:"${ctx}/static/plugin/zTree/zTree_v3/css/zTreeStyle/img/diy/1_open.png", iconClose:"${ctx}/static/plugin/zTree/zTree_v3/css/zTreeStyle/img/diy/1_close.png"},
			{ id:11, pId:1, name:"叶子节点1", icon:"${ctx}/static/plugin/zTree/zTree_v3/css/zTreeStyle/img/diy/2.png"},
			{ id:12, pId:1, name:"叶子节点2", icon:"${ctx}/static/plugin/zTree/zTree_v3/css/zTreeStyle/img/diy/3.png"},
			{ id:13, pId:1, name:"叶子节点3", icon:"${ctx}/static/plugin/zTree/zTree_v3/css/zTreeStyle/img/diy/5.png"},
			{ id:2, pId:0, name:"展开、折叠 自定义图标相同", open:true, icon:"${ctx}/static/plugin/zTree/zTree_v3/css/zTreeStyle/img/diy/4.png"},
			{ id:21, pId:2, name:"叶子节点1", icon:"${ctx}/static/plugin/zTree/zTree_v3/css/zTreeStyle/img/diy/6.png"},
			{ id:22, pId:2, name:"叶子节点2", icon:"${ctx}/static/plugin/zTree/zTree_v3/css/zTreeStyle/img/diy/7.png"},
			{ id:23, pId:2, name:"叶子节点3", icon:"${ctx}/static/plugin/zTree/zTree_v3/css/zTreeStyle/img/diy/8.png"},
			{ id:3, pId:0, name:"不使用自定义图标", open:true },
			{ id:31, pId:3, name:"叶子节点1"},
			{ id:32, pId:3, name:"叶子节点2"},
			{ id:33, pId:3, name:"叶子节点3"}

		];

		//-----------------------------------------------------------------
		
		var setting2 = {
			view: {
				showLine: false
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};

		var zNodes2 =[
			{ id:1, pId:0, name:"父节点1 - 展开", open:true},
			{ id:11, pId:1, name:"父节点11 - 折叠"},
			{ id:111, pId:11, name:"叶子节点111"},
			{ id:112, pId:11, name:"叶子节点112"},
			{ id:113, pId:11, name:"叶子节点113"},
			{ id:114, pId:11, name:"叶子节点114"},
			{ id:12, pId:1, name:"父节点12 - 折叠"},
			{ id:121, pId:12, name:"叶子节点121"},
			{ id:122, pId:12, name:"叶子节点122"},
			{ id:123, pId:12, name:"叶子节点123"},
			{ id:124, pId:12, name:"叶子节点124"},
			{ id:13, pId:1, name:"父节点13 - 没有子节点", isParent:true},
			{ id:2, pId:0, name:"父节点2 - 折叠"},
			{ id:21, pId:2, name:"父节点21 - 展开", open:true},
			{ id:211, pId:21, name:"叶子节点211"},
			{ id:212, pId:21, name:"叶子节点212"},
			{ id:213, pId:21, name:"叶子节点213"},
			{ id:214, pId:21, name:"叶子节点214"},
			{ id:22, pId:2, name:"父节点22 - 折叠"},
			{ id:221, pId:22, name:"叶子节点221"},
			{ id:222, pId:22, name:"叶子节点222"},
			{ id:223, pId:22, name:"叶子节点223"},
			{ id:224, pId:22, name:"叶子节点224"},
			{ id:23, pId:2, name:"父节点23 - 折叠"},
			{ id:231, pId:23, name:"叶子节点231"},
			{ id:232, pId:23, name:"叶子节点232"},
			{ id:233, pId:23, name:"叶子节点233"},
			{ id:234, pId:23, name:"叶子节点234"},
			{ id:3, pId:0, name:"父节点3 - 没有子节点", isParent:true}
		];
		
		//-----------------------------------------------------------------
		
		var setting3 = {
			view: {
				showIcon: showIconForTree
			},
			data: {
				simpleData: {
					enable: true
				}
			}
		};

		function showIconForTree(treeId, treeNode) {
			return !treeNode.isParent;
		};
			
		$(document).ready(function(){
			$.fn.zTree.init($("#treeDemo1"), setting1, zNodes1);
			$.fn.zTree.init($("#treeDemo2"), setting2, zNodes2);
			$.fn.zTree.init($("#treeDemo3"), setting3, zNodes2);
		});
			
    </script>
</body>
</html>
