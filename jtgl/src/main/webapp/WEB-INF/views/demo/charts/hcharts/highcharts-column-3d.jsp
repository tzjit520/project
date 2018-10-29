<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<%@ include file="/templates/include.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/highcharts-3d.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<title>3D柱状图</title>
</head>
<body>
	<div id="container"></div>
	<input type="hidden" value="<%=request.getContextPath()%>" id="path">	
</body>
<script type="text/javascript">
	$("#container").height($(window).height());
	//设置默认颜色
	Highcharts.setOptions({
	    colors: ['#FF9655', '#24CBE5', '#DDDF00', '#FFF263', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
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
		createColumnGraph([]);
	}
	
	function createColumnGraph(seriesData){
		chart = new Highcharts.Chart({
	        chart: {
	        	renderTo: 'container', //图表放置的容器，DIV 
	            type: 'column',
	            options3d: {//3D图像设置项。3D效果需要引入highcharts-3d.js
	                enabled: true,//画图表是否启用3D函数，默认值为：false
	                alpha: 20,//3D图旋转角度，此为α角，内旋角度 默认是：0
	                beta: 10,//3D图旋转角度，此为β角，外旋角度 默认是：0
	                depth: 100,//图表的全深比，即为3D图X，Y轴的平面点固定，以图的Z轴原点为起始点上下旋转，值越大往外旋转幅度越大，值越小往内旋转越大，depth的默认值为100 默认是：100
	                frame: {//Frame框架，3D图包含柱的面板，我们以X ,Y，Z的坐标系来理解，X轴与 Z轴所形成的面为bottom，Y轴与Z轴所形成的面为side，X轴与Y轴所形成的面为back，bottom、side、back的属性一样，其中size为感官理解的厚度，color为面板颜色
	                	back: {//3D图的背面面板
	                		color: 'transparent',//Color 面板颜色，默认是： transparent. 默认是：transparent
	                		size: 1//Number 面板厚度，默认是： 1. 默认是：1
	                	},
	                	bottom: {//3D图框架的底板
	                		color: 'transparent',//Color 底板颜色， 默认是： transparent. 默认是：transparent
	                		size: 1//Number 底板厚度，默认是： 1. 默认是：1
	                	},
	                	side: {//3D图中，Y轴与Z轴所形成的面为side
	                		color: 'transparent',//Color side颜色，默认是： transparent. 默认是：transparent
	                		size: 1//Number side厚度，默认是： 1. 默认是：1
	                	}
	                },
	                viewDistance: 100 //Number 它定义了观看者在图前看图的距离，它是非常重要的对于计算角度影响在柱图和散列图，此值不能用于3D的饼图，默认值为100 默认是：100
	            }
	        },
	        title: {
	            text: '2016年支出费用汇总',
	            style: {//标题样式。用于设置文字颜色、字体、字号，但是字体的对齐则使用algin、x和y元素。默认是： { "color": "#333333", "fontSize": "18px" } 默认是：[object Object].
	        		color: '#6D869F',
					fontWeight: 'bold'
	            } 
	        },
	        subtitle: { 
	            text: '支出费用详情', //图表的副标题文字，默认是空，即默认是没有副标题的。
	        	style: { //文字样式。用于设置文字颜色、字体、字号。当更改margin属性、或者添加position："absolute"，left 和 top 属性的时候，能够取到标题的准确定位。 默认是：[object Object].
	        		color: '#6D869F',
					fontWeight: 'bold'
	            }
	        }, 
	        plotOptions: {
	            column: {
	                depth: 25
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
	        }],
	        tooltip: {
	        	shared: false,//Boolean 当提示框被共享时，整个绘图区都将捕捉鼠标指针的移动。提示框文本显示有序数据(不包括饼图，散点图和标志图(flag)等)的系列类型将被显示在单一的气泡中。推荐在单一系列的图表和平板/手机优化的图表中使用。
	        	animation: true,//Boolean 启用或禁用数据提示框提示框的动画效果。在旧版本 IE 浏览器中，动画效果是默认被禁用的。 默认是：true.
	        	pointFormat: '<span style="color:{series.color}">\u25CF {series.name}：{point.y}</span><br/>',/*String 提示框中该点的HTML代码。变量用花括号括起来。可用的变量有point.x, point.y, series.name and series.color和以相同的形式表示的其它属性。*/
	        	style: {//CSSObject 为提示框添加CSS样式。提示框同样能够通过CSS类.highcharts-tooltip来设定样式。
		        	color: '#333333',
		        	fontSize: '12px',
		        	padding: '8px'
	        	},
	        	valueSuffix: ' ( 元 )'//String 一串字符被后置在每个Y轴的值之后。可重写在每个系列的提示框选项的对象上。
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
	        series: [{
	            name: '房租',
	            data: [1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400, 1400]
	        },{
	            name: '生活用品',
	            data: [230, 350, 600, 840, 120, 590, 760, 480, 260, 510, 420, 950]
	        }]
	    });
	}
</script>
</html>