<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>图表</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">Echarts图表</h1><hr/>
			</div>

			<div class="panel-body">
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-primary plain toggle">
							<div class="panel-heading">
								<h4 class="panel-title">
									<i class="im-bars"></i>
									Line chart with dots
								</h4>
							</div>
							<div class="panel-body blue-bg">
								<div id="line-chart-dots" style="width: 100%; height: 250px;"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-default plain toggle">
							<!-- Start .panel -->
							<div class="panel-heading white-bg">
								<h4 class="panel-title">
									<i class="im-bars"></i>
									Line chart only
								</h4>
							</div>
							<div class="panel-body white-bg">
								<div id="line-chart" style="width: 100%; height: 250px;"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-primary plain toggle">
							<!-- Start .panel -->
							<div class="panel-heading white-bg">
								<h4 class="panel-title">
									<i class="im-bars"></i>
									Line chart filled
								</h4>
							</div>
							<div class="panel-body white-bg">
								<div id="line-chart-filled" style="width: 100%; height: 250px;"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-default toggle">
							<!-- Start .panel -->
							<div class="panel-heading">
								<h4 class="panel-title">
									<i class="im-bars"></i>
									Line charts style 2
								</h4>
							</div>
							<div class="panel-body">
								<div id="line-chart-dots2" style="width: 100%; height: 250px;"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-success toggle">
							<!-- Start .panel -->
							<div class="panel-heading">
								<h4 class="panel-title">
									<i class="im-bars"></i>
									Stacked Bars chart
								</h4>
							</div>
							<div class="panel-body">
								<div id="bars-chart" style="width: 100%; height: 250px;"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-default toggle">
							<!-- Start .panel -->
							<div class="panel-heading">
								<h4 class="panel-title">
									<i class="im-bars"></i>
									Ordered Bars chart
								</h4>
							</div>
							<div class="panel-body">
								<div id="ordered-bars-chart" style="width: 100%; height: 250px;"></div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-default toggle">
							<!-- Start .panel -->
							<div class="panel-heading">
								<h4 class="panel-title">
									<i class="im-pie"></i>
									Pie chart
								</h4>
							</div>
							<div class="panel-body">
								<div id="pie-chart" style="width: 100%; height: 250px;"></div>
							</div>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-default toggle">
							<!-- Start .panel -->
							<div class="panel-heading">
								<h4 class="panel-title">
									<i class="im-pie"></i>
									Donut chart
								</h4>
							</div>
							<div class="panel-body">
								<div id="donut-chart" style="width: 100%; height: 250px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>

	<script type="text/javascript">
		$(function() {

		})
	</script>
</body>
</html>
