$("#hcharts3").height(250);
	//设置默认颜色
	Highcharts.setOptions({
	    colors: ['#FF9655', '#FFF263', '#DDDF00', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
		global: {
			useUTC: false
		},
		lang:{
			months:[ "1月" , "2月" , "3月" , "4月" , "5月" , "6月" , "7月" , "8月" , "9月" , "10月" , "11月" , "12月"]
		}
	});
	var data = [
       {"tId":1459440000000,"qnTQMW":423.1,"zdMW":323.1},
       {"tId":1462032000000,"qnTQMW":623.6,"zdMW":223.6},
       {"tId":1464710400000,"qnTQMW":223.5,"zdMW":423.5},
       {"tId":1467302400000,"qnTQMW":123.4,"zdMW":123.4},
       {"tId":1469980800000,"qnTQMW":887.1,"zdMW":387.1},
       {"tId":1472659200000,"qnTQMW":543.1,"zdMW":543.1},
       {"tId":1475251200000,"qnTQMW":354.6,"zdMW":654.6},
       {"tId":1477929600000,"qnTQMW":254.1,"zdMW":254.1},
       {"tId":1480521600000,"qnTQMW":253.1,"zdMW":653.1},
       {"tId":1483200000000,"qnTQMW":523.1,"zdMW":223.1},
       {"tId":1485878400000,"qnTQMW":663.1,"zdMW":763.1},
       {"tId":1488297600000,"qnTQMW":355.1,"zdMW":455.1}
    ];
	
	var chart3;
	$(function () {
		//ajax查询数据
		queryData3();
	});
	
	//查询数据
	function queryData3(){
		if(data){
			var zdMWDataArray = [];
			var qnTQMWDataArray = [];
			var tbDataArray = [];
			
			for(var i = 0 ; i < data.length ; i++){
				//时间
				var time = data[i].tId;
				//最大出力
				var zdMWData = {};
				zdMWData.x = time;
				zdMWData.y = data[i].zdMW;
				//去年同期
				var qnTQMWData = {};
				qnTQMWData.x = time;
				qnTQMWData.y = data[i].qnTQMW;
				//同比  （最大出力-去年同期）/去年同期*100%
				var tbData = {};
				tbData.x = time;
				tbData.y = (data[i].zdMW - data[i].qnTQMW)/data[i].qnTQMW*100;
				
				zdMWDataArray.push(zdMWData);
				qnTQMWDataArray.push(qnTQMWData);
				tbDataArray.push(tbData);
			}
			//柱状图形数据    收入
			var jsonStr = {};
			jsonStr.type = "column";
			jsonStr.name = "最大出力";
			jsonStr.allowPointSelect = true;
			jsonStr.data = zdMWDataArray;	
			jsonStr.color = Highcharts.getOptions().colors[0];
			jsonStr.tooltip = {valueSuffix:" ( MW )"};	
			
			//柱状图形数据   支出
			var jsonStr_ = {};
			jsonStr_.type = "column";
			jsonStr_.name = "去年同期";
			jsonStr_.data = qnTQMWDataArray;
			jsonStr_.color = Highcharts.getOptions().colors[1];
			jsonStr_.tooltip = {valueSuffix:" ( MW )"};	
			
			//折线图形数据  盈利
			var jsonStr_tb = {};
			jsonStr_tb.type = 'spline';
			jsonStr_tb.name = "同比";
			jsonStr_tb.allowPointSelect = true;
			jsonStr_tb.yAxis = 1;
			jsonStr_tb.data = tbDataArray;
			jsonStr_tb.color = Highcharts.getOptions().colors[3];
			jsonStr_tb.marker = {
	            lineWidth: 2,
	            lineColor: Highcharts.getOptions().colors[3],
	            fillColor: 'white'
	        };
			jsonStr_tb.tooltip = {valueSuffix:"%"};	
			
			var seriesData = [];
			seriesData.push(jsonStr); 				
			seriesData.push(jsonStr_);
			seriesData.push(jsonStr_tb);
			createColumnGraph(seriesData);
		}
	
	}
	
	function createColumnGraph(seriesData){
		chart3 = new Highcharts.Chart({
	        chart: {
	            renderTo: 'hcharts3'
	        },
	        xAxis: {
	            type:'datetime',
	            dateTimeLabelFormats: {
	            	day : '%Y-%m-%d',
	            	month : '%Y-%m-%d',
	            	year : '%Y-%m-%d'
	            },
	            /* labels: {  
	            	formatter: function() {  
	            		return this.value; // clean, unformatted number for year  
	            	}  
            	}, */
	          	lineWidth: 2 //基线宽度 
	        },
	        yAxis: [{
	            title: {
	                text: '单位：( 元 )',
	                style: {
	                    color: Highcharts.getOptions().colors[0]
	                }
	            },
	            lineWidth: 2 //基线宽度 
	        }, {
	            title: {
	            	text: '单位：( 元 )',
	                style: {
	                    color: Highcharts.getOptions().colors[0]
	                }
	            },
	            opposite: true,
	            lineWidth: 2 //基线宽度 
	        }],
	        credits: { //图表版权信息
	            enabled: false//是否显示版权信息。通过设置为false即可禁用版权信息。 默认是：true.
	        }, 
	        title: {
	            text: '',
	            style: {//标题样式。用于设置文字颜色、字体、字号，但是字体的对齐则使用algin、x和y元素。默认是： { "color": "#333333", "fontSize": "18px" } 默认是：[object Object].
	        		color: '#6D869F',
					fontWeight: 'bold'
	            } 
	        },
	        subtitle: { 
	            text: '', //图表的副标题文字，默认是空，即默认是没有副标题的。
	        	style: { //文字样式。用于设置文字颜色、字体、字号。当更改margin属性、或者添加position："absolute"，left 和 top 属性的时候，能够取到标题的准确定位。 默认是：[object Object].
	        		color: '#6D869F',
					fontWeight: 'bold'
	            }
	        }, 
	        tooltip: {
	        	shared: false,//Boolean 当提示框被共享时，整个绘图区都将捕捉鼠标指针的移动。提示框文本显示有序数据(不包括饼图，散点图和标志图(flag)等)的系列类型将被显示在单一的气泡中。推荐在单一系列的图表和平板/手机优化的图表中使用。
	        	animation: true,//Boolean 启用或禁用数据提示框提示框的动画效果。在旧版本 IE 浏览器中，动画效果是默认被禁用的。 默认是：true.
	        	pointFormat: '<span style="color:{series.color}">\u25CF</span> {series.name}: <b>{point.y}</b><br/>',/*String 提示框中该点的HTML代码。变量用花括号括起来。可用的变量有point.x, point.y, series.name and series.color和以相同的形式表示的其它属性。*/
	        	style: {//CSSObject 为提示框添加CSS样式。提示框同样能够通过CSS类.highcharts-tooltip来设定样式。
		        	color: '#333333',
		        	fontSize: '12px',
		        	padding: '8px'
	        	},
	        	valueSuffix: ' ( 元 )'//String 一串字符被后置在每个Y轴的值之后。可重写在每个系列的提示框选项的对象上。
	        },
	        legend: {  //图例 
	            enabled: false//Boolean 图例开关。 默认是：true
	        },
	        series: seriesData
	    });
	}