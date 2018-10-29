<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>Layer</title>
<link rel="stylesheet" href="${ctx}/static/plugin/layui/css/layui.css" />
</head>

<body>
	<div class="layui-fluid">
		<fieldset class="layui-elem-field layui-field-title">
			<legend>Layer组件</legend>
		</fieldset>
		<form class="layui-form layui-form-pane1" action="" lay-filter="first" onsubmit="return false">
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">信息框：</label>
				<div class="layui-col-xs10 layui-inline">
					<button id="test1" class="layui-btn">提示框</button>
					<button id="test2" class="layui-btn">确认框</button>
					<button id="test3" class="layui-btn">消息框</button>
					<button id="test4" class="layui-btn">表情消息框</button>
					<button id="test5" class="layui-btn">晃动消息框</button>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">页面层：</label>
				<div class="layui-col-xs10 layui-inline">
					<button id="test6" class="layui-btn">页面层自定义</button>
					<button id="test7" class="layui-btn">页面层图片</button>
					<button id="test8" class="layui-btn">IFrame父子操作</button>
					<button id="test9" class="layui-btn">IFrame多媒体</button>
					<button id="test10" class="layui-btn">IFrame禁止滚动</button>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">加载层：</label>
				<div class="layui-col-xs10 layui-inline">
					<button id="test11" class="layui-btn">默认</button>
					<button id="test12" class="layui-btn">风格2</button>
					<button id="test13" class="layui-btn">风格3</button>
					<button id="test14" class="layui-btn">风格4</button>
					<button id="test15" class="layui-btn">打酱油</button>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">tips层：</label>
				<div class="layui-col-xs10 layui-inline">
					<button id="test16" class="layui-btn">上</button>
					<button id="test17" class="layui-btn">右</button>
					<button id="test18" class="layui-btn">下</button>
					<button id="test19" class="layui-btn">左</button>
					<button id="test20" class="layui-btn">允许多个</button>
				</div>
			</div>
			<div class="layui-form-item">
				<label class="layui-col-xs1 layui-form-label">其它演示：</label>
				<div class="layui-col-xs10 layui-inline">
					<button id="test21" class="layui-btn">默认prompt</button>
					<button id="test22" class="layui-btn">屏蔽浏览器滚动条</button>
					<button id="test23" class="layui-btn">弹出即全屏</button>
					<button id="test24" class="layui-btn">正上方</button>
					<button id="test25" class="layui-btn">点击更换图标</button>
					<button id="test26" class="layui-btn">墨绿深蓝风</button>
					<button id="test27" class="layui-btn">捕获页</button>
					<button id="test28" class="layui-btn">相册层</button>
				</div>
			</div>
			<div class="layui-form-item">
				
			</div>
		</form>

		<div id="tong" style="display: none">
			<img alt="" src="${ctx}/static/media/photo/9.jpg">
		</div>

		<div id="ph" style="display: none">
			1. layer 系列常见问题的处理和相关实用干货集锦
			<br />
			2. layer 所有版本完整更新日志
			<br />
			3. 关注 layui 微信公众号，随时随地获取最新动态
		</div>

		<script src="${ctx}/static/jquery/jquery-1.8.3.min.js"></script>
		<script src="${ctx}/static/plugin/layer-v3.1/layer.js"></script>
		<script type="text/javascript">
		
			//提示框
			$("#test1").click(function() {
				layer.alert('见到你真的很高兴', {
					icon : 6
				});
			});

			//确认框
			$("#test2").click(function() {
				layer.msg('你确定你很帅么？', {
					time : 0, //不自动关闭
					btn : [ '必须啊', '丑到爆' ],
					yes : function(index) {
						layer.close(index);
						layer.msg('雅蠛蝶 O.o', {
							icon : 6,
							btn : [ '嗷', '嗷', '嗷' ]
						});
					}
				});
			});

			//消息框
			$("#test3").click(function() {
				layer.msg('这是最常用的吧');
			});

			//表情消息框
			$("#test4").click(function() {
				layer.msg('不开心。。', {
					icon : 5
				});
			});
			//晃动消息框
			$("#test5").click(function() {
				layer.msg('玩命卖萌中', function() {
					//关闭后的操作
				});
			});

			//----------页面层---------------------------------

			//页面层自定义
			$("#test6").click(function() {
				layer.open({
					type : 1,
					area : [ '600px', '360px' ],
					shadeClose : true, //点击遮罩关闭
					content : '\<\div style="padding:20px;">自定义内容\<\/div>'
				});
			});

			//页面层图片
			$("#test7").click(function() {
				layer.open({
					type : 1,
					title : false,
					closeBtn : 0,
					area : '516px',
					skin : 'layui-layer-nobg', //没有背景色
					shadeClose : true,
					content : $('#tong')
				});
			});
			//IFrame父子操作
			$("#test8").click(function() {
				layer.open({
					type : 2,
					area : [ '700px', '450px' ],
					fixed : false, //不固定
					maxmin : true,
					content : '${ctx}/api/v1/user'
				});
			});
			//IFrame多媒体
			$("#test9").click(function() {
				layer.open({
					type : 2,
					title : false,
					area : [ '630px', '360px' ],
					shade : 0.8,
					closeBtn : 0,
					shadeClose : true,
					content : '//player.youku.com/embed/XMjY3MzgzODg0'
				});
			});
			//IFrame禁止滚动
			$("#test10").click(function() {
				layer.open({
					type : 2,
					area : [ '360px', '500px' ],
					skin : 'layui-layer-rim', //加上边框
					content : [ '${ctx}/api/v1/user', 'no' ]
				});
			});

			//-----------------加载层------------------------------
			//默认
			$("#test11").click(function() {
				layer.load();
				//此处演示关闭
				setTimeout(function() {
					layer.closeAll('loading');
				}, 2000);
			});

			//风格2
			$("#test12").click(function() {
				layer.load(1, {time : 10*1000});//最长等待10秒
				//此处演示关闭
				setTimeout(function() {
					layer.closeAll('loading');
				}, 2000);
			});

			//风格3
			$("#test13").click(function() {
				layer.load(2);
				//此处演示关闭
				setTimeout(function() {
					layer.closeAll('loading');
				}, 2000);
			});

			//风格4
			$("#test14").click(function() {
				layer.msg('加载中', {
					icon : 16,
					shade : 0.01
				});
			});

			//打酱油
			$("#test15").click(function() {
				layer.msg('尼玛，打个酱油', {
					icon : 4
				});
			});

			//-----------------tips层------------------------------
			//上
			$("#test16").click(function() {
				layer.tips('上', '#test16', {
					tips : [ 1, '#0FA6D8' ]
				//还可配置颜色
				});
			});

			//右
			$("#test17").click(function() {
				layer.tips('默认就是向右的', '#test17');
			});

			//下
			$("#test18").click(function() {
				layer.tips('下', '#test18', {
					tips : 3
				});
			});

			//左
			$("#test19").click(function() {
				layer.tips('左边么么哒', '#test19', {
					tips : [ 4, '#78BA32' ]
				});
			});

			//允许多个
			$("#test20").click(function() {
				layer.tips('不销毁之前的', '#test20', {
					tipsMore : true
				});
			});

			//-----------------其它演示层------------------------------
			//默认prompt
			$("#test21").click(function() {
				layer.prompt(function(val, index) {
					layer.msg('得到了' + val);
					layer.close(index);
				});
			});

			//屏蔽浏览器滚动条
			$("#test22").click(function() {
				layer.open({
					content : '浏览器滚动条已锁',
					scrollbar : false
				});
			});

			//弹出即全屏
			$("#test23").click(function() {
				var index = layer.open({
					type : 2,
					content : '${ctx}/api/v1/user',
					area : [ '320px', '195px' ],
					maxmin : true
				});
				layer.full(index);
			});

			//正上方
			$("#test24").click(function() {
				layer.msg('灵活运用offset', {
					offset : 't',
					anim : 6
				});
			});

			//点击更换图标
			$("#test25").click(function() {
				var layerAlert = function(type) {
					type ? type : 0;
					layer.alert('有了回调', {
						icon : type
					}, function(index) {
						layer.close(index);
						if (type < 6) {
							type = type + 1;
							layerAlert(type);
						}
					});
				}
				layerAlert(0);
			});

			//墨绿深蓝风
			$("#test26").click(function() {
				layer.alert('墨绿风格，点击确认看深蓝', {
					skin : 'layui-layer-molv', //样式类名
					closeBtn : 0
				}, function() {
					layer.alert('偶吧深蓝style', {
						skin : 'layui-layer-lan',
						closeBtn : 0,
						anim : 4 //动画类型
					});
				});
			});

			//捕获页
			$("#test27").click(function() {
				layer.open({
					type : 1,
					shade : false,
					title : false, //不显示标题
					content : $('#ph'), //捕获的元素，注意：最好该指定的元素要存放在body最外层，否则可能被其它的相对元素所影响
					cancel : function() {
						layer.msg('捕获就是从页面已经存在的元素上，包裹layer的结构', {
							time : 5000,
							icon : 6
						});
					}
				});
			});

			var jsonImg = {
				"title" : "", //相册标题
				"id" : 123, //相册id
				"start" : 0, //初始显示的图片序号，默认0
				"data" : [ //相册包含的图片，数组格式
				{
					"alt" : "图片1",
					"pid" : 1, //图片id
					"src" : "${ctx}/static/media/photo/1.jpg", //原图地址
					"thumb" : "" //缩略图地址
				},
				{
					"alt" : "图片2",
					"pid" : 2, //图片id
					"src" : "${ctx}/static/media/photo/2.jpg", //原图地址
					"thumb" : "" //缩略图地址
				},
				{
					"alt" : "图片3",
					"pid" : 3, //图片id
					"src" : "${ctx}/static/media/photo/3.jpg", //原图地址
					"thumb" : "" //缩略图地址
				}]
			};
			//相册层
			$("#test28").click(function() {
				layer.photos({
					photos : jsonImg, //格式见API文档手册页
					anim : 5 //0-6的选择，指定弹出图片动画类型，默认随机
				});
			});
		</script>
	</div>
</body>
</html>
