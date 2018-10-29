<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head >
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>全网概况</title>
	<%@ include file="/templates/include.jsp"%>
	<script src="${ctx}/static/plugin/Highcharts-6.0.2/highcharts.js"></script>
	<style type="text/css">
		#container{
			width:100%;margin:0 auto;
		}
		.gsqc{
			height:500px;
			width:49%;
			float:left;
		}
		.container-main{
			height:250px;
			width:25%;
			float:left;
		}
		.container-pre{
			height:250px;
			width:24%;
			float:left;
		}
	</style>
</head>
<body style="background:#E8E8E8">
	<div id="container">
		<input type="hidden" value="<%=request.getContextPath()%>" id="path">	
		<input type="hidden" id="startTime" value="2017-01-24">
		<input type="hidden" id="endTime" value="2017-01-25">
		<input type="hidden" id="sYear" value="2016">
		<input type="hidden" id="eYear" value="2017">
		<input type="hidden" id="crew_1" value="1022077824682">
		<input type="hidden" id="crew_2" value="1022042824137">
		<input type="hidden" id="crew_3" value="1021820091148">
		<input type="hidden" id="crew_4" value="1021134803014">
		<input type="hidden" id="crew_5" value="1021164921271">
		<input type="hidden" id="crew_6" value="1021428469450">
		<input type="hidden" id="qcfd" value="1011563025314">
		
		<div id="gsqc" class="gsqc"></div>
		<div id="gs1" class="container-main"></div>
		<div id="gs2" class="container-main"></div>
		<div id="gs3" class="container-main"></div>
		<div id="gs4" class="container-main"></div>
		<div id="gs7" class="container-pre"></div>
		<div id="gs8" class="container-main"></div>
		<div id="gs5" class="container-main"></div>
		<div id="gs6" class="container-main"></div>
	</div>
</body>

<script type="text/javascript">
	//back_color图表背景颜色,title_color图表标题字体颜色
	var back_color = "#E8E8E8", title_color = "#4876FF";
	//全厂发电  和  1-6号机组  chart对象
	var gsqcChartObject, gs1ChartObject, gs2ChartObject, gs3ChartObject, gs4ChartObject, 
		gs5ChartObject, gs6ChartObject;
	//图表 tooltip属性
	var tp_qc = '',tp_gs1 = '',tp_gs2 = '',tp_gs3 = '',tp_gs4 = '',tp_gs5 = '',tp_gs6 = '';
	//图表的ID对象
	var gsqc = 'gsqc', gs1 = 'gs1', gs2 = 'gs2', gs3 = 'gs3', gs4 = 'gs4', 
		gs5 = 'gs5', gs6 = 'gs6', gs7 = 'gs7', gs8 = 'gs8';
	var gsqc_text = "全厂发电有功", crew1_text = "1号机发电有功", crew2_text = "2号机发电有功", crew3_text = "3号机发电有功", 
		crew4_text = "4号机发电有功", crew5_text = "5号机发电有功", crew6_text = "6号机发电有功";
	//全厂发电  和  1-6号机组 mrid
	var gsqc_mrid = $("#qcfd").val(), crew_mrid1 = $("#crew_1").val(), crew_mrid2 = $("#crew_2").val(), 
		crew_mrid3 = $("#crew_3").val(), crew_mrid4 = $("#crew_4").val(), crew_mrid5 = $("#crew_5").val(), 
		crew_mrid6 = $("#crew_6").val();
	//全厂发电有功和1-6号机组发电有功  的  开始时间   和  结束时间
	var startTime = $("#startTime").val(), endTime = $("#endTime").val();
	//电厂月电量   今年  和  去年  的年份值
	var sYear = $("#sYear").val(), eYear = $("#eYear").val();
	//项目的根路径
	var path = $("#path").val();
	//Highcharts全局配置
	Highcharts.setOptions({
		colors: ['#8085e9','#f15c80','#7cb5ec','#434348','#90ed7d','#2b908f','#f45b5b','#91e8e1'],
		lang: {
			shortMonths: ["1月", "2月", "3月" , "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月"]
		},
		global:{
			useUTC:false
		}
	});
	var q = 0;
	$(function(){
		$("#"+gsqc).height($(window).height()*2/3-30);
		$(".container-main").height($(window).height()/3-10);
		$(".container-main_").height($(window).height()/3-10);
		//加载ajax数据
		queryData();
		
		//每隔3秒查询全厂数据
		setInterval(function(){
			/*//查询全厂发电有功   最新数据
			gsqcIntervalData(gsqcChartObject);
			//查询1号机发电有功  最新数据
			crewIntervalData(gs1ChartObject);
			//查询2号机发电有功  最新数据
			crewIntervalData(gs2ChartObject);
			//查询3号机发电有功  最新数据
			crewIntervalData(gs3ChartObject);
			//查询4号机发电有功  最新数据
			crewIntervalData(gs4ChartObject);
			//查询5号机发电有功  最新数据
			crewIntervalData(gs5ChartObject);
			//查询6号机发电有功  最新数据
			crewIntervalData(gs6ChartObject);
			if(q!=0 && q%4 == 0){
				//查询饼图数据
				query_pie_data();
			}
			q++;*/
			if(formatNewDate()){
				location.reload();
			}
		},30000000);
	});
	
	function formatNewDate(){
		var d = new Date();
		var hours = d.getHours() < 10 ? "0" + d.getHours() : d.getHours();
		var minutes = d.getMinutes() < 10 ? "0" + d.getMinutes() : d.getMinutes();
		var seconds = d.getSeconds() < 10 ? "0" + d.getSeconds() : d.getSeconds();
		if(hours == "00" && minutes == "00" && seconds < 59){
			return true;
		}
		return false;
	}
	
	//查询数据
	function queryData(){
		
		//查询   【1号机发电有功】	
		$.ajax({
			type: 'get',
			url: path + "/static/system/charts/highcharts/json/crew1_json",
			data: {},
			success: function(data){
				var d = eval("(" + data + ")");
				create_graph_data(gs1, crew1_text, d);
			}
		});	
		
		//查询   【2号机发电有功】
		$.ajax({
			type: 'get',
			url: path + "/static/system/charts/highcharts/json/crew2_json",
			data: {},
			success: function(data){
				var d = eval("(" + data + ")");
				create_graph_data(gs2, crew2_text, d);
			}
		});	

		//查询   【3号机发电有功】
		$.ajax({
			type: 'get',
			url: path + "/static/system/charts/highcharts/json/crew3_json",
			data: {},
			success: function(data){
				var d = eval("(" + data + ")");
				create_graph_data(gs3, crew3_text, d);
			}
		});	

		//查询   【4号机发电有功】
		$.ajax({
			type: 'get',
			url: path + "/static/system/charts/highcharts/json/crew4_json",
			data: {},
			success: function(data){
				var d = eval("(" + data + ")");
				create_graph_data(gs4, crew4_text, d);
			}
		});	
		
		//查询   【5号机发电有功】
		$.ajax({
			type: 'get',
			url: path + "/static/system/charts/highcharts/json/crew5_json",
			data: {},
			success:function(data){
				var d = eval("(" + data + ")");
				create_graph_data(gs5, crew5_text, d);
			}
		});	
		
		//查询   【6号机发电有功】
		$.ajax({
			type: 'get',
			url: path + "/static/system/charts/highcharts/json/crew6_json",
			data: {},
			success: function(data){
				var d = eval("(" + data + ")");
				create_graph_data(gs6, crew6_text, d);
			}
		});
		
		//查询   【电厂月最大有功出力】  柱状图和折线混合图	
		query_cs_data();
		
		//查询饼图数据
		query_pie_data();
		
		//查询   【全厂发电有功】
		$.ajax({
			type: 'get',
			url: path + "/static/system/charts/highcharts/json/qcfd_json",
			data: {},
			//async:false, 是否同步加载
			success: function(data){
				var d = eval("(" + data + ")");
				create_graph_data(gsqc, gsqc_text, d);
			}
		});
	}
	
	//创建   折线图     图形数据
	function create_graph_data(container, titleName, data){
		var seriesData1Array = [];//前一天数据
		var seriesData2Array = [];//当天数据
		if(data && data.rows1){
			//前一天数据
			for(var t = 0 ; t < data.rows1.length ; t++){
				if(data.rows1[t] == null || data.rows1[t] == undefined || data.rows1[t] == "")
					continue;
				//拿到时间段
				var time = data.rows1[t].tId;
				var pData = data.rows1[t].mw;
				var seriesData1 = {};
				
				seriesData1.x = parseInt(time);
				seriesData1.y = null;
				if(pData != undefined && pData != ""){
					seriesData1.y = pData;
				}
				//拿到前一天数据 
				seriesData1Array.push(seriesData1);
				
				//当天数据
				var seriesData2;
				if(data.rows2 && data.rows2[t] != ""){
					var dr = data.rows2[t];
					if(dr != undefined && dr != ""){
						seriesData2 = {};
						seriesData2.x = parseInt(time);
						seriesData2.y = null;
						var pData_ = dr.mw;
						if(dr.mw){
							if(data.maxGs.tId != "" && parseInt(data.maxGs.tId) == time){
								seriesData2.y = pData_;
								/* seriesData2.marker = {
									enabled:true,
									lineWidth: 2,
									symbol:'circle',//symbol可取值 triangle-down square  diamond circle
						            lineColor: Highcharts.getOptions().colors[1],
						            fillColor: 'white'
								}; */
							}else{
								seriesData2.y = pData_;
							}
						}
						//当天数据
						seriesData2Array.push(seriesData2);
					}
				}
			}
		}
		//图形数据1
		var series1 = {};	
		series1.name = startTime + " 发电有功";
		series1.data = seriesData1Array;	
		//图形数据2
		var series2 = {};	
		series2.name = endTime + " 发电有功";
		series2.data = seriesData2Array;
		//series数据
		var seriesArray = new Array();
		seriesArray.push(series1); 				
		seriesArray.push(series2);
		// 当天最新时间
		var footHtml = '<span style="font-size:13px;color:#698B22">最新 ' + endTime + " " + Highcharts.dateFormat('%H:%M',data.maxGs.tId) + '：' + data.maxGs.mw + ' (MW)</span>';
		var noDataHtml = '<span style="font-size:13px;color:#698B22"> ' + endTime + ' 无数据</span>';
		if(container == gsqc){
			if(data.maxGs && data.maxGs.tId){
				tp_qc = footHtml;
			}else{
				tp_qc = noDataHtml;
			}
		}else if(container == gs1){
			if(data.maxGs && data.maxGs.tId){
				tp_gs1 = footHtml;
			}else{
				tp_gs1 = noDataHtml;
			}
		}else if(container == gs2){
			if(data.maxGs && data.maxGs.tId){
				tp_gs2 = footHtml;
			}else{
				tp_gs2 = noDataHtml;
			}
		}else if(container == gs3){
			if(data.maxGs && data.maxGs.tId){
				tp_gs3 = footHtml;
			}else{
				tp_gs3 = noDataHtml;
			}
		}else if(container == gs4){
			if(data.maxGs && data.maxGs.tId){
				tp_gs4 = footHtml;
			}else{
				tp_gs4 = noDataHtml;
			}
		}else if(container == gs5){
			if(data.maxGs && data.maxGs.tId){
				tp_gs5 = footHtml;
			}else{
				tp_gs5 = noDataHtml;
			}
		}else if(container == gs6){
			if(data.maxGs && data.maxGs.tId){
				tp_gs6 = footHtml;
			}else{
				tp_gs6 = noDataHtml;
			}
		}
		//调用折线图
		this.initChartSpline(container, titleName, seriesArray);
	}
	
	//折线图模型
	function initChartSpline(container, titleName, seriesArray){
		var option = {
			chart: {
				renderTo: container,
				type: 'spline',
				backgroundColor:back_color
			},
			title: {//标题
				text: titleName,
	            style:{
	            	color: title_color
	            }
			},
			xAxis: {//xAxis轴
				type: 'datetime',
	        	dateTimeLabelFormats: {
	        		minute:'%H:%M'
	        	}	
			},
			yAxis: {//yAxis轴
				title: {
	                text: '单位: (MW)',
	                style:{
	        			color:Highcharts.getOptions().colors[0]
	        		}
	            },	
	        	labels: {
	        		format:'{value}',
	        		style:{
	        			color:Highcharts.getOptions().colors[0]
	        		}
	        	}
			},
			tooltip: {
	        	shared:true,
	        	useHTML:true,
	        	formatter: function(){
	        		var s = '<small><font style="font-size:15px;color:#FF3030">' + Highcharts.dateFormat('%Y-%m-%d %H:%M',this.x) +'</font></small><br/>';
	        		$.each(this.points,function(){
	        			s += '<font style="font-size:13px;color:'+this.series.color+'">' + this.series.name + '：' + this.y + ' (MW)</font><br/>';
	        		});
	        		if(container == gsqc){
		        		s += tp_qc;
	        		}else if(container == gs1){
	        			s += tp_gs1;
	        		}else if(container == gs2){
	        			s += tp_gs2;
	        		}else if(container == gs3){
	        			s += tp_gs3;
	        		}else if(container == gs4){
	        			s += tp_gs4;
	        		}else if(container == gs5){
	        			s += tp_gs5;
	        		}else if(container == gs6){
	        			s += tp_gs6;
	        		}
	        		return s;
	        	}
        	}, 
			credits: {//版权
	        	enabled:false
	        },
	        legend: {//图例
	            layout: 'horizontal',
	            align: 'center',
	            verticalAlign: 'bottom',
	            itemStyle: {
	            	cursor: 'pointer',
	            	color: '#3e576F'
	            }
	        },
	        series: seriesArray
		};
		
		if(container == gsqc){
			$("#"+container).highcharts(option,function(chart){//回调函数   可得到【全厂发电有功】chart对象
		    	gsqcChartObject = chart;
		    });
		}else if(container == gs1){
			$("#"+container).highcharts(option,function(chart){//回调函数   可得到【机组1号发电有功】chart对象
		    	gs1ChartObject = chart;
		    });
		}else if(container == gs2){
			$("#"+container).highcharts(option,function(chart){//回调函数   可得到【机组2号发电有功】chart对象
		    	gs2ChartObject = chart;
		    });
		}else if(container == gs3){
			$("#"+container).highcharts(option,function(chart){//回调函数   可得到【机组3号发电有功】chart对象
		    	gs3ChartObject = chart;
		    });
		}else if(container == gs4){
			$("#"+container).highcharts(option,function(chart){//回调函数   可得到【机组4号发电有功】chart对象
		    	gs4ChartObject = chart;
		    });
		}else if(container == gs5){
			$("#"+container).highcharts(option,function(chart){//回调函数   可得到【机组5号发电有功】chart对象
		    	gs5ChartObject = chart;
		    });
		}else if(container == gs6){
			$("#"+container).highcharts(option,function(chart){//回调函数   可得到【机组6号发电有功】chart对象
		    	gs6ChartObject = chart;
		    });
		}
	}
	
	//查询全厂最新数据 
	function gsqcIntervalData(chartObj){
		var container = chartObj.renderTo.id;
		//查询   【全厂发电有功】
		$.ajax({
			type: 'get',
			url: path + "/report/generalSituation/"+ gsqc_mrid +"/queryMaxTimeQc",
			data:{
				"startTime": startTime, "endTime": endTime
			},
			//async:false, 是否同步加载
			success: function(data){
				if(data && data.maxGs && data.maxGs.tId){
					var series_dt = chartObj.series[1];
					var x = data.maxGs.tId, y = data.maxGs.mw;
					// 当天最新时间
					var footHtml = '<span style="font-size:13px;color:#698B22">最新 ' + endTime + " " + Highcharts.dateFormat('%H:%M',x) + '：' + y + ' (MW)</span>';
					if(container == gsqc){
						tp_qc = footHtml;
					}
					var json_str = {};
					json_str.x = x;
					json_str.y = y;
					series_dt.addPoint(json_str, true, false);
				}
			}
		});
	}
	
	//查询1-6号机组发电有功最新数据 
	function crewIntervalData(chartObj){
		var container = chartObj.renderTo.id;
		var mrid;
		if(container == gs1){
			mrid = crew_mrid1;
		}else if(container == gs2){
			mrid = crew_mrid2;
		}else if(container == gs3){
			mrid = crew_mrid3;
		}else if(container == gs4){
			mrid = crew_mrid4;
		}else if(container == gs5){
			mrid = crew_mrid5;
		}else if(container == gs6){
			mrid = crew_mrid6;
		}
		//查询   【全厂发电有功】
		$.ajax({
			type:'get',
			url: path + "/report/generalSituation/"+ mrid +"/queryMaxTime",
			data:{
				"startTime":startTime,"endTime":endTime
			},
			//async:false, 是否同步加载
			success:function(data){
				if(data && data.maxGs && data.maxGs.tId){
					var series_dt = chartObj.series[1];
					var x = data.maxGs.tId, y = data.maxGs.mw;
					// 当天最新时间
					var footHtml = '<span style="font-size:13px;color:#698B22">最新 ' + endTime + " " + Highcharts.dateFormat('%H:%M',x) + '：' + y + ' (MW)</span>';
					if(container == gs1){
						tp_gs1 = footHtml;
					}else if(container == gs2){
						tp_gs2 = footHtml;
					}else if(container == gs3){
						tp_gs3 = footHtml;
					}else if(container == gs4){
						tp_gs4 = footHtml;
					}else if(container == gs5){
						tp_gs5 = footHtml;
					}else if(container == gs6){
						tp_gs6 = footHtml;
					}
					var json_str = {};
					json_str.x = x;
					json_str.y = y;
					series_dt.addPoint(json_str, true, false);
				}
			}
		});
	}
	
	//查询   【电厂月最大有功出力】  柱状图和折线混合图	
	function query_cs_data(){
		//查询   【电厂月最大有功出力】	
		$.ajax({
			type: 'get',
			url: path + "/static/system/charts/highcharts/json/dcydl_json",
			data: {},
			success:function(data){
				var d = eval("(" + data + ")");
				create_graph_cs_data(gs7, sYear + "年~" + eYear +"年 电厂月最大有功出力", d);
			}
		});	
	}
	
	//柱状和折线混合图     图形数据
	function create_graph_cs_data(container, titleName, data){
		var searchDataArray = [];//前一天数据
		var searchDataArray_ = [];//当天数据
		var searchDataArray_tb = [];//同比数据
		var time_categories = new Array();//时间段	
		if(data && data.rows1){
			//前一年数据
			for(var t = 0 ; t < data.rows1.length ; t++){
				if(data.rows1[t] == null || data.rows1[t] == undefined || data.rows1[t] == "")
					continue;
				//拿到时间段
				var time = data.rows1[t].tId;
				time_categories.push(time + "月");
				var pData = data.rows1[t].maxMW;
				var searchData = null;
				if(pData != undefined && pData != ""){
					searchData = pData;
				}
				//拿到前一年数据 
				searchDataArray.push(searchData);
				
				//本年数据
				var searchData_ = null;
				if(data.rows2 && data.rows2[t] != ""){
					var dr = data.rows2[t];
					if(dr != undefined && dr != ""){
						var pData_ = dr.maxMW;
						if(pData_ != undefined && pData_ != ""){
							searchData_ = pData_;
						}
					}
				}
				//本年数据
				searchDataArray_.push(searchData_);
				
				//同比增长 (本年值-去年值)%去年值*100%
				var searchData_tb = null;
				if(searchData != null && searchData_ != null){
					searchData_tb = (searchData_-searchData)/searchData*100;
					searchData_tb = parseFloat(searchData_tb.toFixed(2));
				}
				searchDataArray_tb.push(searchData_tb);
			}
		}
		var name_dataArray = new Array();
		//柱状图形数据1
		var jsonStr = {};
		jsonStr.type = "column";
		jsonStr.name = sYear + "年最大有功出力";
		jsonStr.data = searchDataArray;	
		jsonStr.tooltip = {valueSuffix:" (MW)"};	
		//柱状图形数据2
		var jsonStr_ = {};
		jsonStr_.type = "column";
		jsonStr_.name = eYear + "年最大有功出力";
		jsonStr_.data = searchDataArray_;
		jsonStr_.tooltip = {valueSuffix:" (MW)"};	
		//折线图形数据  同比
		var jsonStr_tb = {};
		jsonStr_tb.type = 'spline';
		jsonStr_tb.name = "同比增长";
		jsonStr_tb.yAxis = 1;
		jsonStr_tb.data = searchDataArray_tb;
		jsonStr_tb.marker = {
            lineWidth: 2,
            lineColor: Highcharts.getOptions().colors[2],
            fillColor: 'white'
        };
		jsonStr_tb.tooltip = {"valueSuffix":"%"};	
		name_dataArray.push(jsonStr); 				
		name_dataArray.push(jsonStr_);
		name_dataArray.push(jsonStr_tb);
		//柱状和折线混合图
		initCharColumnAndSpline(container, titleName, name_dataArray, time_categories);
	}
	
	//柱状和折线混合图
	function initCharColumnAndSpline(container, titleName, name_dataArray, time_categories) {
		$("#"+container).highcharts({
			chart: {
				backgroundColor: back_color
			},
	        title: {
	            text: titleName,
	            style:{
	            	color: title_color
	            }
	        },
	        xAxis: {
	            categories: time_categories
	        },
	        yAxis: [{
	        	title: {
	                text: ''
	            },
	        	labels: {
	        		format:'{value}MW',
	        		style:{
	        			color:Highcharts.getOptions().colors[0]
	        		}
	        	}
	        },{
	        	title: {
	                text: ''
	            },
	        	labels: {
	        		format:'{value}%',
	        		style:{
	        			color:Highcharts.getOptions().colors[1]
	        		}
	        	},
	        	opposite:true//是否在正常显示对立面显示轴
	        }],
	        tooltip: {
	        	pointFormat:'<span style="color:{series.color}">{series.name}</span>：<b>{point.y}</b><br/>',
	        	shared:true
	        },
	        legend: {//图例
	            layout: 'horizontal',
	            align: 'center',
	            verticalAlign: 'bottom',
	            itemStyle: {
	            	cursor: 'pointer',
	            	color: '#3e576F'
	            }
	        },
	        credits: {
	        	enabled:false//是否显示版权
	        },
	        series: name_dataArray
	    });
	}

	
	//查询  饼图  数据
	function query_pie_data(){
		//查询   【饼图数据】	
		$.ajax({
			type: 'get',
			url: path + "/static/system/charts/highcharts/json/bing_json",
			data: {},
			success: function(data){
				var d = eval("(" + data + ")");
				create_graph_pie_data(gs8, data.dateStr + "<br/>机组发电有功", d);
			}
		});	
	}
	
	//饼图     图形数据
	function create_graph_pie_data(container,titleName,data){
		var pie_data1 = ["1号机组",null];
		var pie_data2 = ["2号机组",null];
		var pie_data3 = ["3号机组",null];
		var pie_data4 = ["4号机组",null];
		var pie_data5 = ["5号机组",null];
		var pie_data6 = ["6号机组",null];
		if(data && data.rows1 && data.rows1[0]){
			var pdata = data.rows1[0].mw;
			if(pdata != undefined){
				pie_data1[1] = pdata;
			}
		}
		if(data && data.rows2 && data.rows2[0]){
			var pdata = data.rows2[0].mw;
			if(pdata != undefined){
				pie_data2[1] = pdata;
			}
		}
		if(data && data.rows3 && data.rows3[0]){
			var pdata = data.rows3[0].mw;
			if(pdata != undefined){
				pie_data3[1] = pdata;
			}
		}
		if(data && data.rows4 && data.rows4[0]){
			var pdata = data.rows4[0].mw;
			if(pdata != undefined){
				pie_data4[1] = pdata;
			}
		}
		if(data && data.rows5 && data.rows5[0]){
			var pdata = data.rows5[0].mw;
			if(pdata != undefined){
				pie_data5[1] = pdata;
			}
		}
		if(data && data.rows6 && data.rows6[0]){
			var pdata = data.rows6[0].mw;
			if(pdata != undefined){
				pie_data6[1] = pdata;
			}
		}
		var searchDataArray = new Array();//饼图数据
		searchDataArray.push(pie_data1);
		searchDataArray.push(pie_data2);
		searchDataArray.push(pie_data3);
		searchDataArray.push(pie_data4);
		searchDataArray.push(pie_data5);
		searchDataArray.push(pie_data6);
		
		var jsonStr = {};
		jsonStr.type = "pie";
		jsonStr.name = data.dateStr;
		jsonStr.data = searchDataArray;	
		var name_dataArray = new Array();;
		name_dataArray.push(jsonStr); 				
		
		// 饼图
		initChartPre(container, titleName, name_dataArray);
	}
	
	// 饼图
	function initChartPre(container, titleName, name_dataArray) {
		$("#"+container).highcharts({
	        chart: {
   				backgroundColor: back_color
	        },
	        title: {
	            text: titleName,
	            style:{
	            	color: title_color
	            }
	        },
	        tooltip: {
	        	pointFormat:'<span style="color:{series.color}">{series.name}</span><br/>最大有功出力：<b>{point.y}(MW)<br/>占比：{point.percentage:.1f}%</b>'
	        },
	        credits: {
	        	enabled:false//是否显示版权
	        },
	        plotOptions: {
	        	pie: {
	        		allowPointSelect: true,
	        		cursor: 'pointer',
	        		dataLabels: {
	        			enabled: true,
	        			format: '<span style="color:{point.color}">{point.name}</span>',
	        			style: {
	        				color: (Highcharts.theme && highcharts.theme.contrastTextColor) || 'black'
	        			}
	        		}
	        	}
	        },
	        series: name_dataArray
	    });
	}
	
	$(function(){
		var seriesArray = [];
		//图形数据1
		var jsonStr = {};			  				
		jsonStr.name = startTime + "发电有功";
		jsonStr.data = [];	
		//图形数据2
		var jsonStr_ = {};			  				
		jsonStr_.name = endTime + "发电有功";
		jsonStr_.data = [];
		seriesArray.push(jsonStr); 				
		seriesArray.push(jsonStr_);
		
		initChartSpline(gsqc, gsqc_text, seriesArray);
		initChartSpline(gs1, crew1_text, seriesArray);
		initChartSpline(gs2, crew2_text, seriesArray);
		initChartSpline(gs3, crew3_text, seriesArray);
		initChartSpline(gs4, crew4_text, seriesArray);
		initChartSpline(gs5, crew5_text, seriesArray);
		initChartSpline(gs6, crew6_text, seriesArray);

		//饼图
		var jsonStr_ = {};
		jsonStr_.type = "pie";
		jsonStr_.name = "";
		jsonStr_.data = [];	
		var name_dataArray_ = [];
		name_dataArray_.push(jsonStr_); 	
		initChartPre(gs8, endTime + "机组发电有功", name_dataArray_);
		
		var name_dataArray = [];
		//柱状图形数据1
		var jsonStr = {};
		jsonStr.type = "column";
		jsonStr.name = sYear + "有功出力";
		jsonStr.data = [];	
		//柱状图形数据2
		var jsonStr_ = {};
		jsonStr_.type = "column";
		jsonStr_.name = eYear + "有功出力";
		jsonStr_.data = [];
		//折线图形数据  同比
		var jsonStr_tb = {};
		jsonStr_tb.type = 'spline';
		jsonStr_tb.name = "同比增长";
		jsonStr_tb.data = [];
		name_dataArray.push(jsonStr); 				
		name_dataArray.push(jsonStr_);
		name_dataArray.push(jsonStr_tb);
		
		//柱状和折线混合图
		initCharColumnAndSpline(gs7, sYear + "年~" + eYear + "年电厂月最大有功出力", name_dataArray,[]);
	});
	
</script>
</html>