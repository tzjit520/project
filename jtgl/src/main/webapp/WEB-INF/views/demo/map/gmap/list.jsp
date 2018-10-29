<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>地图</title>
<%@ include file="/templates/include.jsp"%>
<link rel="stylesheet" href="https://cache.amap.com/lbs/static/main1119.css" />
<!-- 高德地图  参数插件plugin=AMap.MarkerClusterer(标注点聚合需要), AMap.Scale(比例尺插件), AMap.ToolBar(标尺插件), AMap.Geocoder(地址解析) -->
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.4.3&key=6cf74401bde6045cbb6bf91778d864fe&plugin=AMap.MarkerClusterer,AMap.Scale,AMap.ToolBar,AMap.Geocoder"></script>
<style type="text/css">
#allmap {
	height: 700px;
	width: 100%;
}

.amap-logo {
	display: none;
}

.amap-copyright {
	bottom: -100px;
	display: none;
}

.titleClass {
	margin-top: 10px;
	background-color: #94b9ec;
	color: #FFFFFF;
	width: 100%;
}
</style>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">高德地图</h1><hr/>
			</div>

			<form class="form-horizontal group-border hover-stripped">
				<div class="form-group">
					<label class="col-xs-1 control-label">主题:</label>
					<div class="col-xs-2">
						<select id="stylelist" onchange="changeMapStyle(this.value)" class="form-control select2"></select>
					</div>
					<label class="col-xs-1 control-label">输入地址:</label>
					<div class="col-xs-2">
						<input type="text" id="mapAddress" class="form-control" />
					</div>
					<div class="col-xs-1">
						<button type="button" class="btn btn-pink" onclick="parseAddress()">
							<i class="ec-star"></i>
							解析
						</button>
					</div>
					<div class="col-xs-3">
						<label class="control-label">
							本次地址:
							<span id="info"></span>
						</label>
					</div>
					<div class="col-xs-2">
						<label class="control-label">
							当前级别:
							<span id="zoom"></span>
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-1 control-label">经度:</label>
					<div class="col-xs-2">
						<input type="text" id="mapY" class="form-control" />
					</div>
					<label class="col-xs-1 control-label">纬度:</label>
					<div class="col-xs-2">
						<input type="text" id="mapX" class="form-control" />
					</div>
					<div class="col-xs-1">
						<button type="button" class="btn btn-pink" onclick="parsePoint()">
							<i class="ec-star"></i>解析
						</button>
					</div>
					<div class="col-xs-4">
						<label class="control-label">坐标:
							<span id="zb"></span>
						</label>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-5">
						<button type="button" class="btn btn-pink" onclick="setZoom(8)">批量地址解析</button>
						<button type="button" class="btn btn-pink" onclick="setZoom(15)">批量逆地址解析</button>
						<button type="button" class="btn btn-pink" onclick="setZoom(12)">打印UP语句</button>
					</div>
					
					<div class="col-xs-3">
						<button type="button" class="btn btn-pink" onclick="setZoom(8)">8级</button>
						<button type="button" class="btn btn-pink" onclick="setZoom(12)">12级</button>
						<button type="button" class="btn btn-pink" onclick="setZoom(15)">15级</button>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-9">
						<!-- 地图容器 -->
						<div id="allmap"></div>
					</div>
					<div class="col-xs-3">
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="isToggleDrag(true)">可拖拽</button>
							<button type="button" class="btn btn-pink" onclick="isToggleDrag(false)">不可拖拽</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="isZoomEnable(true)">开启缩放</button>
							<button type="button" class="btn btn-pink" onclick="isZoomEnable(false)">关闭缩放</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="startDefaultRuler()">默认测距</button>
							<button type="button" class="btn btn-pink" onclick="startStyleRuler()">自定义测距</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="closeRuler()">关闭测距</button>
							<button type="button" class="btn btn-pink" onclick="addMarkers()">多个标注</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="clearMap()">清空标注</button>
							<button type="button" class="btn btn-pink" onclick="getBounds()">可视区域</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="addScale(true)">显示比例尺</button>
							<button type="button" class="btn btn-pink" onclick="addScale(false)">隐藏比例尺</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="addToolBar(true)">显示工具条</button>
							<button type="button" class="btn btn-pink" onclick="addToolBar(false)">隐藏工具条</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="addCopyrightControl(true)">添加版权</button>
							<button type="button" class="btn btn-pink" onclick="addCopyrightControl(false)">移除版权</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="isToggleDoubleClickZoom(true)">双击放大-开</button>
							<button type="button" class="btn btn-pink" onclick="isToggleDoubleClickZoom(false)">双击放大-关</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="isToggleKeyboard(true)">键盘移动-开</button>
							<button type="button" class="btn btn-pink" onclick="isToggleKeyboard(false)">键盘移动-关</button>
						</div>
						<div class="form-group"></div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
	  	//定位初始地点
	    var lngLat = new AMap.LngLat(112.745303, 27.241307);
	    //创建Map实例
	    var map = new AMap.Map('allmap', {
	        resizeEnable: true,//是否监控地图容器尺寸变化，默认值为false
	        zoom: 11,
	        center: lngLat
	    });
	    var myIcon = new AMap.Icon({
            image: "${ctx}/static/imges/img/p_huang.png",
            size: new AMap.Size(55, 45)
        })
        addMarker(lngLat, myIcon, false, true, '宝宝在此');

        //添加圆
        //addCircle(lngLat, 1000);

        //获取地图缩放级别
        getZoom();

        //绘制边界
        drawBoundary("衡山县");

        //关闭缩放
        isZoomEnable(false);
        /**
         * 个性化主题
         */
        var mapStyleDatas = [
            {"id":"normal", "name":"标准"},
            {"id":"dark", "name":"幻影黑"},
            {"id":"light", "name":"月光银"},
            {"id":"fresh", "name":"草色青"},
            {"id":"grey", "name":"雅士灰"},
            {"id":"graffiti", "name":"涂鸦"},
            {"id":"whitesmoke", "name":"远山黛"},
            {"id":"macaron", "name":"马卡龙"},
            {"id":"blue", "name":"靛青蓝"},
            {"id":"darkblue", "name":"极夜蓝"},
            {"id":"wine", "name":"酱籽"}
        ];
        var sel = document.getElementById('stylelist');
        for(var key in mapStyleDatas){
			var id = mapStyleDatas[key].id;
			var name = mapStyleDatas[key].name;
			var item = new Option(name, id);
			sel.options.add(item);
		}
        
        //改变主题
        var changeMapStyle = function(enName){
            map.setMapStyle('amap://styles/'+enName);
        }

        /**
         * 点击事件
         * @param params Object{lng,lat}
         */
        function personnelClick(params){
            if(params){
                var lng = params.lng,
                    lat = params.lat;
                if(isEmpty(lng) || isEmpty(lat)){
                    return ;
                }
                //定位初始地点
                var lngLat = new AMap.LngLat(lng, lat);
                //设置中心点
                centerAndZoom(lngLat, 13);
                //添加圆
                addCircle(lngLat, 1000);
                //定义弹窗信息模板
                var title = "<table border='0' class='titleClass'><th style='text-align:center'>【人员信息】</th></table>";
                var content = title+"<table border='0' style='margin-top:5px;'>"+
                    "<tr><td rowspan='5'><img src='"+ params.photo +"' width='150px' height='160px'></td><td class='padd'>编号：</td><td>"+ params.number +"</td></tr>"+
                    "<tr><td class='padd'>姓名：</td><td>"+ params.name +"</td></tr>"+
                    "<tr><td class='padd'>性别：</td><td>"+ params.sex +"</td></tr>"+
                    "<tr><td class='padd'>手机：</td><td>"+ params.phone +"</td></tr>"+
                    "<tr><td class='padd'>地址：</td><td>"+ params.address +"</td></tr></table>";

                //自定义图片标注
                var myIcon = '';
                if(params.sex == "男"){
                    myIcon = new AMap.Icon({
                        image: "${ctx}/static/imges/img/p_huang.png",
                        size: new AMap.Size(55, 45)
                    });
                }else if(params.sex == "女"){
                    myIcon = new AMap.Icon({
                        image: "${ctx}/static/imges/img/p_hong.png",
                        size: new AMap.Size(55, 45)
                    });
                }
                var marker = addMarker(lngLat, myIcon, false, false, params.name);

                //为标注绑定点击事件
                addMarkerClick(content, marker);
                //开启信息窗口
                openInfoWindow(content, lngLat);
            }
        }

        /**
         * 为标注绑定点击事件  打开弹窗
         * @param content (String)弹窗内容  可以是一段HTML内容
         * @param marker 标注Marker
         */
        function addMarkerClick(content, marker){
            marker.on('click', function(e){
                //openInfoWindow(content, marker.getPosition());
                var p = marker.getPosition();
               	var lngLat = new AMap.LngLat(p.lng, p.lat);
                var params = {
                    lng: lngLat.lng,
                    lat: lngLat.lat,
                    sex: '男',
                    photo: '${ctx}/static/imges/a.jpg',
                    name: '谭志杰',
                    number: '001',
                    phone: '16602130404',
                    address: '上海市浦东新区浦东南路882号海光大厦'
                };
                personnelClick(params);
            });
        }

        /**
         * 打开弹窗
         * @param content (String)弹窗内容  可以是一段HTML内容
         * @param lngLat 定位点lngLat
         */
        function openInfoWindow(content, lngLat){
            var infoWindow = new AMap.InfoWindow({
                size: new AMap.Size(450,220),
                content: content,
                offset: new AMap.Pixel(16, -15),
                closeWhenClickMap:true
            });
            //开启信息窗口
            infoWindow.open(map, lngLat);
        }

        /**
         * 添加右键菜单
         * @param txtMenuItem  菜单项数组
         */
        function addRightMenuItem(){
            var txtMenuItemArr = [
                {
                    text:'放大',
                    callback: function(){
                        map.zoomIn();
                    },
                    order: 1
                },
                {
                    text:'缩小',
                    callback:function(){
                        map.zoomOut();
                    },
                    order: 2
                },
                {
                    text:'自适应',
                    callback:function(){
                        map.setFitView();//地图自适应
                    },
                    order: 3
                }
            ];
            var contextMenu = new AMap.ContextMenu();  //创建右键菜单
            for(var i = 0; i < txtMenuItemArr.length; i++){
                contextMenu.addItem(txtMenuItemArr[i].text, txtMenuItemArr[i].callback, txtMenuItemArr[i].order);//添加菜单项
            }
            //地图绑定鼠标右击事件——弹出右键菜单
            map.on('rightclick', function(e) {
                contextMenu.open(map, e.lnglat);
            });
        }
        addRightMenuItem();


        /**
         * 给标注添加右键菜单
         */
        function addMarkerRightMenu(marker){
            //创建右键菜单
            var markerMenu=new AMap.ContextMenu();
            markerMenu.addItem('开启跳动',function(){
                marker.setAnimation("AMAP_ANIMATION_BOUNCE");
            },1);
            markerMenu.addItem('停止跳动',function(){
                marker.setAnimation("AMAP_ANIMATION_NONE");
            },2);
            markerMenu.addItem('开启拖拽',function(){
                marker.setDraggable(true);
            },3);
            markerMenu.addItem('关闭拖拽',function(){
                marker.setDraggable(false);
            },4);
            markerMenu.addItem('删除标注',function(){
                marker.hide();
            },5);
            //绑定鼠标右击事件——弹出右键菜单
            marker.on('rightclick', function(e) {
                markerMenu.open(map, e.lnglat);
            });
        }

        /**
         * 绘制城市边界
         * @param city
         */
        function drawBoundary(city) {
            var district;
            //加载行政区划插件
            AMap.service('AMap.DistrictSearch', function() {
                var opts = {
                    subdistrict: 1,   //返回下一级行政区
                    extensions: 'all',  //返回行政区边界坐标组等具体信息
                    level: 'area'  //查询行政级别为 市
                };
                //实例化DistrictSearch
                district = new AMap.DistrictSearch(opts);
                district.setLevel('district');
                //行政区查询
                district.search(city, function(status, result) {
                    var bounds = result.districtList[0].boundaries;
                    var polygons = [];
                    if (bounds) {
                        for (var i = 0, l = bounds.length; i < l; i++) {
                            //生成行政区划polygon
                            var polygon = new AMap.Polygon({
                                map: map,
                                path: bounds[i],
                                fillOpacity: 0.2,
                                fillColor: '#CCF3FF',
                                strokeWeight: 2,
                                strokeColor: "#9370DB",
                                strokeStyle: "dashed"
                            });
                            polygons.push(polygon);
                        }
                        //map.setFitView();//地图自适应
                    }
                });
            });
        }

        /**
         * 添加圆
         * @param lngLat 圆心位置LngLat
         * @param radius 圆半径，单位:米
         */
        function addCircle(lngLat, radius){
            var opts = {
                map: map,
                center: lngLat, //圆心位置LngLat
                radius: radius, //圆半径，单位:米
                fillColor:"#6495ED",//圆形填充颜色。当参数为空时，圆形将没有填充效果
                strokeWeight: 1 , //圆形边线的宽度，以像素为单位
                fillOpacity: 0.3,//圆形填充的透明度，取值范围0 - 1
                strokeOpacity: 0.3 //圆形边线透明度，取值范围0 - 1
            };
            var circle = new AMap.Circle(opts);
        }


        /**
         * 初始化鼠标测距
         */
        var rulerDefault, relerStyle;
        map.plugin(["AMap.RangingTool"], function() {
            //默认样式测距
            rulerDefault = new AMap.RangingTool(map);
            //自定义样式测距
            var sMarker = {
                icon: new AMap.Icon({
                    size: new AMap.Size(55, 45),//图标大小
                    image: "${ctx}/static/imges/img/p_huang.png"
                }),
                offset: new AMap.Pixel(-40, -31)
            };
            var eMarker = {
                icon: new AMap.Icon({
                    size: new AMap.Size(55, 45),//图标大小
                    image: "${ctx}/static/imges/img/p_huang.png"
                }),
                offset: new AMap.Pixel(-9, -31)
            };
            var lOptions = {
                strokeStyle: "solid",
                strokeColor: "#FF33FF",
                strokeOpacity: 1,
                strokeWeight: 2
            };
            var rulerOptions = {startMarkerOptions: sMarker, endMarkerOptions: eMarker, lineOptions: lOptions};
            relerStyle = new AMap.RangingTool(map, rulerOptions);
        });

        /**
         * 开启默认测距
         */
        function startDefaultRuler() {
            //开启默认样式测距
            rulerDefault.turnOn();
            //关闭自定义测距
            relerStyle.turnOff();
        }

        /**
         * 开启自定义测距
         */
        function startStyleRuler() {
            //关闭默认样式测距
            rulerDefault.turnOff();
            //开启自定义测距
            relerStyle.turnOn();
        }

        /**
         * 关闭测距
         */
        function closeRuler() {
            //关闭默认样式测距
            rulerDefault.turnOff();
            //关闭自定义测距
            relerStyle.turnOff();
        }

        /**
         * 多个标注点
         */
        function addMarkers(){
            // 随机向地图添加25个标注
            var bounds = map.getBounds();
            var sw = bounds.getSouthWest();
            var ne = bounds.getNorthEast();
            var lngSpan = Math.abs(sw.lng - ne.lng);
            var latSpan = Math.abs(ne.lat - sw.lat);

            var cluster, markers = [];
            for (var i = 1; i <= 25; i++) {
                var lngLat = new AMap.LngLat(sw.lng + lngSpan * (Math.random() * 0.7), ne.lat - latSpan * (Math.random() * 0.7));
                var marker = addMarker(lngLat, '', false, false, '标注'+i);
                markers.push(marker);
                addMarkerRightMenu(marker);
            }
            if (cluster) {
                cluster.setMap(null);
            }
            //默认样式
            cluster = new AMap.MarkerClusterer(map, markers, {gridSize:80});
        }

        /**
         * 添加标注
         * @param lngLat 坐标对象AMap.LngLat(lng:Number,lat:Number)
         * @param myIcon String或AMap.Icon(opt:IconOptions)
         * @param isAnimation 是否跳动
         * @param isDragging 是否可以拖拽
         * @param title 鼠标悬浮显示的内容
         * @returns {AMap.Marker}
         */
        function addMarker(lngLat, myIcon, isAnimation, isDragging, title) {
            var markerOpts = {};
            //要显示该marker的地图对象
            markerOpts.map = map;
            //点标记在地图上显示的位置，默认为地图中心点
            markerOpts.position = lngLat;
            //自定义图片标注
            if(isNotEmpty(myIcon)){
                markerOpts.icon = myIcon;
            }
            //设置点标记的动画效果  默认值：“AMAP_ANIMATION_NONE”  可选值：“AMAP_ANIMATION_NONE”，无动画效果  / “AMAP_ANIMATION_DROP”，点标掉落效果  / “AMAP_ANIMATION_BOUNCE”，点标弹跳效果
            if(isAnimation){
                markerOpts.animation = "AMAP_ANIMATION_BOUNCE";//弹跳效果
            }else{
                markerOpts.animation = "AMAP_ANIMATION_NONE";//无动画效果
            }
            //开启标注拖拽功能
            if(isDragging){
                markerOpts.draggable = true;
            }
            //鼠标移到marker上的显示内容
            if(isNotEmpty(title)){
                markerOpts.title = title;
            }
            var marker = new AMap.Marker(markerOpts);
            return marker;
        }

        /**
         * 是否允许拖拽地图
         * @param flag
         */
        function isToggleDrag(flag) {
            if (flag) {
                map.setStatus({dragEnable: true});
            } else {
                map.setStatus({dragEnable: false});
            }
        }

        /**
         * 是否允许缩放地图
         * @param flag
         */
        function isZoomEnable(flag) {
            if (flag) {
                map.setStatus({zoomEnable: true});
            } else {
                map.setStatus({zoomEnable: false});
            }
        }

        /**
         * 是否允许键盘平移
         * @param flag
         */
        function isToggleKeyboard(flag) {
            if (flag) {
                map.setStatus({keyboardEnable: true});
            } else {
                map.setStatus({keyboardEnable: false});
            }
        }

        /**
         * 允许双击放大地图
         * @param flag
         */
        function isToggleDoubleClickZoom(flag) {
            if (flag) {
                map.setStatus({doubleClickZoom: true});
            } else {
                map.setStatus({doubleClickZoom: false});
            }
        }

        /**
         * 添加比例尺
         */
        var scale = new AMap.Scale({
            visible: false,
            position: 'LB',//控件停靠位置 LT:左上角; RT:右上角; LB:左下角; RB:右下角; 默认位置：LB
            offset: AMap.Pixel(20, 10)
        });
        map.addControl(scale);
        function addScale(flag){
            if(flag){
                scale.show();
            }else{
                scale.hide();
            }
        }

        /**
         * 添加工具条
         */
        var toolBar = new AMap.ToolBar({visible: false});
        map.addControl(toolBar);
        function addToolBar(flag){
            if(flag){
                toolBar.show();//显示工具条(包含方向盘和标尺)
                //toolBar.showDirection();//显示工具条方向盘
                //toolBar.showRuler();//显示工具条标尺
            }else{
                toolBar.hide();//隐藏工具条(包含方向盘和标尺)
                //toolBar.hideDirection();//隐藏工具条方向盘
                //toolBar.hideRuler();//隐藏工具条方向盘
            }
        }

        /**
         * 设置中心点和地图级别
         * @param lngLat 坐标lngLat
         * @param zoom 级别4-18
         */
        function centerAndZoom(lngLat, zoom){
            map.setCenter(lngLat);
            setZoom(zoom);
        }

        /**
         * 删除地图上所有的覆盖物
         */
        function clearMap(){
            map.clearMap();
        }

        /**
         * 地图放大一级显示
         */
        function zoomIn(){
            map.zoomIn();
        }

        /**
         * 地图缩小一级显示
         */
        function zoomOut(){
            map.zoomOut();
        }

        /**
         * 获取当前地图视图范围
         */
        function getBounds(){
            //获取当前可视区域。 3D地图下返回类型为AMap.ArrayBounds，2D地图下仍返回AMap.Bounds
            var bounds = map.getBounds();
            //获取西南角坐标。
            var bssw = bounds.getSouthWest();
            //获取东北角坐标
            var bsne = bounds.getNorthEast();
            $alert("当前地图可视范围是：" + bssw.lng + "," + bssw.lat + "到" + bsne.lng + "," + bsne.lat,"提示");
            return sw.toString() + ne.toString();
        }

        /**
         * 获取当前地图缩放级别
         */
        function getZoom(){
            //在PC上，默认取值范围为[3,18]；在移动设备上，默认取值范围为[3-19] , 3D地图会返回浮点数，2D视图为整数
            var number = map.getZoom();
            $("#zoom").text(number +"级");
        }

        /**
         * 设置地图显示的缩放级别
         * @param zoom
         */
        function setZoom(zoom){
            //在PC上，参数zoom可设范围：[3,18]；在移动端：参数zoom可设范围：[3,19] , 3D地图下，可将zoom设置为浮点数
            map.setZoom(zoom);
        }

		//地址解析
        function parseAddress(){
        	var address = $("#mapAddress").val();
        	if(isEmpty(address)){
                $alert("地址不能为空", "提示");
                return;
            }
        	geocoder(address);
        }
        
		//逆地址解析
        function parsePoint(){
        	var lng = $("#mapY").val();
            var lat = $("#mapX").val();
            if(isEmpty(lng) || isEmpty(lat)){
                $alert("经纬度不能为空", "提示");
                return;
            }
            regeocoder(new AMap.LngLat(lng, lat));
        }
        
        function regeocoder(lngLat) {  //逆地理编码
            var geocoder = new AMap.Geocoder({
                radius: 1000,
                extensions: "all"//逆地理编码时，返回信息的详略  默认值：base，返回基本地址信息； 取值为：all，返回地址信息及附近poi、道路、道路交叉口等信息
            });        
            geocoder.getAddress(lngLat, function(status, result) {
                if (status === 'complete' && result.info === 'OK') {
                	regeocoder_CallBack(result, lngLat);
                }
            });        
            map.setFitView();
        }
        
        function regeocoder_CallBack(data, lngLat) {
            var address = data.regeocode.formattedAddress; //返回地址描述
            $("#info").text(address);
            $("#zb").text("纬度(X): "+ lngLat.lat + ", 经度(Y): " + lngLat.lng);
        }
        
        //地址解析
        function geocoder(address) {
            var geocoder = new AMap.Geocoder({
                city: "全国", //城市，默认：“全国”
                radius: 1000 //范围，默认：500
            });
            //地理编码,返回地理编码结果
            geocoder.getLocation(address, function(status, result) {
                if (status === 'complete' && result.info === 'OK') {
                    geocoder_CallBack(result);
                }
            });
        }
        
      	//地理编码返回结果展示
        function geocoder_CallBack(data) {
            //地理编码结果数组
            var geocode = data.geocodes;
            addMarker(geocode[0].location, null, false, false, geocode[0].formattedAddress);
            map.setFitView();
            $("#info").text(geocode[0].formattedAddress);
            $("#zb").text("纬度(X): "+ geocode[0].location.lat + ", 经度(Y): " + geocode[0].location.lng);
        }
        
        //为地图注册click事件获取鼠标点击出的经纬度坐标
        var clickEventListener = map.on('click', function(e) {
        	regeocoder(new AMap.LngLat(e.lnglat.getLng(), e.lnglat.getLat()));
        });

        /**
         * 地图缩放停止时触发
         */
        map.on('zoomend', function() {
            getZoom();
        });

        /**
         * 地图缩放停止时触发
         */
        map.on('dragend', function() {
            console.log("停止拖拽了");
        });

        /**
         * 判断字符串是否为undefined、null、''
         * @param str
         * @returns {boolean}  如果是undefined、null、''，返回false
         */
        function isNotEmpty(str){
            if(str == undefined || str == null || str == '')
                return false;
            return true;
        }

        /**
         * 判断字符串是否为undefined、null、''
         * @param str
         * @returns {boolean} 如果是undefined、null、''，返回true
         */
        function isEmpty(str){
            if(str == undefined || str == null || str == '')
                return true;
            return false;
        }
    </script>

</body>
</html>
