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
			<legend>按钮评分</legend>
		</fieldset>

		<form class="layui-form layui-form-pane1" action="" lay-filter="first" onsubmit="return false">
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">按钮色系：</label>
				<div class="layui-col-xs10 layui-inline">
					<a href="" class="layui-btn layui-btn-primary">原始按钮</a>
					<a href="" class="layui-btn">默认按钮</a>
					<button class="layui-btn layui-btn-normal">百搭按钮</button>
					<button class="layui-btn layui-btn-warm">暖色按钮</button>
					<button class="layui-btn layui-btn-danger">警告按钮</button>
					<button class="layui-btn layui-btn-disabled">禁用按钮</button>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">按钮图标：</label>
				<div class="layui-col-xs10 layui-inline">
					<button class="layui-btn">
						<i class="layui-icon">&#xe603;</i>
					</button>
					<button class="layui-btn">
						<i class="layui-icon">&#xe602;</i>
					</button>
					<button class="layui-btn">
						<i class="layui-icon">&#xe654;</i>
					</button>
					<button class="layui-btn">
						<i class="layui-icon">&#xe642;</i>
					</button>
					<button class="layui-btn">
						<i class="layui-icon">&#xe640;</i>
					</button>
					<button class="layui-btn">
						<i class="layui-icon">&#xe641;</i>
					</button>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">按钮尺寸：</label>
				<div class="layui-col-xs10 layui-inline">
					<button class="layui-btn layui-btn-big">大型按钮</button>
					<button class="layui-btn">默认按钮</button>
					<button class="layui-btn layui-btn-small">小型按钮</button>
					<button class="layui-btn layui-btn-mini">迷你按钮</button>
					<button class="layui-btn layui-btn-primary layui-btn-big">大型按钮</button>
					<button class="layui-btn layui-btn-primary">默认按钮</button>
					<button class="layui-btn layui-btn-primary layui-btn-small">小型按钮</button>
					<button class="layui-btn layui-btn-primary layui-btn-mini">迷你按钮</button>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">按钮圆角：</label>
				<div class="layui-col-xs10 layui-inline">
					<button class="layui-btn layui-btn-primary layui-btn-radius">原始按钮</button>
					<button class="layui-btn layui-btn-radius">默认按钮</button>
					<button class="layui-btn layui-btn-normal layui-btn-radius">百搭按钮</button>
					<button class="layui-btn layui-btn-warm layui-btn-radius">暖色按钮</button>
					<button class="layui-btn layui-btn-danger layui-btn-radius">警告按钮</button>
					<button class="layui-btn layui-btn-disabled layui-btn-radius">禁用按钮</button>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">按钮图文：</label>
				<div class="layui-col-xs10 layui-inline">
					<button class="layui-btn layui-btn-big layui-btn-primary layui-btn-radius">大型加圆角</button>
					<button class="layui-btn layui-btn-small layui-btn-normal">
						<i class="layui-icon">&#xe640;</i>
						删除
					</button>
					<button class="layui-btn layui-btn-mini layui-btn-disabled">
						<i class="layui-icon">&#xe641;</i>
						禁分享
					</button>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">按钮组：</label>
				<div class="layui-col-xs10 layui-inline">
					<div class="layui-btn-group">
						<button class="layui-btn">增加</button>
						<button class="layui-btn ">编辑</button>
						<button class="layui-btn">删除</button>
					</div>

					<div class="layui-btn-group">
						<button class="layui-btn layui-btn-small">
							<i class="layui-icon">&#xe654;</i>
						</button>
						<button class="layui-btn layui-btn-small">
							<i class="layui-icon">&#xe642;</i>
						</button>
						<button class="layui-btn layui-btn-small">
							<i class="layui-icon">&#xe640;</i>
						</button>
						<button class="layui-btn layui-btn-small">
							<i class="layui-icon">&#xe602;</i>
						</button>
					</div>

					<div class="layui-btn-group">
						<button class="layui-btn layui-btn-primary layui-btn-small">
							<i class="layui-icon">&#xe654;</i>
						</button>
						<button class="layui-btn layui-btn-primary layui-btn-small">
							<i class="layui-icon">&#xe642;</i>
						</button>
						<button class="layui-btn layui-btn-primary layui-btn-small">
							<i class="layui-icon">&#xe640;</i>
						</button>
						<button class="layui-btn layui-btn-primary layui-btn-small">
							<i class="layui-icon">&#xe602;</i>
						</button>
					</div>
				</div>
			</div>
		</form>

		<div class="layui-col-xs12">
			<div class="layui-col-xs2">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
					<legend>基础效果</legend>
				</fieldset>
				<div id="test1"></div>
			</div>
			<div class="layui-col-xs2">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
					<legend>显示文字</legend>
				</fieldset>
				<div id="test2"></div>
			</div>
			<div class="layui-col-xs2">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
					<legend>半星效果</legend>
				</fieldset>
				<div id="test3"></div>
				<div id="test4"></div>
			</div>
			<div class="layui-col-xs2">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
					<legend>自定义内容</legend>
				</fieldset>
				<div id="test5"></div>
				<div>
					<div id="test6"></div>
				</div>
			</div>
			<div class="layui-col-xs2">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
					<legend>自定义长度</legend>
				</fieldset>
				<div id="test7"></div>
				<div>
					<div id="test8"></div>
				</div>
			</div>
			<div class="layui-col-xs2">
				<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
					<legend>只读</legend>
				</fieldset>
				<div id="test9"></div>
			</div>
		</div>
		<div class="layui-col-xs12">
			<fieldset class="layui-elem-field layui-field-title" style="margin-top: 30px;">
				<legend>自定义主题色</legend>
			</fieldset>
			<ul>
				<li>
					<div id="test10"></div>
				</li>
				<li>
					<div id="test11"></div>
				</li>
				<li>
					<div id="test12"></div>
				</li>
				<li>
					<div id="test13"></div>
				</li>
				<li>
					<div id="test14"></div>
				</li>
			</ul>
		</div>
	</div>
	<script src="${ctx}/static/plugin/layui/layui.js"></script>
	<script type="text/javascript">
		layui.use([ 'rate' ], function() {
			var rate = layui.rate;
			//基础效果
			rate.render({
				elem : '#test1'
			})

			//显示文字
			rate.render({
				elem : '#test2',
				value : 2 //初始值
				,
				text : true
			//开启文本
			});

			//半星效果
			rate.render({
				elem : '#test3',
				value : 2.5 //初始值
				,
				half : true
			//开启半星
			})
			rate.render({
				elem : '#test4',
				value : 3.5,
				half : true,
				text : true
			})

			//自定义文本
			rate.render({
				elem : '#test5',
				value : 3,
				text : true,
				setText : function(value) { //自定义文本的回调
					var arrs = {
						'1' : '极差',
						'2' : '差',
						'3' : '中等',
						'4' : '好',
						'5' : '极好'
					};
					this.span.text(arrs[value] || (value + "星"));
				}
			})
			rate.render({
				elem : '#test6',
				value : 1.5,
				half : true,
				text : true,
				setText : function(value) {
					this.span.text(value);
				}
			})

			//自定义长度
			rate.render({
				elem : '#test7',
				length : 3
			});
			rate.render({
				elem : '#test8',
				length : 10,
				value : 8
			//初始值
			});

			//只读
			rate.render({
				elem : '#test9',
				value : 4,
				readonly : true
			});

			//主题色
			rate.render({
				elem : '#test10',
				value : 3,
				theme : '#FF8000' //自定义主题色
			});
			rate.render({
				elem : '#test11',
				value : 3,
				theme : '#009688'
			});

			rate.render({
				elem : '#test12',
				value : 2.5,
				half : true,
				theme : '#1E9FFF'
			})
			rate.render({
				elem : '#test13',
				value : 2.5,
				half : true,
				theme : '#2F4056'
			});
			rate.render({
				elem : '#test14',
				value : 2.5,
				half : true,
				theme : '#FE0000'
			})
		});
	</script>
</body>
</html>
