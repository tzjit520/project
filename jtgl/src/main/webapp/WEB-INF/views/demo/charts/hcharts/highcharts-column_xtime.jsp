<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<%@ include file="/templates/include.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/data.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<title>柱状图</title>
</head>
<body>
	<div id="container"></div>
	<input type="hidden" value="<%=request.getContextPath()%>" id="path">	
</body>
<script type="text/javascript">
	
</script>
</html>