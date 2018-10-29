<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<%@ include file="/templates/include.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/drilldown.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	<title>下钻柱形图</title>
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
		createDrillDownGraph(seriesData);
		//ajax查询数据
		//queryData();
		
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
			}
		});	
	}
	
	function createDrillDownGraph(seriesData){
		chart = new Highcharts.Chart({
			chart: {
	            type: 'column',
	            renderTo: 'container' //图表放置的容器，DIV 
	        },
	        title: {
	            text: '2016全年收入支出明细',
	            style: {//标题样式。用于设置文字颜色、字体、字号，但是字体的对齐则使用algin、x和y元素。默认是： { "color": "#333333", "fontSize": "18px" } 默认是：[object Object].
	        		color: '#6D869F',
					fontWeight: 'bold'
	            } 
	        },
	        subtitle: {
	            text: '收入支出明细图',
	            style: {//标题样式。用于设置文字颜色、字体、字号，但是字体的对齐则使用algin、x和y元素。默认是： { "color": "#333333", "fontSize": "18px" } 默认是：[object Object].
	        		color: '#6D869F',
					fontWeight: 'bold'
	            } 
	        },
	        xAxis: {
	            type: 'category',
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
	        yAxis: {
	            title: {
	                text: '单位：( 元 )',
	                style: {
	                    color: Highcharts.getOptions().colors[5]
	                }
	            },
	            lineWidth: 2 //基线宽度 
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
	        legend: {
	            enabled: false
	        },
	        plotOptions: {
	            series: {
	                borderWidth: 0,
	                dataLabels: {
	                    enabled: true,
	                    format: '{point.y:.2f}'
	                }
	            }
	        },
	        tooltip: {
	            headerFormat: '<span style="font-size:11px">{series.name}</span><br>',
	            pointFormat: '<span style="color:{point.color}">{point.name}</span>：<b>{point.y:.2f} ( 元 )</b><br/>'
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
	            name: '2016全年收入明细',
	            colorByPoint: true,
	            data: [{
	                name: '一月份',
	                y: 56965.65,
	                drilldown: 'January sr'
	            }, {
	                name: '二月份',
	                y: 65985.65,
	                drilldown: 'February sr'
	            }, {
	                name: '三月份',
	                y: 31265.68,
	                drilldown: 'March sr'
	            }, {
	                name: '四月份',
	                y: 85634.76,
	                drilldown: 'April sr'
	            }, {
	                name: '五月份',
	                y: 71965.11,
	                drilldown: 'May sr'
	            }, {
	                name: '六月份',
	                y: 37634.65,
	                drilldown: null//'June sr'
	            }, {
	                name: '七月份',
	                y: 65862.76,
	                drilldown: null//'July sr'
	            }, {
	                name: '八月份',
	                y: 25679.65,
	                drilldown: null//'August sr'
	            }, {
	                name: '九月份',
	                y: 19854.67,
	                drilldown: null//'September sr'
	            }, {
	                name: '十月份',
	                y: 45824.12,
	                drilldown: null//'October sr'
	            }, {
	                name: '十一月份',
	                y: 53219.85,
	                drilldown: null//'November sr'
	            }, {
	                name: '十二月份',
	                y: 36965.91,
	                drilldown: null//'December sr'
	            }]
	        }/* ,{
	            name: '2016全年支出明细',
	            //colorByPoint: true,
	            data: [{
	                name: '一月份',
	                y: 56965.65,
	                drilldown: 'January sr'
	            }, {
	                name: '二月份',
	                y: 65985.65,
	                drilldown: 'February sr'
	            }, {
	                name: '三月份',
	                y: 31265.68,
	                drilldown: 'March sr'
	            }, {
	                name: '四月份',
	                y: 85634.76,
	                drilldown: 'April sr'
	            }, {
	                name: '五月份',
	                y: 71965.11,
	                drilldown: 'May sr'
	            }, {
	                name: '六月份',
	                y: 37634.65,
	                drilldown: null//'June sr'
	            }, {
	                name: '七月份',
	                y: 65862.76,
	                drilldown: null//'July sr'
	            }, {
	                name: '八月份',
	                y: 25679.65,
	                drilldown: null//'August sr'
	            }, {
	                name: '九月份',
	                y: 19854.67,
	                drilldown: null//'September sr'
	            }, {
	                name: '十月份',
	                y: 45824.12,
	                drilldown: null//'October sr'
	            }, {
	                name: '十一月份',
	                y: 53219.85,
	                drilldown: null//'November sr'
	            }, {
	                name: '十二月份',
	                y: 36965.91,
	                drilldown: null//'December sr'
	            }]
	        } */],
	        drilldown: {
	            series: [{
	                name: '一月份收入明细',
	                id: 'January sr',
	                data: [
	                    [ '2016-01-01', 2304.6 ],
	                    [ '2016-01-05', 658.15 ],
	                    [ '2016-01-07', 15326.8 ],
	                    [ '2016-01-11', 4968.5 ],
	                    [ '2016-01-16', 9567.2 ],
	                    [ '2016-01-21', 12843.6 ],
	                    [ '2016-01-28', 9126.5 ],
	                    [ '2016-01-30', 2170.3 ]
	                ]
	            }, {
	            	name: '二月份收入明细',
	                id: 'February sr',
	                data: [
	                    [ '2016-02-01', 2304.6 ],
	                    [ '2016-02-05', 658.15 ],
	                    [ '2016-02-07', 15326.8 ],
	                    [ '2016-02-11', 4968.5 ],
	                    [ '2016-02-16', 9567.2 ],
	                    [ '2016-02-21', 12843.6 ],
	                    [ '2016-02-23', 9126.5 ],
	                    [ '2016-02-24', 4208.9 ],
	                    [ '2016-02-26', 4811.1 ],
	                    [ '2016-02-28', 2170.3 ]
	                ]
	            }, {
	            	name: '三月份收入明细',
	                id: 'March sr',
	                data: [
	                    [ '2016-03-01', 2304.6 ],
	                    [ '2016-03-11', 4968.5 ],
	                    [ '2016-03-16', 9567.2 ],
	                    [ '2016-03-21', 2843.6 ],
	                    [ '2016-03-23', 926.5 ],
	                    [ '2016-03-24', 4208.9 ],
	                    [ '2016-03-28', 6446.38 ]
	                ]
	            }, {
	            	name: '四月份收入明细',
	                id: 'April sr',
	                data: [
	                    [ '2016-04-01', 12304.6 ],
	                    [ '2016-04-03', 9304.6 ],
	                    [ '2016-04-05', 15604.6 ],
	                    [ '2016-04-08', 22304.6 ],
	                    [ '2016-04-11', 5968.5 ],
	                    [ '2016-04-16', 8567.2 ],
	                    [ '2016-04-21', 3998.88 ],
	                    [ '2016-04-23', 2926.5 ],
	                    [ '2016-04-24', 4208.9 ],
	                    [ '2016-04-28', 446.38 ]
	                ]
	            }, {
	            	name: '五月份收入明细',
	                id: 'May sr',
	                data: [
	                    [ '2016-04-01', 12304.6 ],
	                    [ '2016-04-03', 9304.6 ],
	                    [ '2016-04-05', 1934.95 ],
	                    [ '2016-04-08', 22304.6 ],
	                    [ '2016-04-11', 5968.5 ],
	                    [ '2016-04-16', 8567.2 ],
	                    [ '2016-04-21', 3998.88 ],
	                    [ '2016-04-23', 2926.5 ],
	                    [ '2016-04-24', 4208.9 ],
	                    [ '2016-04-28', 446.38 ]
	                ]
	            }]
	        }
	    });
	}
</script>
</html>