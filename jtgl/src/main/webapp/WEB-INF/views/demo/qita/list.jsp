<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>其它样例</title>
<%@ include file="/templates/include.jsp"%>
<!-- 滚动消息通知需要  -->
<link href="${ctx}/static/system/message/message.css" rel="stylesheet" />
<script type="text/javascript" src="${ctx}/static/system/message/jquery.mintTabify.js"></script>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">样例</h1><hr/>
			</div>
			<div class="panel-body">
				<form class="form-horizontal group-border hover-stripped">
					<div class="form-group">
						<label for="name" class="col-xs-1 control-label"></label>
						<div class="col-xs-11">
							<!-- 滚动消息通知 -->
							<div id="topbar">
								<div class="rolling-notice">
									<strong class="notice-title">通知：</strong>
									<ul class="notice-list" id="announce"></ul>
								</div>
							</div>
							<!-- 消息 -->
							<script type="text/javascript" src="${ctx}/static/system/message/message.js"></script>
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">省份:</label>
						<div class="col-xs-1">
							<select id="province" name="province" onchange="doProvAndCityRelation();" class="form-control select2">
								<option id="choosePro" value="-1">请选择</option>
							</select>
						</div>
						<label for="nickName" class="col-xs-1 control-label">城市:</label>
						<div class="col-xs-1">
							<select id="city" name="city" onchange="doCityAndCountyRelation();" class="form-control select2">
								<option id='chooseCity' value='-1'>请选择</option>
							</select>
						</div>
						<label for="nickName" class="col-xs-1 control-label">区域:</label>
						<div class="col-xs-1">
							<select id="county" name="county" class="form-control select2">
								<option id='chooseCounty' value='-1'>请选择</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">字典数据:</label>
						<label for="name" class="col-xs-1 control-label" style="text-align:left">${fns:getLineValue('1','statuses')}</label>
						<label for="nickName" class="col-xs-1 control-label">状态:</label>
						<div class="col-xs-1">
							<select class="form-control select2">
								<c:forEach items="${fns:getLineList('statuses')}" var="item">
									<option value="${item.code}">${item.name}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript" src="${ctx}/static/system/district/district.js"></script>
	<script type="text/javascript">
		$(function() {
			//页面加载完初始化省下拉框
	    	initProvince();
	    	
		})
	</script>
</body>
</html>
