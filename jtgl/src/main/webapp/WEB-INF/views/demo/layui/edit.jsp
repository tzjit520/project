<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>LayUI</title>
<link rel="stylesheet" href="${ctx}/static/plugin/layui/css/layui.css" />
</head>

<body>
	<div class="layui-fluid">
		<fieldset class="layui-elem-field layui-field-title">
			<legend>富文本</legend>
		</fieldset>
		<div style="width: 800px;">
			<form class="layui-form">
				<div class="layui-form-item">
					<textarea name="demo" id="demo" class="layui-hide"></textarea>
				</div>
				<button class="layui-btn">提交</button>
				<a class="layui-btn" id="getChoose">获取选中内容</a>
			</form>
		</div>

		<script src="${ctx}/static/plugin/layui/layui.js"></script>

		<script type="text/javascript">
			layui.use('layedit', function() {
				var layedit = layui.layedit;

				var index = layedit.build('demo', {
					//hideTool: ['image']
					uploadImage : {
						url : 'json/upload/demoLayEdit.json',
						type : 'get'
					}
				//,tool: []
				//,height: 100
				});

				getChoose.onclick = function() {
					alert(layedit.getSelection(index));
				};

			});
		</script>
	</div>
</body>
</html>
