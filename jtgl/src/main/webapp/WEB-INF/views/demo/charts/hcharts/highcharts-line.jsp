<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<%@ include file="/templates/include.jsp"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<script src="https://code.highcharts.com/highcharts.js"></script>
	<script src="https://code.highcharts.com/modules/exporting.js"></script>
	
	<title>Highcharts Example</title>
	<style type="text/css">
		.highcharts-point {
			stroke: white;
		}
		
		.highcharts-graph.zone-0 {
			stroke: #f7a35c;
		}
		.highcharts-area.zone-0 {
			fill: #f7a35c;
		}
		.highcharts-point.zone-0 {
			fill: #f7a35c;
		}
		.highcharts-graph.zone-1 {
			stroke: #7cb5ec;
		}
		.highcharts-area.zone-1 {
			fill: #7cb5ec;
		}
		.highcharts-point.zone-1 {
			fill: #7cb5ec;
		}
		.highcharts-graph.zone-2 {
			stroke: #90ed7d;
		}
		.highcharts-area.zone-2 {
			fill: #90ed7d;
		}
		.highcharts-point.zone-2 {
			fill: #90ed7d;
		}
	</style>
</head>
<body>
	<div id="container_line"></div>
	<div>
		<button id="button">加载</button>
	</div>
	<input type="hidden" value="http://localhost:8088/family/uploads/bg.jpg" id="bg"/>
	<script type="text/javascript">
		$("#container_line").height($(window).height()-25);
		var isLoading = false,
	    $button = $('#button');
		var chart; 
		//设置默认颜色
		Highcharts.setOptions({
		    colors: ['#058DC7', '#50B432', '#ED561B', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
		    lang: {
		    	contextButtonTitle: '输出',//String 输出模块菜单。菜单提示打印口控股菜单项目。默认 图表的上下文菜单
			    loading: '正在加载...',
			    downloadJPEG:'导出JPEG格式',//String  用于导出功能模块。导出为JPE图片选项对于的文字。 默认是：Download JPEG image
			    downloadPDF:'导出PDF格式',//String 用于导出功能模块。导出为PDF文件选项显示的文字 默认是：Download PDF document
			    downloadPNG:'导出PNG格式',//String 用于导出功能模块。导出为PNG图片选项显示的文字。 默认是：Download PNG image.
			    downloadSVG:'导出SVG格式',//String 用于导出功能模块。导出为SVG文件选项显示的文字。 默认是：Download SVG vector image
			    printChart:'打印图表',//String 用于导出功能模块。触发菜单项目（menu item）打印图表时，将显示该文本。 默认是：Print chart.
			    resetZoom: '重置'//String  图表在放大状态下，用于恢复初始比例的功能按钮上的文字。 默认是：Reset zoom.
			}
		});
		
		$(function() {
			
			$button.click(function () {
				if (!isLoading) {
		            chart.showLoading();
		            $button.html('取消');
		        } else {
		            chart.hideLoading();
		            $button.html('加载');
		        }
		        isLoading = !isLoading;
		    });
			
		    chart = new Highcharts.Chart({ 
		        chart: {
		        	alignTicks:true,//Boolean 坐标轴刻度对齐。当使用多个轴线时，两个或两个以上相反轴的刻度将会自动计算出合理的刻度间隔使刻度线数保持最少。默认是 true，即自动保持间隔对齐，可以通过设置 false 来阻止。如果网格线显得零乱，你也可以直接将网格线隐藏，即设置 gridLineWidth 为 0。 默认是：true.
		            renderTo: 'container_line', //图表放置的容器，DIV 
		            defaultSeriesType: 'line', //设置默认的图表类型，可选项line表示折线型，spline表示曲线型，area表示折线区域型，areaspline表示曲线区域型，column表示柱状型，bar表示横向条状型，pie表示饼状型，scatter表示散播型。String类型,默认为line
		            type:'line',//图表的基本类型。默认为line
		            backgroundColor:'#FFFFFF',//设置图表区的背景色。 String类型     默认值为#FFFFFF
		            borderWidth:1,//设置图表边框宽度   Number类型     默认值为0
		            borderRadius:8,//设置图表边框圆角角度,只有当borderWidth不为0的时候起作用。 Number类型   默认值为5
		            borderColor:'#4572A7',//设置图表边框的颜色，只有当borderWidth不为0的时候起作用。 String类型    默认值为  #4572A7
		            className:null,//String 给图表容器div加一个class，方便为每个图表单独加CSS样式
		            panKey:'Shift',//String 图表拖动按键。当图表放大后，可以按住所设定的按钮，例如“Shift”即可拖动图表
		            zoomType:'y', //决定在什么区域，用户可以通过拖动鼠标放大。可以通过x轴放大，可以通过y轴放大，也可以通过xy轴同时放大      String类型    默认为""
		            width:null,//报表容器的宽度。 Number类型   默认为null
		            height:null,//图表的高度，默认根据图表容器自适应高度。  Number类型    默认值null
		            ignoreHiddenSeries:true,//如果设置为true，点击legend时，轴将被隐藏  Boolean类型    默认为true。
		            inverted:false,//报表图是否反转，即x轴是垂直轴和y轴是水平的。设置为true的话，报表就会反转。 Boolean类型   默认为false
		            margin:[null],//margin 图表和绘图区的外边框之间的差距。 Array类型    默认值为margin:[null]
		            marginTop:null,//图表和绘图区的外上边框之间的差距。  Number类型    默认值为marginTop : null
		            marginRight:50,//图表和绘图区的外右边框之间的差距。 Number类型   默认值为marginRight : 50
		            marginBottom:70,//图表和绘图区的外底边框之间的差距。  Number类型   默认值为marginBottom  : 70
		            marginLeft:80,//图表和绘图区的外底边框之间的差距。 Number类型  默认值为marginLeft : 80
		            panning:false,//Boolean Panning为true可以使得图形能平移，false则关闭了图形平移的功能
		            pinchType:"null",//String 和zoomType属性相似，但是紧供多点触控。默认情况下，pinchType和zoomType设置时相同的，但是收聚可以在一些场合触发可用。例如，在股价分析图中，按住鼠标滑过图标，同时收聚就会被触发，默认是： null. 默认是："null"
		            plotBackgroundColor:null,//绘图区域的背景颜色。 Color类型  默认为null
		            plotBackgroundImage:null,//$("#bg").val(),//绘图区域的背景图片。 String类型    默认为null
		            plotBorderWidth:0,//绘图区域的边框的宽度。 Number类型   默认为0
		            plotBorderColor:'#C0C0C0',//绘图区域的边框颜色。只当plotBorderWidth不为0的时候才有效。 Color类型   默认#C0C0C0
		            plotShadow:false,//*绘图区域是否先阴影。只有在plotBackgroundColor不为空的时候才起作用。  Boolean类型    默认为false
		            polar:false,//Boolean Polar为true，则可将图转成极地图,但需引入highcharts-more.js. 默认是： false
		            reflow:false,//报表图的长度和宽度不随浏览器的变化而变化。true表示随着浏览器的变化而变化。 Boolean类型    默认为true
		            resetZoomButton:{
		            	position:{//Object resetZoomButton是当图表被放大后才会出现的按钮，它的作用是将放大的图回复到放大前的状态，而position则制定改按钮出现的位置，位置是相对于绘图区
		            		//align:'right',//默认
		                    //verticalAlign:'top',//默认
		                    x: -10,
		                    y: 10
		                },
		            	relativeTo:'plot',//String 它可以更改按钮位置是相对于绘图区还是整个chart区，此属性默认为绘图区 默认是：plot
		            	theme:{//Object 它是resetZoomButton按钮的主题
		            		fill: 'white',
		                    stroke: 'silver',
		                    r: 0,
		                    states: {
		                        hover: {
		                            fill: '#41739D',
		                            style: {
		                                color: 'white'
		                            }
		                        }
		                    }
		            	}
		            },
		            selectionMarkerFill: 'rgba(69,114,167,0.25)',//Color 当选中某一区域时图会被放大，此时选中区域会有背景颜色，此属性可以更改此背景，默认是： rgba(69,114,167,0.25) 默认是：rgba(69,114,167,0.25)		            
		            shadow:true,//*报表容器的阴影效果。只有在backgroundColor有值的情况下才有效。 Boolean类型   默认为false
		            showAxes:false,//*是否显示最初的坐标轴。仅适用于在空表中动态添加,坐标轴会自动添加series。 Boolean类型  默认为false
		            spacing: [10,10,15,10],//Array<Number> 图的外边框和绘图区之间的距离，此属性后面跟着是数组，它们分别代表上，右，下，左四个方位的距离。 默认是：10,10,15,10
		            spacingTop:10,//（绘图区，坐标轴标题标签，标题，副标题或legend中的顶部位置）的图表和内容上边缘之间的空间。 Number类型    默认值为10
		            spacingRight:10,//（绘图区，坐标轴标题标签，标题，副标题或legend中的顶部位置）的图表和内容右边缘之间的空间。Number类型   默认值为10
		            spacingBottom:15,//（绘图区，坐标轴标题标签，标题，副标题或legend中的顶部位置）的图表和内容下边缘之间的空间。Number类型  默认值为15
		            spacingLeft:10,//（绘图区，坐标轴标题标签，标题，副标题或legend中的顶部位置）的图表和内容左边缘之间的空间。 Number类型   默认值为10
		            style:{//设备存放报表容器DIV的样式。 CSSObject类型  默认值  {fontFamily: '"Lucida Grande","Lucida Sans Unicode", Verdana, Arial, Helvetica, sans-serif',fontSize: '12px'}
		            	fontFamily:'"Lucida Grande","Lucida Sans Unicode", Verdana, Arial, Helvetica, sans-serif',
		            	fontSize: '12px'
		            },
		            events:{ //触发图表背景所触发的一些事件。  click()单击事件     addSeries()添加坐标轴数据之前的方法    load()当图表加载完之后所触发的事件    redraw()重绘方法     selection()
		            	click:function(event){
		            		var label = this.renderer.label(
	                            'x轴: ' + Highcharts.numberFormat(event.xAxis[0].value, 2) + 
	                            '<br/>y轴: ' + Highcharts.numberFormat(event.yAxis[0].value, 2),
	                            event.xAxis[0].axis.toPixels(event.xAxis[0].value),
	                            event.yAxis[0].axis.toPixels(event.yAxis[0].value)
	                        ).attr({
	                            fill: Highcharts.getOptions().colors[0],
	                            padding: 10,
	                            r: 5,
	                            zIndex: 8
	                        }).css({
	                            color: '#FFFFFF'
	                        }).add();
	                        setTimeout(function () {
	                            label.fadeOut();
	                        }, 1000);
		            	}
		            }
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
		        	align: 'center', //String  图表标题水平对齐方式。有“"left", "center", "right"可选，分别对应“左对齐”、“居中对齐”、“右对齐”。 默认是：center.
		        	floating: false, //Boolean 标题是否浮动。当设置浮动（即该属性值为true）时，标题将不占空间。 默认false
		        	margin:15, //Number 标题和图表区的间隔，当有副标题，表示标题和副标题之间的间隔。 默认是：15.
		        	text: '<a href="">Highcharts基础折线图</a>', //图表的标题名，如果想不显示标题，把text设置为null。 默认是：Chart title.
		        	useHTML: false, //Boolean 标题是否使用HTML渲染，是否解析html标签，设置解析后，可以使用例如 a 等 html 标签      默认false
		        	verticalAlign: '', //String 标题垂直对齐方式。有“top”，”middle“和“bottom” 可选，分别对应“顶对齐”、“居中对齐”、“底对齐”。并且当给定一个值后，该标题将表现为浮动。 默认是："" .
		        	x: 0, //Number 相对于水平对齐的偏移量，取值范围为：图表左边距到图表右边距，可以是负值，单位px。 默认是：0
		        	y: 20, //Number 相对于垂直对齐的偏移量，取值范围：图表的上边距到图表的下边距，可以是负值，单位是px。 默认： 取决于字体的大小。
		        	style: {//标题样式。用于设置文字颜色、字体、字号，但是字体的对齐则使用algin、x和y元素。默认是： { "color": "#333333", "fontSize": "18px" } 默认是：[object Object].
		        		color: '#6D869F',
						fontWeight: 'bold'
		            } 
		        }, 
		        subtitle: { 
		        	align: 'center', //文本水平对齐方式。可选“left”，”center“和“right”。 默认是：center.
		        	floating: false, //Boolean 是否浮动，如果设置为浮动，副标题将不占用图表区的位置。
		            text: '2017年', //图表的副标题文字，默认是空，即默认是没有副标题的。
		        	useHTML: false, //Boolean 标题是否使用HTML渲染，是否解析html标签，设置解析后，可以使用例如 a 等 html 标签      默认false
		        	verticalAlign: '', //文字垂直对齐方式。可选“top”，”middle“和“bottom”。并且当给定一个值后，该标题将表现为浮动。  默认是："" .
		        	x: 0, //Number 相对于水平对齐的偏移量，取值范围为：图表左边距到图表右边距，可以是负值，单位px。 默认是：0
		        	y: 40, //Number 相对于垂直对齐的偏移量，取值范围：图表的上边距到图表的下边距，可以是负值，单位是px。副标题默认是在标题下面的，除非标题是floating属性。 默认是： null.
		        	style: { //文字样式。用于设置文字颜色、字体、字号。当更改margin属性、或者添加position："absolute"，left 和 top 属性的时候，能够取到标题的准确定位。 默认是：[object Object].
		        		color: '#6D869F',
						fontWeight: 'bold'
		            }
		        }, 
		        tooltip: { //数据提示框。当鼠标悬停在某点上时，以框的形式提示该点的数据，比如该点的值，数据单位等。数据提示框内提示的信息完全可以通过格式化函数动态指定。
		        	animation: true,//Boolean 启用或禁用数据提示框提示框的动画效果。在旧版本 IE 浏览器中，动画效果是默认被禁用的。 默认是：true.
		        	backgroundColor: "#D1EEEE",//数据提示框背景颜色，可以是渐变色。 默认是：rgba(255, 255, 255, 0.85)
		        	borderColor: "#EE2C2C",//提示框边框的颜色。当该值为null时，边框会使用该数据列或该点的颜色。 默认是："null"
		        	borderRadius: 10,//Number 数据提示框圆角。 默认是：3
		        	borderWidth: 1,//Number 提示框边框的像素值宽度。 默认是：1
		        	crosshairs: null,/*十字准线。十字准线可以被定义为一个Boolean 值，一组Boolean 值 或 json对象。
		        	为 Boolean时： 如果十字准线选项为true，一条单一的与X轴有关的十字准线将被显示出来。
		        	为一组Boolean时： 在一组Boolean值中，第一个值表示是否与X轴有准线连接，第二个值表示是否与Y轴有准线连接。使用[true, true]可以展现完整的十字准线。
		        	为json 对象时： 对象中包含更详细的属性设置，属性包括 width, color, dashStyle和zIndex，分别代表线条宽度、颜色、演示 及 显示层次。
		        	默认值：Null*/
		        	dateTimeLabelFormats:{ //数据框中的时间点的格式化
		        	    millisecond:"%A, %b %e, %H:%M:%S.%L",
		        	    second:"%A, %b %e, %H:%M:%S",
		        	    minute:"%A, %b %e, %H:%M",
		        	    hour:"%A, %b %e, %H:%M",
		        	    day:"%A, %b %e, %Y",
		        	    week:"Week from %A, %b %e, %Y",
		        	    month:"%B %Y",
		        	    year:"%Y"
		        	},
		        	enabled: true,//Boolean 启用或禁用提示框。 默认是：true
		        	split: true,//分提示为每系列中的一个标签，用头靠近轴。这是建议在共享的工具提示的多线系列图表，通常使它们更容易阅读。默认为false
		        	followPointer: false,//Boolean 当鼠标跨列的时候，提示框是否应该跟随它，扇形和作为其它在一定程度上重要的类型图表。默认情况下，它可以覆盖散点图，气泡图和饼图系列这些图表的plotOptions。 对于使用触摸设备实现这个功能的时候，followTouchMove的值也必须为true
		        	useHTML: true,//Boolean 使用HTML代码渲染提示框的内容用以代替SVG。使用HTML允许高级格式化像在提示框中的表格和图像。
		        	headerFormat: '<span style="font-size: 10px">{point.key}</span><br/>',/*String 提示框中标题行的HTML代码。变量被花括号包起来。可用的变量有point.key, series.name, series.color和其它从点对象point和series 对象中的成员。这point.key变量包含取决于所在轴的分类名，
		        	值或者是日期。就日期轴而言， point.key日期格式能够被设置使用tooltip.xDateFormat。  默认值：<span style="font-size: 10px">{point.key}</span><br/>*/
		        	formatter: null,/*Function 回调函数将格式化提示框中的文本。返回false将为一个特定的点禁用提示框。
	 				一个HTML的子集是被支持的。提示框中的HTML被解析和转换为SVG，因此这不是一个完整的HTML渲染器。下列的标签是被支持的：<b>, <strong>, <i>, <em>, <br/>, <span>.标签直接的内容可以被样式style属性设置样式。但是仅限于文字相关的text-related的CSS样式。
					自从2.1版本以来，提示框能够在多个系列之间通过共享选项来共享。在格式化的可用数据中区别一个字节取决于提示框是否是共享的或者不是共享的。在一个shared提示框中，除X以外的所有属性，一般所有的点都被保存在一个数组中，this.points
					可用的数据有：
					this.percentage (not shared) / this.points[i].percentage (shared)  仅限于堆叠系列和饼图系列。所有点的百分比。
		        	this.point (not shared) / this.points[i].point (shared)  关键的对象。如果被定义，关键的名称是能够通过this.point.name表示。
		        	this.points  在一个共享的提示框中，这是一个包含每个点的全部属性的数组。
		        	this.series (not shared) / this.points[i].series (shared)  系列对象。这个系列的名称可通过this.series.name.显示
		        	this.total (not shared) / this.points[i].total (shared)  仅限于堆叠系列。表示全部在X轴上的值。
		        	this.x  X轴上的值。这个属性同样不考虑提示框是共享的还是不共享的。
		        	this.y (not shared) / this.points[i].y (shared)  Y轴上的值。*/
		        	footerFormat: '<span style="font-size: 10px">这是提示框footer</span>',//String 字符串形式定义提示框中的注脚格式。
		        	pointFormat: '<span style="color:{series.color}">\u25CF</span> {series.name}: <b>{point.y}</b><br/>',/*String 提示框中该点的HTML代码。变量用花括号括起来。可用的变量有point.x, point.y, series.name and series.color和以相同的形式表示的其它属性。
		        	此外，point.y能够被tooltip.yPrefix和tooltip.ySuffix变量所拓展。这同样能够为每一个显示单元进行覆盖。 默认是：<span style="color:{series.color}">\u25CF</span> {series.name}: <b>{point.y}</b><br/>*/
		        	hideDelay: 500,//Number 提示框隐藏延时。当鼠标移出图标后，数据提示框会在设定的延迟时间后消失。 默认是：500.
		        	positioner: null,/*function(labelWidth,labelHeight,point){ console.log(labelWidth+"---"+labelHeight+"--"+point); return { x: 100, y: 100 }; },
		        	Function 把提示框放置在一个默认位置的回调函数。此回调接受三个参数: labelWidth,labelHeight和point包含的值对于plotX和plotY将告诉你参考点在绘图区上的位置。
		        	添加chart.plotLeft和chart.plotTop以获取精确的坐标点。 返回值应该是一个包含X和Y值的对象，比如: { x: 100, y: 100 }。*/
		        	shared: false,//Boolean 当提示框被共享时，整个绘图区都将捕捉鼠标指针的移动。提示框文本显示有序数据(不包括饼图，散点图和标志图(flag)等)的系列类型将被显示在单一的气泡中。推荐在单一系列的图表和平板/手机优化的图表中使用。
		        	snap: 10,//Number 相邻单元的图像或单点。不应用于条形图(bars)，柱状图(columns)和扇形图(pie slices). 在鼠标操作的设备上默认为10，在触摸设备上默认为25。
		        	valueDecimals:null,//Number 数据提示框数据值小数保留位数。默认为保留所有小数。
		        	valuePrefix: '',//String 一串字符被前置在每个Y轴的值之前。可重写在每个系列的提示框选项的对象上。
		        	valueSuffix: ' (°C)',//String 一串字符被后置在每个Y轴的值之后。可重写在每个系列的提示框选项的对象上。
		        	xDateFormat: '',//String 如果X轴是时间轴,格式化提示框标题中的日期。默认值是根据图表中的点之间的最小距离的最佳猜测。
		        	pointFormatter: null,//function() { return 'u25CF {'+ this.series.name+ '}: {' + this.y + '} .' },//pointFormat 更简单，适用于简单的内容格式化 pointFormatter 更灵活，适用于相对复杂的自定义内容
		        	shadow: false,//Boolean 是否启用提示框的阴影。 默认是：true
		        	style: {//CSSObject 为提示框添加CSS样式。提示框同样能够通过CSS类.highcharts-tooltip来设定样式。
			        	color: '#333333',
			        	fontSize: '12px',
			        	padding: '8px'
		        	} 
		        },
		        xAxis: {  //x轴 
		            categories: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'], //x轴  类别名称
					allowDecimals: true,//Boolean 坐标轴刻度值是否允许为小数；比如统计一个网站的访客数或点击量时，坐标轴刻度值一定不能是小数。 默认是：true
					//alternateGridColor: '#FDFFD5',//Color 相间的网格列颜色。当设置了此属性，网格中会隔列显示该颜色；
					ceiling: null,//Number 允许最高的自动计算的坐标轴刻度极端值
					floor: null,//Number 允许最低的自动计算的坐标轴刻度极端值。 默认是："null"
					dateTimeLabelFormats: null,//Object 日期标签格式；对于时间轴来说，标尺会根据合适的单位自动计算。 { millisecond: '%H:%M:%S.%L', second: '%H:%M:%S', minute: '%H:%M', hour: '%H:%M', day: '%e. %b', week: '%e. %b', month: '%b \'%y', year: '%Y' }
					endOnTick: true,//Boolean 结束于标线；是否强制轴线在标线处结束。使用此属性与maxPadding 属性来控制。	
					gridLineColor: '#C0C0C0',//Color 网格线的颜色 默认是：#C0C0C0.
					gridLineDashStyle: 'Solid',//String 网格线的线条风格样式，可设置的值请看 Highcharts线条样式，以上样式同样适用于图表中其他线条。 默认是：Solid
					gridLineWidth: 0, //网格线的宽度   默认是：0
					gridZIndex: 1,//Number 网格线的z轴方向上的深度 默认是：1
					id: 'x-axis',//String 轴的id。可以在图表渲染后，通过chart.get()获得
					labels: {//轴标签（显示在刻度上的数值或者分类名称）
						align:'left',//String 轴标签的水平对其方式，可取的值："left", "center" or "right".默认是居中显示 默认是：center
						distance: 15,//Number 只使用在极区图中。表示轴标签距绘图区边界的距离，单位是px. 默认是：15
						format: '{value} km',//轴标签的format string 默认是：{value}
						enabled: false,//Boolean 启用或者禁用轴标签 默认是：true
						maxStaggerLines: 5,//Number 仅在水平轴使用。当没有设置staggerLines，maxStaggerLines限定用多少行来显示轴轴标签自动地的避免某些标签的重叠。设置为1表示禁用重叠检测。 默认是：5.
						rotation: 90,//Number 轴标签的旋转角度 默认是：0
						staggerLines: null,//Number 水平轴标签显示的行数。当轴标签内容过多时，可以通过该属性控制显示的行数
						step: 1,//Number 轴标签显示间隔数。 默认情况下，该间隔数是自动计算的以避免轴标签重叠。为了防止这种情况，将其设置为1。这通常发生类别轴上，也往往是你选择了错误的轴类型的标志。
						useHTML: true,//Boolean 是否use HTML渲染标签
						x: 0,//Number 轴标签相对于轴刻度在水平方向上的偏移量 默认是：0
						y: null,//Number 轴标签相对于轴刻度在y轴方向上的偏移量，默认根据轴标签字体大小给予适当的值 默认是："null"
						zIndex: 7,//Number 轴标签的在z轴方向上的深度 默认是：7
						formatter: function() {//Function 回调javascript函数来格式化标签，值通过this.value获得，this的其他属性还包括axis, chart, isFirst and isLast. 默认为:
							return this.value;
						},
						style: {//CSSObject 设置标签的样式；设置whiteSpace: 'nowrap'避免分类名称折行；默认为：{color: '#6D869F', fontWeight: 'bold'}
							color: '#6D869F',
							fontWeight: 'bold'
						}
					},
					lineColor: '#C0D0E0',//Color 轴线的颜色 默认是：#C0D0E0
		            lineWidth: 2,//轴线的宽度 默认是：1
		            linkedTo: null,//Number 指向本轴的另一个轴的索引。当一个轴指向主轴时，它将有和主轴一样的极端值，但是通过min，max或setExtremes可以更改。它也可以用来显示附加的信息，或者通过标尺来扩展图表的显示。
		            max: null,//Number 轴的最大值。如果是null，最大值被自动计算。如果code>endOnTick选项是true，max的值可能会被四舍五入。实际的最大值也会受chart.alignTicks影响。
		            maxPadding: 0.01,//Number 内边距的最大值。与该条轴线长度的有关。内边距设置为0.05相对于100px的轴线是5px。当你不想要最高值出现在绘图区域的边缘时这个非常有用。当轴线设置了max或一个最大极值已经在axis.setExtremes()设置，这个最大内边距将会被忽略。 默认是：0.01
		            min: null,//Number 轴的最小值。如果是null，最小值被自动计算。如果startOnTick选项是true，min的值可能会被四舍五入
		            minPadding: 0.01,//Number 内边距的最小值。与该条轴线长度的有关。内边距设置为0.05相对于100px的轴线是5px。当你不想要最低值出现在绘图区域的边缘时这个非常有用。当轴线设置了min或一个最小极值已经在axis.setExtremes()设置，这个最小内边距将会被忽略。 默认是：0.01
		            minRange: null,/*Number 显示该轴的最小范围。整个轴将不被允许显示比之更小的跨度范围。例如：一个时间轴的单位是毫秒，如果minRange设置为3600000，你将不能放大至比1小时更小的范围。
		          	默认x轴上的最小范围默认值是5倍的数据点间的最小间隔。 在一个对数轴上，minRange的单位为幂(指数级)。所以minRange为1代表着可以放大为10-100, 100-1000, 1000-10000等*/
		          	minTickInterval: null,//Number 坐标轴的值允许的最小刻度间隔。比如缩放轴用来显示每天的数据时可以用来阻止轴上显示小时的时间
		          	minorGridLineColor: '#E0E0E0',//Color 次级网格线的颜色 默认是：#E0E0E0
		          	minorGridLineDashStyle: 'Solid',//String 次级网格线的风格，网格线的线条风格样式，可设置的值请看 Highcharts线条样式，以上样式同样适用于图表中其他线条。 默认是：Solid
		          	minorGridLineWidth: 1,//Number 次级网格线的宽度 默认是：1
		          	minorTickColor: '#A0A0A0',//Color 次级刻度线的颜色 默认是：#A0A0A0
		          	minorTickInterval: null,/*Number 次刻度线的间隔。在一个直线轴中，如果设置为"auto"，次刻度间隔计算为刻度线间隔的五分之一。如果设置为null，次刻度刻度线不显示。
		          	在对数坐标轴中，单位为幂(指数级)。例如，minorTickInterval设置为1在0.1和1，1和10，10和100之间显示一个次级刻度，minorTickInterval设置为0.1，
		          	在刻度1和10，10和100之间会产生9个次级刻度，设置为“自动”，每个刻度之间大约是5个次级刻度 ,在轴线上使用categories, 次级刻度线是不支持的。*/
		          	minorTickLength: 2,//Number 次级刻度线的长度 默认是：2
		          	minorTickPosition: 'outside',//String 次级刻度线相对于轴线的位置，可取值为：inside和outside 默认是：outside
		          	minorTickWidth: 0,//Number 次级刻度线的宽度 默认是：0
		          	offset: 0,//Number 标题到轴线的距离；默认情况下，这个距离是标题外边距与轴标签宽度之和。如果设置了offset,它将覆盖这个默认的值。 默认是：0
		          	opposite: false,//Boolean 是否在正常显示的对立面显示轴。正常是垂直坐标轴显示在左边，水平坐标轴显示在底部，因此对立面就是垂直坐标轴显示在右边和水平坐标轴显示在顶部，这通常用于有两个或多个坐标轴
		          	plotBands: [{//通过彩色带横贯在绘图区域上做成的表示在轴线上的间距。 在仪表图中，y轴（数据轴）上的区域带会沿着仪表图的周长伸展。
		          		borderWidth: 10,//Number 区域划分带边框宽度   默认是：0
		          		borderColor: null,//Color  区域划分带边框颜色   默认是："null"
		          		color: '#FCFFC5',//Color 区域划分带的颜色
		          		from: 0,//Number 区域划分带在轴上的起始位置。
		          		to: 0,//Number 区域划分带在轴上的结束位置
		          		id: '',//String 区域划分带的id,一般在Axis.removePlotBand中起识别作用
		          		zIndex: 1,//Number 区域划分带在z轴方向上的深度
		          		label: {//区域带的文本标签
		          			align:'center',//String 区域划分带文本标签的水平对齐方式，可以取的值：’left’，’center’，’right’ 默认是：center
							rotation: 0,//Number 区域划分带的文本标签的旋转角度 默认是：0
							text: '这是区域划分带',//String 区域划分带的标签文本，支持html文本
							textAlign: 'center',//String 区域划分带标签文本的对齐方式。align 决定了文本标签在区域划分带中的对其方式，textAlign决定了标签文本针对其标签的对齐方式。可能的值是“left”，“center”，“right”。默认与align一样
							useHTML: true,//Boolean 是否use HTML渲染标签
							verticalAlign: 'top',//String 区域划分带文本标签相对于区域划分带在垂直方向上的对齐方式，可以取的值：’top’,’middle’,’bottom’ 默认是：top
							x: 0,//Number 相对于标签水平对齐位置的x轴偏移量
							y: 100,//Number 轴标签相对于轴刻度在y轴方向上的偏移量
							style: {//CSSObject 区域划分带的文本标签的样式
								color: '#6D869F',
								fontWeight: 'bold'
							}
		          		}
		          	}],
		          	plotLines: [{//通过颜色线横贯在绘图区域上标记轴中的一个特定值
		          		color: '#6D869F',//Color 区域划分线的颜色
		          		dashStyle: 'Solid',//String 区域划分线的风格,可能的值请参考this overview 默认是：Solid.
		          		events: {//Object 区域划分线的鼠标事件。支持的属性click, mouseover,mouseout, mousemove
		          			click: function () {
		                        alert("click");
		                    },
		                    mouseover: function () {
		                    	//alert("mouseover");
		                    },
		                    mouseout: function () {
		                    	//alert("mouseout");
		                    }
		          		},
		          		id: '',//String 区域划分线的id,一般在Axis.removePlotBand中起识别作用
		          		label: null,//区域化分线的文本标签  （ 跟 plotBands属性一样）
		          		value: 8,//Number 区域划分线的值 
		          		width: 5,//Number 区域划分线宽度
		          		zIndex: 1//Number 区域划分线在z轴方向上的深度
		          	}],
		          	reversed: false,//Boolean 是否逆转轴，使得最高数最靠近原点。如果图表倒置，x轴默认是逆转的
		          	showEmpty: true,//Boolean 当坐标轴没有数据时是否显示轴线和标题。 默认是：true
		          	showFirstLabel: true,//Boolean 是否显示第一个轴标签 默认是：true
		          	showLastLabel: true,//Boolean 是否显示最后一个轴标签 默认是：true
		          	startOfWeek: 1,//Number 对于时间轴，这个属性决定将星期几作为一周的开始。 0代表星期日，1代表星期一。 默认是：1
		          	startOnTick: true,//Boolean 是否强制轴线在标线处开始。使用此选项与maxPadding来控制。
		          	tickAmount: 8,//Number 在轴上绘制的刻度。这开辟了多个图表或调整窗格的xAxis图。此选项将覆盖tickpixelinterval选项。 此选项只对线性轴有影响.。DateTime，对数或类别轴不受影响。
		          	tickColor: '#C0D0E0',//Color 刻度线的颜色 默认是：#C0D0E0
		          	tickInterval: null,/*Number 坐标轴上的刻度线的单位间隔。当值为null时，刻度线间隔是根据近似于线性的(tickPixelInterval)计算的。在分类轴上，一个null的刻度间隔，默认为1，即1个类目。
		          	要注意的是，时间轴是根据毫秒来计算的，例如一天的间隔表示为24 * 3600 * 1000。 在对数轴上，刻度线间隔按指数幂来算，刻度线间隔为1时，在刻度上的每个值为0.1, 1, 10, 100等。 
		          	刻度间隔为2时，在刻度上的每个值为0.1, 10, 1000等。 刻度间隔为0.2时，在刻度上的值为: 0.1, 0.2, 0.4, 0.6, 0.8, 1, 2, 4, 6, 8, 10, 20, 40等*/
		          	tickLength: 10,//Number 刻度线的长度 默认是：10
		          	tickPixelInterval: null,//Number 坐标轴上的刻度值的单位间隔
		          	tickPosition: 'outside',//String 刻度线相对于轴线的位置，可以取的值为inside 和 outside 默认是：outside
		          	tickPositioner: null,//Function 返回定义刻度线在坐标轴上分布的数组的回调函数。这将覆盖tickPixelInterval和tickInterval的默认行为
		          	tickPositions: null,//Array<Number> 一个数组，定义蜱在轴上的位置.。这tickpixelinterval和tickinterval重写默认行为
		          	tickWidth: 1,//Number 刻度线的宽度 默认是：1
		          	tickmarkPlacement: 'between',//String 仅适用于类别轴。如果设置为on刻度线位于在类别名称的中心，如果设置为between刻度线位于类别名称之间。如果刻度线间隔数为1，其默认值是between，否则默认只是on 默认是："null"
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
		          	type: 'linear',/*String 坐标轴的类型。可以是"linear(线性轴。默认类型，x轴按照Axis.tickInterval值增长，y轴默认是自适应)", "logarithmic(对数轴。按照数学中的对数增长，例如1,2,4,8... 用的不多，主要用于对数图表)", 
		          	"datetime(时间轴。时间使用和Javascript 日期对象一样，即用一个距1970年1月1日0时0分0秒的毫秒数表示时间，也就是时间戳)" 或者 "category"之一。在时间轴中，坐标轴的值是以毫秒为单位的，
		          	刻度线上显示像整数的小时或天的适当值。在类别轴中，默认采用图表数据点的名称做分类名称，如果定义类别名称数组可覆盖默认名称。 默认是：linear*/
		          	/*breaks: [{//义坐标轴的间隔部分的数组。该部分的数据节点将被忽略，不在图表中显示。实现该功能需要加载模块broken-axis.js
		          		breakSize: null,//Number 设置间隔部分在坐标轴上所占的空间。 默认是：0
		          		from: null,//Number 设置间隔部分的起始刻度值
		          		to: null,//Number 设置间隔部分结束位置的刻度值。
		          		repeat: null//Number 以当前间隔部分的起始刻度为起点，设置当前间隔部分重复出现的间距。 默认是：0
		          	}],*/
		          	labels:{y:26}  //x轴标签位置：距X轴下方26像素 
		        }, 
		        yAxis: {  //y轴 
		            title: {text: '平均气温(°C)'}, //标题 
		            lineWidth: 2 //基线宽度 
		            //yAxis轴其余属性跟xAxis轴属性基本一致
		        }, 
		        plotOptions:{ //设置数据点 
		            line:{ 
		                dataLabels:{ 
		                    enabled:true  //在数据点上显示对应的数据值 
		                }, 
		                enableMouseTracking: true //允许鼠标滑向触发提示框 
		            } 
		        }, 
		        legend: {  //图例 
		            layout: 'vertical',  //String 图例数据项的布局。布局类型：水平或垂直。默认是：水平 (horizontal)   水平（horizontal）/垂直（vertical） 
		            backgroundColor: '#ffc', //Color 图例容器的背景颜色
		            align: 'left', //String 图例容器（中的图例）水平对齐在图表区，合法值有"left", "center" 和 "right". 默认是： center. 默认是：center
		            borderColor: '#909090',//Color 图例容器的边框颜色，默认是： #909090. 默认是：#909090
		            borderRadius: 0,//Number 图例容器的边框圆角，默认是：0 默认是：0
		            borderWidth: 0,//Number 图例容器的边框宽度，默认是：0. 默认是：0
		            enabled: true,//Boolean 图例开关。 默认是：true
		            floating: true,//Boolean 图例容器是否可以浮动，当此值设置为false时，图例是不可在数据区域图之上，它们是不可重叠的，而设成true，则可。默认是： false.
		            itemDistance: 20,//Number 当图例容器中的图例是水平布局时，这个属性定义了它们之间的距离，单位为像素，默认是： 20
		            itemHiddenStyle: {//CSSObject 当点击图例进行隐藏时，CSS样式可以应用到图例容器中每个图例，它仅支持部分CSS，尤其对于文本样式，style内容能被很好的继承除非要重写，默认样式：itemHiddenStyle: { color: '#CCC' }
		            	color: '#CCC'
		            },
		            itemHoverStyle: {//CSSObject 当图例悬浮时的样式，它仅支持部分CSS，尤其对于文本样式，style内容能被很好的继承除非要重写，默认: itemHoverStyle: { color: '#000' }
		            	color: '#000' 
		            },
		            itemMarginBottom: 0,//Number 图例的每一项的底部外边距，单位px，默认值：0 
		            itemMarginTop: 0,//Number 图例的每一项的顶部外边距，单位px，默认值：0 
		            itemStyle: {//CSSObject 每个图例项的样式，默认：itemStyle: { cursor: 'pointer', color: '#3E576F' } 默认是：[object Object]
		            	cursor: 'pointer', 
		            	color: '#3E576F' 
		            },
		            itemWidth: null,//Number 每个图例项的宽度。当图例有很多图例项，并且用户想要这些图例项在同一平面内垂直对齐，此时这个属性可帮用户实现此效果
		            labelFormat: '{name}',//String 每个图例标签的格式化字符串。此属性可引用在数列或者饼图节点对象中变量。 默认是：{name}
		            labelFormatter: function(){//Function 每个图例标签的格式化的回调函数。不能跟labelFormat一起用,这个this.关键字是指series对象(的属性),或者是饼图扇形数据节点。默认的是series或者数据列的name属性将被输出。
		            	 return this.name + ' (click to hide)';
		            },
		            lineHeight: 16,// Number 图例项行高。2.1版本后已经废弃，取而代之的是可在itemStyle设置行高。图例各项行高和内边距可用itemMarginTop 和 itemMarginBottom来设置。默认是：16.单位：px 默认是：16
		            margin: 15,//Number 整个图例区的外边距。如果整个图型区的大小是自动计算得出并且图例不浮动，那么图例边距的空间是指整个图例与坐标轴标签或者图形区之间的距离。默认值是：15 默认是：15
		            maxHeight: 100,//Number 图例的最大高度。当超出最大高度，此时导航将显示
		            navigation: {
		            	activeColor: '#3E576F',//Color 激活(箭头)颜色。在图例的导航页，激活的上箭头或者下箭头颜色。默认是： #3E576F
		            	animation: true,//Boolean|Object 当点击图例的导航上下按钮时，触发的动画效果。默认的情况此属性设置为true，额外的属性设置可封装在对象中，此对象包含easing 和 duration。默认是： true 
		            	arrowSize: 12,//Number 图例导航按钮的大小，默认是： 12.单位像素 
		            	inactiveColor: '#CCC',//Color 图例导航按钮未激活颜色。默认是： #CCC
		            	style: {//CSSObject 图例导航文本样式
		            		fontWeight: 'bold',
		                    color: '#333',
		                    fontSize: '12px'
		            	}
		            },
		            padding: 8,//Number 内边距   默认是：8
		            reversed: false,//Boolean  倒转。默认是： false
		            rtl: false,//Boolean 图例符号是否在文本右边。默认是： false
		            shadow: true,//Boolean|Object 图例投影。当（用户想）应用投影到图例中时，只有backgroundColor也得应用到图例中，投影的效果才能生效。自2.3版本以后阴影能作为一个对象来配置，里面的属性有color, offsetX, offsetY, opacity 和 width. 默认是： false
		            symbolHeight: 12,//Number 图标(图例中的符号)高度。默认是： 12
		            symbolPadding: 5,//Number 图标和图例中的文本之间的距离。默认是： 5.单位：px 
		            symbolRadius: 2,//Number 当图例是用矩形包裹时，图标的边框半径。默认是： 2
		            symbolWidth: 16,//Number 图标宽度。默认是： 16  单位：px 
		            title: {//图例上方的标题
		            	text: '这是图例的标题',//String 标题可以是文本或者HTML字符串。 默认是："null"
		            	style: {//CSSObject 图例上方的标题的样式。默认: style: { fontWeight: 'bold' }
		            		color: '#6D869F',
							fontWeight: 'bold'
		            	}
		            },
		            useHTML: false,//Boolean 是否用HTML对于图例各项的文本。当用HTML时就不能再用图例导航
		            verticalAlign: 'top',//String 垂直对齐。能取"top", "middle" or "bottom"之一。垂直对齐的位置可通过Y设置进一步调整它的位置。 默认是：bottom
		            width: null,//Number 图例容器的宽度
		            x: 100,//Number 整个图例Ｘ轴偏移量，它是相对于水平布局定下后，chart.spacingLeft 和 chart.spacingRight.的空间左右移动，当ｘ值为负值时，图例朝左移动；正值时，图例朝右移动。 默认是：0
		            y: 70//Number 整个图例垂直偏移量，它是相对于垂直布局定下后，chart.spacingTop 和 chart.spacingBottom的空间垂直移动，当y值为负值时，图例朝上移动；正值时，图例朝下移动。 默认是：0
		        },
		        labels: {//可以放置在图表中任意位置的Html文字标签
		        	style:{//文字标签的CSS样式，可用的属性有 color, fontSize, fontWeight, fontFamily 等和文字相关的Css属性，可以通过设置 left 和 top 来对其定位，实例代码
		                color:"#ff0000"
		            },
		            items:[{
		                html:'<a href="javascript:void(0)" target="_blank">谭志杰</a>',//String 标签的html代码或者文字
		                style: {//文字标签的CSS样式，可用的属性有 color, fontSize, fontWeight, fontFamily 等和文字相关的Css属性，可以通过设置 left 和 top 来对其定位，实例代码
		                    left: '750px',
		                    top: '50px',
		                    fontSize: '18px',
		                    fontWeight:'bold',
		                    fontFamily:'微软雅黑'
		                }
		            },{
		                html:'<a href="javascript:void(0)" target="_blank">最终版权</a>',
		                style: { 
		                    left: '450px',
		                    top: '300px',
		                    color:'#006cee',
		                    fontSize:'18px',
		                    fontWeight:'bold',
		                    fontFamily:'微软雅黑'
		                }
		            }]
		        },
		        navigation: {//显示在导出模块中的按钮和菜单的选项集合
		        	buttonOptions: {//导出模块中显示的按钮的选项集合
		        		enabled: true,//Boolean 是否启用模板功能 默认是：true
		        		text: '菜单',//String 默认是：null
		        		menuStyle: {//CSSObject 默认情况下，单击导出图标时弹出菜单的CSS样式。 此菜单以HTML形式呈现。 默认是：{ "border": "1px solid #999999", "background": "#ffffff", "padding": "5px 0" }
		        			border: "1px solid #999999", 
		        			background: "#FF0000", 
		        			padding: "5px 0"
		                },
		                menuItemStyle: {//CSSObject CSS样式的个别项目，在弹出菜单中出现的默认情况下，当出口点击图标。菜单项呈现为HTML 默认是：{ "padding": "0.5em 1em", "color": "#333333", "background": "none" }
		                	"padding": "0.5em 1em", 
		                	"color": "#333333", 
		                	"background": "none" 
		                },
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
		                },
		                height: 20,//Number 按钮的像素高度   默认是：20
		                symbolFill: '#666666',//Color 为按钮内的符号填充颜色   默认是：#666666
		                symbolStroke: '#666666',//Color 符号的笔划或线条的颜色   默认是：#666666
		                symbolSize: 20,//按钮上符号的像素大小   默认是：14
		                symbolX: 16,//按钮内符号中心的x位置   默认是12.5
		                symbolY: 14,//按钮内符号中心的y位置  默认是10.5
		                symbolStrokeWidth: 2,//按钮上符号的像素笔划宽度  Number 默认是1
		        		verticalAlign: 'top',//String 按钮的垂直对齐。 可以是 “top”，“middle” 或 “bottom” 之一。 默认是：顶对齐
		        		width: 24,//Number 按钮的像素宽度。 默认是：24
		        		x: -45,//按钮位置相对于x轴水平偏移量   Number
		        		y: 30 //按钮位置相对于y轴垂直对齐的垂直偏移量   Number 默认是：0
		        	}
		        },
		        exporting: { 
		        	allowHTML: false,//Boolean 实验环境下允许在导出的图表中存在HTML的(通过useHTML选项来设置)。这个功能让你在导出的图表中能保存复杂的HTML结构，比如表单或者双向文本
		        	chartOptions: null,//Object 额外的图表选项将会被合并到可导出的图表中。一个常见的用例：通过添加数据标签用来提高图表的可读性，或者添加一个打印专用颜色方案。 默认是：null
		        	fallbackToExportServer: true,//Boolean 当在客户端离线导出模块功能不可用的情况下，可以设置是否回调到导出服务器。 默认是：true
		        	filename: 'chart',//String 用来导出图表不含拓展名称的文件名。 默认是：chart
		        	formAttributes: null,//Object 这个对象包含了向导出服务器发送SVG数据表单中所含的额外属性。比如，一个 target属性可以用来设置确保生成的图片在另一个frame能被接收到，也可以通过自定义enctype和encoding标签
		        	libURL: 'https://code.highcharts.com/{version}/lib',//String 这个属性表示：在导出图片时，程序会试图通过这个链接去加载window对象中不存在的依赖。当前版本默认应该指向CanVG 库, RGBColor.js, jsPDF 和svg2pdf.js,而且在某些浏览器的客户端中这个选项是必须的。 默认是：https://code.highcharts.com/{version}/lib.
		        	printMaxWidth: 780,//Number 当从图表菜单中打印图表时，如果屏幕上的图表超过了打印宽度，图表将会被调整，打印完毕或取消打印会重置回来。默认的宽度填充慢纸张宽度。注意，当将网页作为整体打印时将不会影响图表的宽度。 默认是：780
		        	scale: 2,//Number 定义屏幕显示效果和导出的缩放比例。比如一个600px款的图表在网页上看起来很舒服，但是打印出来简直丑翔。默认的情况下是放大2倍，也就是导出的图片尺寸为 1200px。 默认是：2
		        	sourceWidth: null,//Number 除非有一个明确的chart.width被设置了，否则这个值就是导出时图表的宽度。 导出的栅格图像将会按scale属性的倍数放大
		        	sourceHeight: null,//Number 和 原宽度类似
		        	type: 'image/png',//String 调用 chart.exportChart()的时指定导出图片或文件的 MIME 类型。 可选的值有 image/png，image/jpeg，application/pdf 和 image/svg+xml。 默认是：image/png
		        	url: 'https://export.highcharts.com',//String 指定导出服务器地址，默认是调用 Highcharts 官方提供的导出服务器。 默认是：https://export.highcharts.com
		        	width: undefined,//Number 图表导出的 PNG 或者 JPG 的像素宽度。从 Highcharts 3.0 起, 默认的像素高度是随着 chart.width 或者 exporting.sourceWidth 和 exporting.scale三个属性而变的。 默认是：undefined
		        	buttons: {//导出功能相关按钮的选项，包含打印和导出按钮。除了默认按钮，我们也可以添加自定义的按钮。可以参照 navigation.buttonOptions 参数中额外的选项。
		        		contextButton: {//导出按钮的配置，可以在这个配置下面增加自定义按钮
		        			align: 'right',//String 按钮的对齐方式 默认是：right
		        			enabled: true,//Boolean 是否启用按钮功能 默认是：true
		        			height: 20,//Number 按钮的像素高度。 默认是：20
		        			/* menuItems: Array<Object> 一个菜单项的配置选项集合。每个选项都是由一个显示为文本的text选项和点击回调函数onclick组成的。 菜单项是可以通过定义一个新的数组和赋值 null 来覆盖不想展示的位置
		        			[{    text: '导出固定大小(small)',
		                        onclick: function () {
		                            this.exportChart({
		                                width: 950
		                            });
		                        }
		                    }, {
		                        text: '导出PNG(large)',
		                        onclick: function () {
		                            this.exportChart();
		                        },
		                        separator: false
		                    }], */
		                    onclick: undefined,//点击事件 
		                    symbol: 'menu',//String  定义按钮的符号样式。 指向一个已经在Highcharts.Renderer.symbols集合中定义了的函数。 默认的exportIcon函数已经包含在导出模块中了。 默认是：menu
	                    	symbolFill: '#666666',//Color 为按钮内的符号填充颜色   默认是：#666666
			                symbolStroke: '#666666',//Color 符号的边框或线条的颜色   默认是：#666666
			                symbolSize: 20,//符号的像素大小   默认是：14
			                symbolX: 16,//符号中心的x位置   默认是12.5
			                symbolY: 14,//符号中心的y位置  默认是10.5
			                symbolStrokeWidth: 2,//符号的像素笔划宽度  Number 默认是1
			        		verticalAlign: 'top',//String 按钮的垂直对齐。 可以是 “top”，“middle” 或 “bottom” 之一。 默认是：顶对齐
			        		width: 24,//Number 按钮的像素宽度。 默认是：24
			        		x: -35,//按钮相对于align选项的水平位置   Number 默认是：-10
			        		y: 30 //相对于verticalAlign选项的垂直偏移量   Number 默认是：0
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
			        		y: 30 //相对于verticalAlign选项的垂直偏移量   Number 默认是：0
		                    // 默认菜单项
		                    //menuItems: Highcharts.getOptions().exporting.buttons.contextButton.menuItems.splice(2)
		                },
		                printButton: {
		                    text: '打印',
		                    onclick: function () {
		                        this.print();
		                    },
			                x: -160,//按钮相对于align选项的水平位置   Number 默认是：-10
			        		y: 30 //相对于verticalAlign选项的垂直偏移量   Number 默认是：0
		                }
		        	},
		            enabled: true,  //是否启用导出模块。禁用该模块将会隐藏菜单按钮，但是 API 的导出相关方法还是可用的。 默认是：true
		            error: undefined//Function 如果客户端的离线导出模块导出图表失败时，这个函数将会被调用，并且回退到导出服务器功能将会失效。如果未定义，将会抛出一个异常。 默认是：undefined
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
		        series: [
		        { 
		        	allowPointSelect: true,//Boolean 单击“标记”、“条形”或“饼状”切片可选择此系列“点”  默认false
		        	animation: true,/*Boolean 启用或禁用初始动画时显示的系列。动画也可以设置为配置对象.。请注意，此选项只适用于该系列本身的初始动画。其他的动画，看到chart.animation和API方法下的动画参数。下面的属性支持
		        	期间:动画的持续时间以毫秒为单位。      宽松:对数学对象设置的宽松函数的字符串引用.。看到宽松的演示。 由于性能不佳，动画被禁用在旧的IE浏览器的列图表和极图     默认为true*/
		        	animationLimit: null,//Number 对于一些系列，有一个限制，关闭初始动画默认情况下，当总点数的图表太高。例如，对于列图表及其衍生工具，如果超过250点，动画就不会运行。要禁用此，设置animationlimit无限集
		        	className: null,//String 要应用于该系列图形元素的类名
		        	color: '#CD0000',//Color 主色或系列
		        	connectEnds: true,//Boolean 只有极坐标图。是否连接一个线路系列两端的极端。默认为true
		        	connectNulls: false,//Boolean 是否连接图行跨越空点。默认为false
		        	cropThreshold: 300,//Number 当该系列包含较少的点比作物阈值，所有点绘制，即使点落在可见的绘图区在当前缩放。绘制所有点（包括标记和列）的优点是在更新时执行动画.。另一方面，当该系列包含更多的点比作物的门槛，系列数据裁剪只包含点内的情节区。裁剪不可见点的优点是大批量提高性能.。默认值为300
		        	cursor: '',//String 您可以将光标设置为“指针”，如果您有附加到该系列的单击事件，向用户发送点和线可以单击的信号。
		        	dataLabels: {//选项的序列数据标签，出现在每个数据点旁边
		        		shadow: true,//Boolean 盒子的影子。最好用带或背景颜色。 默认为false
		        		align: 'center',//String 数据标签与点的对齐方式  "left", "center" or "right" 默认为center
		        		allowOverlap: false,//Boolean是否允许数据标签重叠。使标签不敏感的datalabels.padding重叠，可以设置为0。默认为false
		        		backgroundColor: undefined,//Color 数据标签的背景颜色或渐变。默认为undefined
		        		borderColor: undefined,//Color 数据标签的边框颜色。默认为undefined
		        		borderRadius: 0,//Number 数据标记的像素的边框半径。默认值为0
		        		borderWidth: 0,//Number 数据标签的边框宽度为像素。默认值为0
		        		className: null,//String 数据标签的类名称。特别是在风格模式，这可以用来给每个系列或点的数据标签独特的造型。除此选项外，还添加默认颜色类名，以便我们可以给标签添加对比文本阴影.
		        		color: null,//Color 数据标签的文本颜色。默认值为空
		        		crop: true,//Boolean 是否隐藏区域外的数据标签。默认情况下，数据标签根据溢出选项在绘图区域内移动.。默认为true
		        		defer: true,//Boolean 是否推迟显示数据标签，直到初始系列动画完成。默认为true
		        		enabled: true,//Boolean 启用或禁用数据标签。默认为false
		        		format: '{y}°C',//String 用于数据标签的格式字符串。可用的变量是相同的格式化程序。默认为{y}
		        		formatter: undefined,//Function 回调JavaScript函数格式数据标签    可用的数据  this.percentage  this.point  this.series  this.total  this.x  this.y
		        		inside: false,//Boolean 对于具有一定程度的点，如列，是否将数据标签对齐到框内或实际值点.。默认为false在大多数情况下，真正的堆叠列
		        		overflow: 'justify',//String 如何处理区域外的数据标签。默认为对齐，将它们对齐在绘图区域内
		        		padding: 5,//Number 当带或背景颜色的设置，这是包装盒内的填充。默认值为5
		        		rotation: 0,//Number 文本旋转度。请注意，由于一个更复杂的结构，背景，边框和填充将丢失在旋转的数据标签上.。默认值为0
		        		useHTML: false,//Boolean 是否使用渲染的HTML标签。缺省为false
		        		//verticalAlign: 'top',//String 数据标签的垂直对齐。可以是top, middle or bottom的一个。默认值取决于数据
		        		x: 0,//标签相对于该点的x位置偏移量。默认值为0
		        		y: -6//标签相对于该点的y位置偏移量。默认值为-6
		        	},
		        	description: '',//描述
		        	enableMouseTracking: true,//Boolean 启用或禁用特定系列的鼠标跟踪。这包括点提示，点击事件图和分。对于大型数据集，它提高了性能。默认为true
		        	//keys: ['name', 'y', 'sliced', 'selected'],//Array<String> 一个数组，指定哪些选项映射到数据点数组中的哪个键.。这使得与来自不同来源的非结构化数据数组一起工作变得方便
		        	legendIndex: 1,//Number 系列的顺序索引
		        	lineWidth: 2,//Number 图形线的像素。默认值为2
		        	linecap: 'round',//String 用于线端和线联接的线帽   默认为round(圆)
		        	marker: {
		        		enabled: true,//Boolean 启用或禁用点标记。如果false，标记隐藏时，数据是密集的，并显示更广泛的数据点。默认值为false
		        		fillColor: '#CD0000',//Color 点标记的填充颜色。当NULL，该系列'或点的颜色使用
		        		height: null,//Number 仅图像标记。显式设置图像宽度。使用此选项时，还必须设置宽度。默认值为空
		        		width: null,//Number 仅图像标记。显式设置图像宽度。使用此选项时，还必须设置高度。默认值为空
		        		lineColor: '#ffffff',//Color 点标记轮廓的颜色。当NULL，该系列'或点的颜色使用。默认#ffffff
		        		lineWidth: 0,//Number 点标记轮廓的宽度。默认值为0
		        		radius: 4,//Number 点标记的半径。默认值为4
		        		symbol: 'circle'//String 标记的预定义形状或符号。可取值"circle圆", "square正方形", "diamond菱形", "triangle三角形" and "triangle-down三角形向下"
		        	},
		        	negativeColor: null,//Color 图的部分或低于阈值的点的颜色.。默认值为空
		        	point: {//每一点的属性
		        		events: {
		        			click: function(){
		        				alert('Category: ' + this.category + ', value: ' + this.y);
		        			}
		        			//mouseOut: Function
		        			//mouseOver: Function
		        			//remove: Function
		        			//select: Function
		        			//unselect: Function
		        			//update: Function
		        		}
		        	},
		        	shadow: false,//Boolean|Object 是否向图形线应用阴影。自从2.3的影子可以包含颜色、offsetx，offsety对象配置、透明度和宽度。默认为false
		        	showCheckbox: true,//Boolean 如果是true，一个复选框旁边显示图例项允许选择系列。复选框的状态是由选定的选项确定。默认为false
		        	showInLegend: true,//改系列图例是否显示
		        	softThreshold: true,//Boolean 如果是true，该系列不会导致Y轴过零平面（或阈值选项），除非数据实际上越过平面。
		        	step: false,//String 是否适用于行的步骤。可能的值是left, center and right   默认为false
		        	visible: true,//Boolean 设置系列的初始可见性。默认为true
		        	xAxis: 0,//Number|String 使用双重或多重X轴时，这一数字定义的特定序列连接到X。它是指轴ID或在X轴阵列轴线指数，0是第一。默认值为0
		        	yAxis: 0,//Number|String 使用双重或多重Y轴时，这一数字定义的特定系列轴连接。它是指轴ID或在轴阵列轴线的指数，0是第一。默认值为0
		        	zoneAxis: 'x',//String 定义区域的轴。默认为y
		        	/*zones: [{//定义系列内的区域的数组。带可应用于X轴、Y轴、Z轴的气泡，根据晶带轴选项。
	                    value: 0, //如果区域未定义，则该值上升到区域扩展的值，该区域延伸到该系列中的最后一个值。默认为未定义
	                    className: 'zone-0'
	                }, {
	                    value: 10,
	                    className: 'zone-1'
	                }, {
	                    className: 'zone-2'
	                }],*/
	                zones: [{
	                	className: null,//String 风格模式。区域的自定义类名称
	                	//dashStyle: 'dot',//String 用于图的破折号样式的名称
	                	color: '#f7a35c',//Color 定义该系列的颜色
	                	fillColor: null,//Color 定义系列的填充颜色（区域类型系列）
	                	value: 10//Number 如果区域未定义，则该值上升到区域扩展的值，该区域延伸到该系列中的最后一个值.。默认为undefined
		        	},{
	                	color: '#7cb5ec',//Color 定义该系列的颜色
	                	value: 20//Number 如果区域未定义，则该值上升到区域扩展的值，该区域延伸到该系列中的最后一个值.。默认为undefined
		        	},{
		                color: '#90ed7d'
		            }],
	                type: 'line',
		        	name: '一楼1号',//名称的系列显示、提示等
		            data: [ ['1月份',4.6], -2.2, 4.5, 13.1, 19.8, 24.0, 25.8, 24.4, 19.3, 12.4, 4.1, -2.7]
		        },{ 
		            name: '一楼2号', 
		            data: [13.3, 14.4, 17.7, 21.9, 24.6, 27.2, 30.8, 32.1, 27.2, 23.7, 21.3, 15.6] 
		        },{ 
		            name: '一楼3号', 
		            data: [10.3, 11.4, 13.7, 22.9, 24.6, 37.2, 35.8, 32.1, 29.2, 21.7, 11.3, 5.6] 
		        },{ 
		            name: '一楼4号', 
		            data: [12.3, 15.4, 17.7, 22.9, 23.6, 27.2, 35.8, 32.1, 24.2, 21.7, 10.3, 9.6] 
		        },{ 
		            name: '一楼5号', 
		            data: [14.3, 16.4, 13.7, 12.9, 26.6, 33.2, 36.8, 38.1, 22.2, 22.7, 21.3, 12.6] 
		        }] 
		    }); 
		}); 
		
	</script>
</body>

</html>