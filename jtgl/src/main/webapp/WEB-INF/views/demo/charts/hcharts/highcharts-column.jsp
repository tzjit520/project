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
	$("#container").height($(window).height());
	//设置默认颜色
	Highcharts.setOptions({
	    colors: ['#FF9655', '#FFF263', '#DDDF00', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
	    lang: {
	    	contextButtonTitle: '输出',//String 输出模块菜单。菜单提示打印口控股菜单项目。默认 图表的上下文菜单
		    loading: '正在加载...',
		    downloadJPEG:'导出JPEG格式',//String  用于导出功能模块。导出为JPE图片选项对于的文字。 默认是：Download JPEG image
		    downloadPDF:'导出PDF格式',//String 用于导出功能模块。导出为PDF文件选项显示的文字 默认是：Download PDF document
		    downloadPNG:'导出PNG格式',//String 用于导出功能模块。导出为PNG图片选项显示的文字。 默认是：Download PNG image.
		    downloadSVG:'导出SVG格式',//String 用于导出功能模块。导出为SVG文件选项显示的文字。 默认是：Download SVG vector image
		    printChart:'打印图表'//String 用于导出功能模块。触发菜单项目（menu item）打印图表时，将显示该文本。 默认是：Print chart.
		}
	});
	
	var chart;
	$(function () {
		var seriesData = [];
		createColumnGraph(seriesData);
		//ajax查询数据
		queryData();
		
	});
	
	//查询数据
	function queryData(){
		chart.showLoading();
		//查询  数据
		$.ajax({
			type:'get',
			url: $("#path").val() + "/family/highcharts/queryData.action",
			data:{},
			success:function(d){
				var data = eval("("+d+")");
				if(data){
					var dataSrArray = [];
					var dataZcArray = [];
					var dataYlArray = [];
					for(var i = 0 ; i < data.length ; i++){
						dataSrArray.push(data[i].sr);
						dataZcArray.push(data[i].zc);
						dataYlArray.push(data[i].yl);
					}
					//柱状图形数据    收入
					var jsonSr = {};
					jsonSr.type = "column";
					jsonSr.name = "收入";
					jsonSr.allowPointSelect = true;
					jsonSr.data = dataSrArray;	
					jsonSr.color = Highcharts.getOptions().colors[0];
					jsonSr.tooltip = {valueSuffix:" ( 元 )"};	
					
					//柱状图形数据   支出
					var jsonZc = {};
					jsonZc.type = "column";
					jsonZc.name = "支出";
					jsonZc.data = dataZcArray;
					jsonZc.color = Highcharts.getOptions().colors[1];
					jsonZc.tooltip = {valueSuffix:" ( 元 )"};	
					
					//折线图形数据  盈利
					var jsonYl = {};
					jsonYl.type = 'spline';
					jsonYl.name = "盈利";
					jsonYl.allowPointSelect = true;
					jsonYl.yAxis = 1;
					jsonYl.data = dataYlArray;
					jsonYl.color = Highcharts.getOptions().colors[3];
					jsonYl.marker = {
			            lineWidth: 2,
			            lineColor: Highcharts.getOptions().colors[3],
			            fillColor: 'white'
			        };
					jsonYl.tooltip = {valueSuffix:" ( 元 )"};	
					
					var seriesData = [];
					seriesData.push(jsonSr); 				
					seriesData.push(jsonZc);
					seriesData.push(jsonYl);
					createColumnGraph(seriesData);
					chart.hideLoading();
				}
			}
		});	
	}
	
	function createColumnGraph(seriesData){
		chart = new Highcharts.Chart({
	        chart: {
	            renderTo: 'container', //图表放置的容器，DIV 
	            //type: 'column'
	        },
	        credits: { //图表版权信息
	            enabled: true,//是否显示版权信息。通过设置为false即可禁用版权信息。 默认是：true.
	            text: '点击去百度',//String类型     版权信息显示的文字。 默认是：Highcharts.com.
	            href: 'http://baidu.com', //版权信息链接地址。   默认是：http://www.highcharts.com.
	            position: { //版权信息显示位置。  可配置的属性有 align, verticalAlign, x 和 y。默认是 position: { align: 'right', x: -10, verticalAlign: 'bottom', y: -5 }
	            	align: 'right',//左右对齐   可配置参数：left、right、center
	            	x: -60, //x 水平偏移      指定位置的偏移量，负数代表向上偏移，正数代表向下偏移。
	            	verticalAlign: 'bottom',//上下对齐    可配置参数： bottom、top、middle
	            	y: -15 //y  竖直偏移      指定位置的偏移量，负数代表向左偏移，正数代表向右偏移。
	            },
	           	style: {//版权文字样式，可设置文字颜色、字体、字号、加粗等。默认是： style: {  cursor: 'pointer', color: '#909090', fontSize: '10px' }
	           		cursor: 'pointer',//光标呈现为指示链接的指针（一只手）
	           		color: '#EE7942',
	           		fontSize: '12px'
	           	}
	        }, 
	        title: {
	            text: '2016年(全年收入支出统计)',
	            style: {//标题样式。用于设置文字颜色、字体、字号，但是字体的对齐则使用algin、x和y元素。默认是： { "color": "#333333", "fontSize": "18px" } 默认是：[object Object].
	        		color: '#6D869F',
					fontWeight: 'bold'
	            } 
	        },
	        subtitle: { 
	            text: '收入支出柱状图', //图表的副标题文字，默认是空，即默认是没有副标题的。
	        	style: { //文字样式。用于设置文字颜色、字体、字号。当更改margin属性、或者添加position："absolute"，left 和 top 属性的时候，能够取到标题的准确定位。 默认是：[object Object].
	        		color: '#6D869F',
					fontWeight: 'bold'
	            }
	        }, 
	        xAxis: {
	            categories: ['一月份', '二月份', '三月份', '四月份', '五月份', '六月份', '七月份', '八月份', '九月份', '十月份', '十一月份', '十二月份'], //x轴  类别名称
	        	title: {//坐标轴标题，显示在轴线旁。
	          		align: 'middle',//String 轴标题相对于轴值的对齐方式。可能的值是“low”，“middle”或“high”。 默认是：middle
	          		text: '这是坐标轴(X)标题',//String 轴标题的显示文本。它可以包含类似的，基本的HTML标签
	          		margin: 5,//Number 轴标题距离轴值或者轴线的像素值。水平轴默认为0，垂直轴默认为10
	          		offset: 40,//Number 轴标题到轴线的距离
	          		rotation: 0,//Number 轴标题的旋转角度，水平轴默认为0度，垂直轴默认为270度。 默认是：0
	          		style: {//CSSObject 轴标题的CSS样式。然而轴标题的旋转是使用矢量图形渲染技术实现的，并不是所有的样式都是可使用的。 默认是：[object Object]
	          			color: '#6D869F',
						fontWeight: 'bold'
	          		}
	          	},
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
	        	layout: 'vertical',  //String 图例数据项的布局。布局类型：水平或垂直。默认是：水平 (horizontal)   水平（horizontal）/垂直（vertical） 
	            backgroundColor: '#ffc', //Color 图例容器的背景颜色
	            align: 'left', //String 图例容器（中的图例）水平对齐在图表区，合法值有"left", "center" 和 "right". 默认是： center. 默认是：center
	            enabled: true,//Boolean 图例开关。 默认是：true
	            floating: true,//Boolean 图例容器是否可以浮动，当此值设置为false时，图例是不可在数据区域图之上，它们是不可重叠的，而设成true，则可。默认是： false.
	            shadow: true,//Boolean|Object 图例投影。当（用户想）应用投影到图例中时，只有backgroundColor也得应用到图例中，投影的效果才能生效。自2.3版本以后阴影能作为一个对象来配置，里面的属性有color, offsetX, offsetY, opacity 和 width. 默认是： false
	            title: {//图例上方的标题
	            	text: '这是图例的标题',//String 标题可以是文本或者HTML字符串。 默认是："null"
	            	style: {//CSSObject 图例上方的标题的样式。默认: style: { fontWeight: 'bold' }
	            		color: '#6D869F',
						fontWeight: 'bold'
	            	}
	            },
	            verticalAlign: 'top',//String 垂直对齐。能取"top", "middle" or "bottom"之一。垂直对齐的位置可通过Y设置进一步调整它的位置。 默认是：bottom
	            x: 100,//Number 整个图例Ｘ轴偏移量，它是相对于水平布局定下后，chart.spacingLeft 和 chart.spacingRight.的空间左右移动，当ｘ值为负值时，图例朝左移动；正值时，图例朝右移动。 默认是：0
	            y: 70//Number 整个图例垂直偏移量，它是相对于垂直布局定下后，chart.spacingTop 和 chart.spacingBottom的空间垂直移动，当y值为负值时，图例朝上移动；正值时，图例朝下移动。 默认是：0
	        },
	        navigation: {//显示在导出模块中的按钮和菜单的选项集合
	        	buttonOptions: {//导出模块中显示的按钮的选项集合
	        		enabled: true,//Boolean 是否启用模板功能 默认是：true
	        		text: '菜单',//String 默认是：null
	                theme: {//按钮主题的配置对象。对象接受SVG特性像笔划宽度，描边和填充。三态按钮样式的states.hover和states.select对象支持
	                    'stroke-width': 2,
	                    stroke: 'silver',
	                    r: 1,
	                    states: {
	                        hover: {
	                            fill: '#a4edba'
	                        },
	                        select: {
	                            stroke: '#039',
	                            fill: '#a4edba'
	                        }
	                    }
	                }
	        	}
	        },
	        exporting: { 
	            enabled: true, //是否启用导出模块。禁用该模块将会隐藏菜单按钮，但是 API 的导出相关方法还是可用的。 默认是：true
	        	filename: 'chart',//String 用来导出图表不含拓展名称的文件名。 默认是：chart
	        	buttons: {//导出功能相关按钮的选项，包含打印和导出按钮。除了默认按钮，我们也可以添加自定义的按钮。可以参照 navigation.buttonOptions 参数中额外的选项。
	        		contextButton: {//导出按钮的配置，可以在这个配置下面增加自定义按钮
		        		x: -35,//按钮相对于align选项的水平位置   Number 默认是：-10
		        		y: 20 //相对于verticalAlign选项的垂直偏移量   Number 默认是：0
	        		},
	        		exportButton: {
	                    text: '导出',
	                    menuItems: [{
	                        text: '导出固定大小(宽度950)',
	                        onclick: function () {
	                            this.exportChart({
	                                width: 950
	                            });
	                        }
	                    }, {
	                        text: '导出固定大小(宽度750)',
	                        onclick: function () {
	                        	this.exportChart({
	                                width: 750
	                            });
	                        },
	                        separator: false
	                    }],
	                    x: -110,//按钮相对于align选项的水平位置   Number 默认是：-10
		        		y: 20 //相对于verticalAlign选项的垂直偏移量   Number 默认是：0
	                    // 默认菜单项
	                    //menuItems: Highcharts.getOptions().exporting.buttons.contextButton.menuItems.splice(2)
	                },
	                printButton: {
	                    text: '打印',
	                    onclick: function () {
	                        this.print();
	                    },
		                x: -160,//按钮相对于align选项的水平位置   Number 默认是：-10
		        		y: 20 //相对于verticalAlign选项的垂直偏移量   Number 默认是：0
	                }
	        	}
	        },
	        loading: {
		        hideDuration: 500,//Number 淡出效应毫秒的持续时间。默认值为100
		        showDuration: 500,//Number 淡入淡出的毫秒持续时间。默认值为100
		        labelStyle: {//CSSObject 对于加载CSS样式标签跨度。
		        	"fontWeight": "bold", 
		        	"position": "relative", 
		        	"top": "45%" 
		        },
		        style: {//CSSObject 载入画面的覆盖面积的CSS样式  默认 { "position": "absolute", "backgroundColor": "#ffffff", "opacity": 0.5, "textAlign": "center" }
		        	"position": "absolute", 
		        	"backgroundColor": "#ffffff", 
		        	"opacity": 0.5, 
		        	"textAlign": "center" 
		        }
	        },
	        series: seriesData
	    });
	}
</script>
</html>