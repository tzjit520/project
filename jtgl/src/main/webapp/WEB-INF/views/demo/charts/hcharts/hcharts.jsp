<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>图表</title>
<%@ include file="/templates/include.jsp"%>
<script src="${ctx}/static/plugin/Highcharts-6.0.2/highcharts.js" type="text/javascript"></script>
<script src="${ctx}/static/plugin/Highcharts-6.0.2/xrange.js" type="text/javascript"></script>

</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">Highcharts图表</h1><hr/>
			</div>

			<div class="panel-body">
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-success toggle">
							<div class="panel-heading">
								<h4 class="panel-title">
									<i class="im-bars"></i>
									CPU使用情况
								</h4>
							</div>
							<div class="panel-body">
								<div id="hcharts1" style="width: 100%; height: 250px;"></div>
							</div>
							<script src="${ctx}/static/system/charts/highcharts/automatic.js" type="text/javascript"></script>
						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-success toggle">
							<div class="panel-heading">
								<h4 class="panel-title">
									<i class="im-bars"></i>
									工作时间安排
								</h4>
							</div>
							<div class="panel-body">
								<div id="hcharts2" style="width: 100%; height: 250px;"></div>
							</div>
							<script src="${ctx}/static/system/charts/highcharts/xrange.js" type="text/javascript"></script>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-xs-6">
						<div class="panel panel-primary plain toggle">
							<div class="panel-heading white-bg">
								<h4 class="panel-title">
									<i class="im-bars"></i>
									时间轴柱状图
								</h4>
							</div>
							<div class="panel-body white-bg">
								<div id="hcharts3" style="width: 100%; height: 250px;"></div>
							</div>

						</div>
					</div>
					<div class="col-xs-6">
						<div class="panel panel-default toggle">
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
	<script src="${ctx}/static/system/charts/highcharts/column_xtime.js" type="text/javascript"></script>
	<script type="text/javascript">
		$(function() {

		})
	</script>
</body>
</html>
