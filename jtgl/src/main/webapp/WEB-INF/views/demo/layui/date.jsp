<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>LayUI</title>
<link rel="stylesheet" href="${ctx}/static/plugin/layui/css/layui.css" />
</head>

<body>
	<div class="layui-fluid">
		<fieldset class="layui-elem-field layui-field-title">
			<legend>日期控件</legend>
		</fieldset>
		<form class="layui-form layui-form-pane1" action="" lay-filter="first" onsubmit="return false">
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">时间范围：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input" id="test1">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">日期选择器：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input" id="test2">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">年选择器：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input" id="test3">
				</div>
				<label class="layui-col-xs1 layui-form-label">年月选择器：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input" id="test4">
				</div>
				<label class="layui-col-xs1 layui-form-label">时间器：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input" id="test5">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">时间范围选择：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input" id="test55">
				</div>
				<label class="layui-col-xs1 layui-form-label">自定义重要日：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input" id="test555">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">同时绑定多个：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input test-item">
				</div>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input test-item">
				</div>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input test-item">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">墨绿主题：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input" id="test6-1">
				</div>
				<label class="layui-col-xs1 layui-form-label">自定义背景色：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input" id="test6-2">
				</div>
				<label class="layui-col-xs1 layui-form-label">格子主题：</label>
				<div class="layui-col-xs2 layui-inline">
					<input type="text" class="layui-input" id="test6-3">
				</div>
			</div>
			<div class="layui-form-item">
				<button class="layui-btn" id="test7">其它元素触发</button>
				<div class="layui-inline">
					<input type="text" class="layui-input" id="test6">
				</div>
				<button class="layui-btn" id="test9">外部事件触发</button>
				<div class="layui-inline">
					<input type="text" class="layui-input" id="test8">
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">嵌套容器中：</label>
				<div class="layui-inline" id="test10"></div>
				<div class="layui-inline" id="test11" style="margin-left: 30px;"></div>
			</div>
		</form>

		

		<script src="${ctx}/static/plugin/layui/layui.js"></script>

		<script type="text/javascript">
			layui.use('laydate', function() {
				var laydate = layui.laydate;

				//双控件
				laydate.render({
					elem : '#test1', // 指定元素
					type : 'datetime',
					trigger : 'click',
					lang : 'cn',
					range : true, //开启日期范围，默认使用“_”分割
					done : function(value, date, endDate) {
						console.log(value, date, endDate);
					},
					change : function(value, date, endDate) {
						console.log(value, date, endDate);
					}
				});

				//单控件
				laydate.render({
					elem : '#test2',
					//,format: 'yyyy年MM月dd日'
					//,value: new Date(1989,9,14),
					isInitValue : false,
					format : 'yyyy-MM-dd',
					//value : '2017-09-10'
					//,max: 0
					//,min: '2016-10-14'
					//,max: -1
					//,value: '1989年10月14日',
					ready : function(date) {
						console.log(date);
					},
					done : function(value, date, endDate) {
						console.log(value, date, endDate);
					}
				});

				//年选择器
				laydate.render({
					elem : '#test3',
					type : 'year',
					//,range: true 
					//,trigger: 'click'
					done : function(value, date, endDate) {
						console.log(value, date, endDate);
					},
					change : function(value, date, endDate) {
						//this.elem.val(value)
					}
				});

				//年月选择器
				laydate.render({
					elem : '#test4',
					type : 'month',
					range : true,
					//,trigger: 'click'
					max : -30,
					done : function(value, date, endDate) {
						console.log(value, date, endDate);
					},
					change : function(value, date, endDate) {
						this.elem.val(value)
					}
				});

				//时间选择器
				laydate.render({
					elem : '#test5',
					type : 'time',
					//,range: true
					//,trigger: 'click'
					min : '09:30:00',
					max : '17:30:00',
					done : function(value, date, endDate) {
						console.log(value, date, endDate);
					},
					change : function(value, date, endDate) {
						//this.elem.val(value)
					}
				});

				//时间范围选择器
				laydate.render({
					elem : '#test55',
					type : 'time',
					range : true,
					//,trigger: 'click'
					done : function(value, date, endDate) {
						console.log(value, date, endDate);
					}
				});

				//同时绑定多个
				lay('.test-item').each(function() {
					laydate.render({
						elem : this,
						trigger : 'click'
					});
				});

				//自定义重要日
				var ins555 = laydate.render({
					elem : '#test555',
					//,calendar: true //是否开启公历重要节日
					mark : { //标记重要日子
						'0-4-4' : '生日', //0代表：每年  0-0 即代表每年每月
						'0-0-15' : '中旬',
						'0-8-15' : '中秋',
						'0-0-31' : '月底'
					},
					done : function(value, date, endDate) {
						if (date.year == 2017 && date.month == 8
								&& date.date == 15) {
							//console.log('中国人民战胜日本法西斯纪念日');
						}
					},
					change : function(value, date, endDate) {
						console.log(value)
					}
				});

				//墨绿主题  内置了多种主题，theme的可选值有：default（默认简约）、molv（墨绿背景）、#颜色值（自定义颜色背景）、grid（格子主题）
				laydate.render({
					elem : '#test6-1', //指定元素
					type : 'datetime',
					theme : 'molv',
					//value : 20180115,
					isInitValue : true,
					//,range: true
					trigger : 'click'
				});

				//自定义背景色主题
				laydate.render({
					elem : '#test6-2' //指定元素
					,
					type : 'datetime',
					theme : '#393D49'
					//,range: true
					,
					trigger : 'click'
				});

				//格子主题
				laydate.render({
					elem : '#test6-3' //指定元素
					//,type: 'datetime'
					,
					theme : 'grid'
					//,range: true
					,
					trigger : 'click'
				});

				//其它元素触发
				laydate.render({
					elem : '#test6' //指定元素
					,
					eventElem : '#test7' //绑定执行事件的元素
					,
					lang : 'cn'
				});

				//外部事件
				lay('#test9').on('click', function(e) {
					laydate.render({
						elem : '#test8',
						type : 'datetime',
						show : true
						//,min: '2017-08-12 00:10:00'
						//,max: '2017-08-12 23:10:10'
						,
						closeStop : '#test9' //点击 #test6 所在元素区域不关闭控件
						,
						change : function(value, date) {
							console.log(value, date)
						},
						done : function(value, date) {
							console.log(value, date)
						}
					});
				});

				//直接嵌套在指定容器中
				var ins10 = laydate.render({
					elem : '#test10',
					position : 'static',
					calendar : true //是否开启公历重要节日
					,
					mark : { //标记重要日子
						'2017-8-20' : '',
						'2017-8-21' : ''
					},
					done : function(value, date, endDate) {
						if (date.year == 2017 && date.month == 8 && date.date == 20) {
							ins10.hint('XX活动日');
						}
					},
					change : function(value, date, endDate) {
						console.log(value)
					}
				});

				laydate.render({
					elem : '#test11',
					position : 'static',
					lang : 'cn',
					type : 'datetime',
					calendar : true //是否开启公历重要节日
					,
					done : function(value, date, endDate) {
						//console.log(value, date, endDate);
					},
					change : function(value, date, endDate) {
						console.log(value)
					}
				});
			});
		</script>
	</div>
</body>
</html>
