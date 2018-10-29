<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java"  pageEncoding="UTF-8"%>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>AngularJs示例</title>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/jquery/bootstrap/css/bootstrap.css">
	<style type="text/css">
		body{
			background:#F0F0F0
		}
	</style>
	<%
		String path = request.getContextPath();
	%>
</head>
<body>
	<div class="container">
		<div class="row">
			<h2><small>AngularJs列表</small></h2>
			<div class="col-md-3">
				<h3 class="page-header">
					<small><a href="<%=path%>/family/angularJs/angularJs_1/testAngularJs.jsp" target="_blank">
					AngularJs列表一</a></small>
				</h3>
			</div>
			<div class="col-md-3">
				<h3 class="page-header">
					<small><a href="<%=path%>/family/angularJs/angularJs_2/testAngularJs.jsp" target="_blank">
					AngularJs列表二</a></small>
				</h3>
			</div>
		</div>
		
	</div>
</body>
</html>