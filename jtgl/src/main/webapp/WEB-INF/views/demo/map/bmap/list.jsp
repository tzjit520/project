<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>地图</title>
<%@ include file="/templates/include.jsp"%>
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=x2SVorYNX5WcawbfUnpOyPpK"></script>
<!-- 鼠标测距需要  -->
<script type="text/javascript" src="http://api.map.baidu.com/library/DistanceTool/1.2/src/DistanceTool_min.js"></script>
<!-- 百度地图主题需要  -->
<script type="text/javascript" src="http://lbsyun.baidu.com/custom/stylelist.js"></script>
<!-- 百度地图鼠标拉伸放大需要  -->
<script type="text/javascript" src="http://api.map.baidu.com/library/RectangleZoom/1.2/src/RectangleZoom_min.js"></script>
<!-- 百度地图点聚合需要  -->
<script type="text/javascript" src="http://api.map.baidu.com/library/TextIconOverlay/1.2/src/TextIconOverlay_min.js"></script>
<script type="text/javascript" src="http://api.map.baidu.com/library/MarkerClusterer/1.2/src/MarkerClusterer_min.js"></script>

<style type="text/css">
	#allmap {
		height: 700px;
		width: 100%;
	}
	
	.anchorBL {
		display: none
	} /* 去掉版权 */
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
				<h1 class="page-header">百度地图</h1><hr/>
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
							<i class="ec-star"></i>
							解析
						</button>
					</div>
					<div class="col-xs-4">
						<label class="control-label">
							坐标:
							<span id="zb"></span>
						</label>
					</div>
				</div>
				<div class="form-group">
					<label class="col-xs-1 control-label">起点:</label>
					<div class="col-xs-2">
						<input type="text" id="startAddress" value="上海市浦东新区浦东南路882号" class="form-control" />
					</div>
					<label class="col-xs-1 control-label">终点:</label>
					<div class="col-xs-2">
						<input type="text" id="endAddress" value="湖南省衡阳市衡山县永和乡龙凤村" class="form-control" />
					</div>
					<label class="col-xs-1 control-label">导航方案:</label>
					<div class="col-xs-2">
						<select id="mapPolicy" class="form-control select2">
							<option value="BMAP_DRIVING_POLICY_LEAST_TIME">最少时间</option>
							<option value="BMAP_DRIVING_POLICY_LEAST_DISTANCE">最短距离</option>
							<option value="BMAP_DRIVING_POLICY_AVOID_HIGHWAYS">避开高速</option>
						</select>
					</div>
					<div class="col-xs-3">
						<button type="button" class="btn btn-pink" onclick="startNavigation(false)">规划路线</button>
						<button type="button" class="btn btn-pink" onclick="startNavigation(true)">开始导航</button>
					</div>
					
				</div>
				<div class="form-group" id="juli" style="display: none">
					<label class="col-xs-1 control-label">距离:</label>
					<div class="col-xs-11">
						<label class="control-label" id="distance"></label>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-9">
						<!-- 地图容器 -->
						<div id="allmap"></div>
					</div>
					<div class="col-xs-3">
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="isDragging(true)">可拖拽</button>
							<button type="button" class="btn btn-pink" onclick="isDragging(false)">不可拖拽</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="isScrollWheelZoom(true)">开启缩放</button>
							<button type="button" class="btn btn-pink" onclick="isScrollWheelZoom(false)">关闭缩放</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="isDistanceTool(true)">开启测距</button>
							<button type="button" class="btn btn-pink" onclick="isDistanceTool(false)">关闭测距</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="isNavigation(true)">打开控件</button>
							<button type="button" class="btn btn-pink" onclick="isNavigation(false)">关闭控件</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="isGeolocation(true)">打开定位</button>
							<button type="button" class="btn btn-pink" onclick="isGeolocation(false)">关闭定位</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="addMarkers()">多个标注</button>
							<button type="button" class="btn btn-pink" onclick="removeOverlay()">清空标注</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="addCopyrightControl(true)">添加版权</button>
							<button type="button" class="btn btn-pink" onclick="addCopyrightControl(false)">移除版权</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="getGeoLocation()">浏览器定位</button>
							<button type="button" class="btn btn-pink" onclick="ipLocalCity()">IP定位</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="getBounds()">可视区域</button>
							<button type="button" class="btn btn-pink" onclick="setZoom(12)">打印UP语句</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="setZoom(8)">批量地址解析</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="setZoom(15)">批量逆地址解析</button>
						</div>
						<div class="form-group">
							<button type="button" class="btn btn-pink" onclick="setZoom(8)">8级</button>
							<button type="button" class="btn btn-pink" onclick="setZoom(12)">12级</button>
							<button type="button" class="btn btn-pink" onclick="setZoom(15)">15级</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
	    /**
	     * 百度个性化主题
	     */
		var sel = document.getElementById('stylelist');
		for(var key in mapstyles){
			var style = mapstyles[key];
			var item = new Option(style.title,key);
			sel.options.add(item);
		}
	  	//默认地图类型
	    var markType = 'dt', myGeo = new BMap.Geocoder();
	 	// 百度地图API功能
		var map = new BMap.Map("allmap", {enableMapClick:false});
	 	
		//设置地图显示的城市
	    setCurrentCity("衡阳市");
	 	
	  	//定位初始地点
	    var point = new BMap.Point(112.745303, 27.241307);
 	
	  	//初始化地图,设置中心点坐标和地图级别
	    centerAndZoom(point, 12);
	  	//获取解析的地址
        getGeocoder(point);
    
      	//添加右键菜单
        addRightMenuItem();
      
      	//显示比例尺  BMAP_ANCHOR_TOP_LEFT:左上角 / BMAP_ANCHOR_TOP_RIGHT:右上角 / BMAP_ANCHOR_BOTTOM_LEFT:左下角 / BMAP_ANCHOR_BOTTOM_RIGHT:右下角
        isScale(true, BMAP_ANCHOR_TOP_LEFT, 50, 670);
      
      	//城市列表控件
        addCityListControl(BMAP_ANCHOR_BOTTOM_RIGHT, 18, 10);

        //全景控件
        addPanoramaControl(18, 290);
      
      	//显示平移和缩放按钮
        isNavigation(true);

        //添加地图类型控件
        //addMapTypeControl(BMAP_MAPTYPE_CONTROL_HORIZONTAL, [BMAP_NORMAL_MAP, BMAP_PERSPECTIVE_MAP, BMAP_SATELLITE_MAP, BMAP_HYBRID_MAP]);
      
      	//绘制城市边界线
        drawBoundary("湖南省衡阳市衡山县");

      //添加地图类型控件
    	map.addControl(new BMap.MapTypeControl({
    		mapTypes:[
                BMAP_NORMAL_MAP,
                BMAP_HYBRID_MAP
            ]}));	
      
		//设置地图显示的城市
	    function setCurrentCity(city){
	        map.setCurrentCity(city);
	    }
		
	    /**
	     * 定位初始地点
	     * @param point 视野中心点
	     * @param zoom 视野级别
	     */
	    function centerAndZoom(point, zoom){
	        //初始化地图,设置中心点坐标和地图级别
	        map.centerAndZoom(point, zoom);
	    }
	    
	    /**
         * 根据Point获取中文地址
         */
        function getGeocoder(point){
            myGeo.getLocation(point, function(rs){
                var addComp = rs.addressComponents;
                var province = addComp.province,//省
                    city = addComp.city,//市
                    area = addComp.district,//区
                    lu = addComp.street,//什么路
                    hao = addComp.streetNumber;//门牌号
                var address = province + "" + city + "" + area + "" + lu + "" + hao;
                $("#info").text(address);
                $("#zb").text("纬度(X): "+ point.lat + ", 经度(Y): " + point.lng);
            });
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
                    options: {
                        id: 'fd',//指定此菜单项dom的id
                        width:80, //指定此菜单项的宽度，菜单以最长的菜单项宽度为准
                        iconUrl: BMAP_CONTEXT_MENU_ICON_ZOOMIN // 放大图标
                    }
                },
                {
                    text:'缩小',
                    callback:function(){
                        map.zoomOut();
                    },
                    options: {
                        id: 'sx',//指定此菜单项dom的id
                        width:80,//指定此菜单项的宽度，菜单以最长的菜单项宽度为准
                        iconUrl: BMAP_CONTEXT_MENU_ICON_ZOOMOUT // 缩小图标
                    }
                },
                {
                    text:'重置',
                    callback:function(){
                        reset();
                    },
                    options: {
                        id: 'cz',//指定此菜单项dom的id
                        width:80,//指定此菜单项的宽度，菜单以最长的菜单项宽度为准
                        iconUrl: '${ctx}/static/imges/img/legend_cgq_d.png'
                    }
                }
            ];
            //创建菜单实例
            var menu = new BMap.ContextMenu();
            for(var i = 0; i < txtMenuItemArr.length; i++){
                var item = new BMap.MenuItem(txtMenuItemArr[i].text, txtMenuItemArr[i].callback, txtMenuItemArr[i].options);
                menu.addItem(item);//添加菜单项
            }
            map.addContextMenu(menu);
        }
        
        /**
         * 添加比例尺
         * @param flag true:添加 / false删除
         * @param anchor 取值：BMAP_ANCHOR_TOP_LEFT:控件将定位到地图的左上角 / BMAP_ANCHOR_TOP_RIGHT:控件将定位到地图的右上角 / BMAP_ANCHOR_BOTTOM_LEFT:控件将定位到地图的左下角 / BMAP_ANCHOR_BOTTOM_RIGHT:控件将定位到地图的右下角
         * @param w 水平方向的数值
         * @param h 竖直方向的数值
         */
        function isScale(flag, anchor, w, h){
            var control = new BMap.ScaleControl({
                anchor: anchor,
                offset: new BMap.Size(w, h) //控件的偏移值
            });
            if(flag){
                map.addControl(control);
            }else{
                map.removeControl(control);
            }
        }

        /**
         * 城市列表控件
         * @param anchor 取值：BMAP_ANCHOR_TOP_LEFT:控件将定位到地图的左上角 / BMAP_ANCHOR_TOP_RIGHT:控件将定位到地图的右上角 / BMAP_ANCHOR_BOTTOM_LEFT:控件将定位到地图的左下角 / BMAP_ANCHOR_BOTTOM_RIGHT:控件将定位到地图的右下角
         * @param w 水平方向的数值
         * @param h 竖直方向的数值
         */
        function addCityListControl(anchor, w, h){
            var control = new BMap.CityListControl({
                anchor: anchor,
                offset: new BMap.Size(w, h) //控件的偏移值
            });
            map.addControl(control);
        }
        
        /**
         * 添加全景控件
         * @param w
         * @param h
         */
        function addPanoramaControl(w, h){
            var control = new BMap.PanoramaControl(); //构造全景控件
            control.setOffset(new BMap.Size(w, h));
            //添加全景控件到地图
            map.addControl(control);
        }
        
        /**
         * 是否显示缩放平移控件
         * @param flag
         * @param nanchor 取值：BMAP_ANCHOR_TOP_LEFT:控件将定位到地图的左上角 / BMAP_ANCHOR_TOP_RIGHT:控件将定位到地图的右上角 / BMAP_ANCHOR_BOTTOM_LEFT:控件将定位到地图的左下角 / BMAP_ANCHOR_BOTTOM_RIGHT:控件将定位到地图的右下角
         * @param type BMAP_NAVIGATION_CONTROL_SMALL：仅包含平移和缩放按钮；/ BMAP_NAVIGATION_CONTROL_PAN:仅包含平移按钮；/ BMAP_NAVIGATION_CONTROL_ZOOM：仅包含缩放按钮
         */
        var navigation = new BMap.NavigationControl({
            anchor: BMAP_ANCHOR_TOP_LEFT,
            type: BMAP_NAVIGATION_CONTROL_SMALL
        });
        function isNavigation(flag){
            if(flag){
                map.addControl(navigation);
            }else{
                map.removeControl(navigation);
            }
        }

        /**
         * 绘制城市边界线
         * @param cityName
         */
        function drawBoundary(city){
            // 表示当前绘制的城市边界
            var currentBoundary = null;
            //创建行政区域搜索的对象实例
            var bdary = new BMap.Boundary();
            bdary.get(city, function(rs){
                var count = rs.boundaries.length;
                if (count === 0) {
                    alert('未能获取当前输入行政区域');
                    return ;
                }
                var pointArray = [];
                if (currentBoundary != null) {
                    //从地图中移除覆盖物。如果覆盖物从未被添加到地图中，则该移除不起任何作用
                    map.removeOverlay(currentBoundary);
                }
                //建立多边形覆盖物
                currentBoundary = new BMap.Polyline(rs.boundaries[0], {strokeWeight: 4, strokeColor: "#9370DB", strokeStyle: "dashed"});
                // 禁止覆盖物在clearOverlays()方法中被删除
                currentBoundary.disableMassClear();
                // 设置透明度
                currentBoundary.setFillOpacity(0.1);
                //添加覆盖物
                map.addOverlay(currentBoundary);
                //pointArray = pointArray.concat(currentBoundary.getPath());
                //调整视野
                //map.setViewport(pointArray);
            });
        }
        
      	//改变主题
        var changeMapStyle = function(style){
            map.setMapStyle({style:style});
            $('#desc').html(mapstyles[style].desc);
        }
      
        /**
         * 设置地图级别
         * @param zoom
         */
        function setZoom(zoom){
            map.setZoom(zoom);
            getZoom();
        }
        
        /**
         * 是否显示版权
         */
        var control = new BMap.CopyrightControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT, offset: new BMap.Size(500,5)});//设置版权控件位置
        map.addControl(control);//添加版权控件
        function isCopyrightControl(flag){
            //返回地图可视区域
            var bounds = map.getBounds();
            if(flag){
                control.addCopyright({id: 1, content: "<a href='javascript:void(0);' style='font-size:15px;color:black'>©2016-2017 家庭管理系统 . All rights reserved</a>", bounds: bounds});
                //Copyright(id,content,bounds)类作为CopyrightControl.addCopyright()方法的参数
            }else{
                //移除版权信息
                control.removeCopyright(1);
            }
        }

        /**
         * 是否添加版权
         * @param flag
         */
        var addCopyrightControl = function(flag){
            isCopyrightControl(flag);
        }

        /**
         * 添加多个标注点
         */
        var addMarkers = function(){
            // 随机向地图添加25个标注
            var bounds = map.getBounds();
            var sw = bounds.getSouthWest();
            var ne = bounds.getNorthEast();
            var lngSpan = Math.abs(sw.lng - ne.lng);
            var latSpan = Math.abs(ne.lat - sw.lat);
            var markers = [];
            for (var i = 1; i <= 15; i++) {
                var point = new BMap.Point(sw.lng + lngSpan * (Math.random() * 0.7), ne.lat - latSpan * (Math.random() * 0.7));
                var myIcon = new BMap.Icon("${ctx}/static/imges/img/p_huang.png", new BMap.Size(55,45));
                var marker = addMarker(point, myIcon, true, false, '宝宝'+i);
                markers.push(marker);
                //删除标注
                var removeMarker = function(e,ee,marker){
                    map.removeOverlay(marker);
                }
                //设置标注点跳动
                var setAnimation = function(e,ee,marker){//BMAP_ANIMATION_DROP:坠落动画 / BMAP_ANIMATION_BOUNC:跳动动画
                    marker.setAnimation(null);
                }
                //可拖拽
                var enableDragging = function(e,ee,marker){
                    marker.enableDragging();
                }
                //可拖拽
                var disableDragging = function(e,ee,marker){
                    marker.disableDragging();
                }
              	//为标注绑定点击事件
                addMarkerClick('', marker);
                //创建右键菜单
                var markerMenu=new BMap.ContextMenu();
                markerMenu.addItem(new BMap.MenuItem('停止跳动',setAnimation.bind(marker),{iconUrl:"${ctx}/static/imges/img/tree_sensor.png"}));
                markerMenu.addItem(new BMap.MenuItem('开启拖拽',enableDragging.bind(marker),{iconUrl:"${ctx}/static/imges/img/tree_ld.png"}));
                markerMenu.addItem(new BMap.MenuItem('关闭拖拽',disableDragging.bind(marker),{iconUrl:"${ctx}/static/imges/img/tree_jzkzq.png"}));
                markerMenu.addItem(new BMap.MenuItem('删除标注',removeMarker.bind(marker),{iconUrl:"${ctx}/static/imges/img/legend_wzd.png"}));
                marker.addContextMenu(markerMenu);
            }
            //点聚合  最简单的用法，生成一个marker数组，然后调用markerClusterer类即可。
            var markerClusterer = new BMapLib.MarkerClusterer(map, {markers:markers});
        }
        
        /**
         * 添加定位控件
         */
        var geolocationControl = new BMap.GeolocationControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT, offset: new BMap.Size(120, 10)});
        geolocationControl.addEventListener("locationSuccess", function(e){
            // 定位成功事件
            var address = '';
            address += e.addressComponent.province;
            address += e.addressComponent.city;
            address += e.addressComponent.district;
            address += e.addressComponent.street;
            address += e.addressComponent.streetNumber;
            $alert("当前定位地址为：" + address);
        });
        geolocationControl.addEventListener("locationError",function(e){
            // 定位失败事件
            $alert("定位失败：" + e.message);
        });
        //是否显示定位控件
        var isGeolocation = function(flag){
            if(flag){
                map.addControl(geolocationControl);
            }else{
                map.removeControl(geolocationControl);
            }
        }
        
        /**
        * 解析中文地址
        */
       var parseAddress = function(){
           var address = $("#mapAddress").val();
           geocodeSearch(address);
       }

       /**
        * 坐标解析成中文地址
        */
       var parsePoint = function(){
           var lng = $("#mapY").val();
           var lat = $("#mapX").val();
           if(lng == "" || lat == "")
               return;
           var point = new BMap.Point(lng, lat);
           //添加标注
           var myIcon = new BMap.Icon("${ctx}/static/imges/img/p_huang.png", new BMap.Size(55,45));
           addMarker(point, myIcon, true, false, '宝宝很可爱');
           getGeocoder(point);
       }

       /**
        * 切换地图类型
        * @param type
        */
       var changeMapType = function(type){
           markType = type;
           $("#"+ markType +"_button").addClass("active").siblings().removeClass("active");
           //此地图类型展示普通街道视图
           var mapType = BMAP_NORMAL_MAP;
           if(markType == "wx"){
               //此地图类型展示卫星视图
               mapType = BMAP_SATELLITE_MAP;
           }else if(markType == "lw"){
               //此地图类型展示卫星和路网的混合视图
               mapType = BMAP_HYBRID_MAP;
           }else if(markType == "ts"){
               //此地图类型展示透视图像视图
               mapType = BMAP_PERSPECTIVE_MAP;
           }
           setMapType(mapType);
       }

       /**
        * 是否可拖拽
        * @param flag true:可拖拽 / false:不可拖拽
        */
       var isDragging = function(flag){
           if(flag){
               map.enableDragging();
           }else{
               map.disableDragging();
           }
       }

       /**
        * 是否开启缩放
        * @param flag true:开启缩放 / false:关闭缩放
        */
       var isScrollWheelZoom = function(flag){
           if(flag){
               map.enableScrollWheelZoom();
           }else{
               map.disableScrollWheelZoom();
           }
       }

       /**
        * 获取地图可视区域
        */
       var getBounds = function(){
           var bs = map.getBounds();   //获取可视区域
           var bssw = bs.getSouthWest();   //可视区域左下角
           var bsne = bs.getNorthEast();   //可视区域右上角
           $alert("当前地图可视范围是：" + bssw.lng + "," + bssw.lat + "到" + bsne.lng + "," + bsne.lat,"提示");
       }

       /**
        * 浏览器定位
        */
       var getGeoLocation = function(){
           var geolocation = new BMap.Geolocation();
           geolocation.getCurrentPosition(function(r){
               if(this.getStatus() == BMAP_STATUS_SUCCESS){
                   //定位
                   centerAndZoom(r.point, 15);
                   //添加标注
                   var myIcon = new BMap.Icon("${ctx}/static/imges/img/p_huang.png", new BMap.Size(55,45));
                   addMarker(r.point, myIcon, true, false, '宝宝在这');
                   map.panTo(r.point);
                   $alert('您的位置：' + r.point.lng + ',' + r.point.lat);
               }
               else {
            	   $alert('failed' + this.getStatus());
               }
           },{enableHighAccuracy: true})
           //关于状态码
           //BMAP_STATUS_SUCCESS	检索成功。对应数值“0”。
           //BMAP_STATUS_CITY_LIST	城市列表。对应数值“1”。
           //BMAP_STATUS_UNKNOWN_LOCATION	位置结果未知。对应数值“2”。
           //BMAP_STATUS_UNKNOWN_ROUTE	导航结果未知。对应数值“3”。
           //BMAP_STATUS_INVALID_KEY	非法密钥。对应数值“4”。
           //BMAP_STATUS_INVALID_REQUEST	非法请求。对应数值“5”。
           //BMAP_STATUS_PERMISSION_DENIED	没有权限。对应数值“6”。(自 1.1 新增)
           //BMAP_STATUS_SERVICE_UNAVAILABLE	服务不可用。对应数值“7”。(自 1.1 新增)
           //BMAP_STATUS_TIMEOUT	超时。对应数值“8”。(自 1.1 新增)
       }

       //根据IP定位
       function myFun(result){
		   var cityName = result.name;
		   map.setCenter(cityName);
		   $alert("当前定位城市:"+cityName);
	   }
       
     	//根据IP定位
       function ipLocalCity(){
		   var myCity = new BMap.LocalCity();
		   myCity.get(myFun);
       }
   	
       //鼠标测距
       var isDistanceTool = function (flag) {
           var opts = {
               "followText": "aaaaa",//测距过程中,提示框文字
               "unit": "metric",//测距结果单位制(metric:米/ us:表示美国传统单位)
               "lineColor": "red", //折线颜色
               //"lineStroke": 1, //折线宽度
               //"opacity": 0.3, //透明度
               //"lineStyle": "solid", //折线的样式，只可设置solid和dashed
               //"secIcon": "${ctx}/static/imges/img/p_lv.png", //转折点的Icon
               //"closeIcon": "${ctx}/static/imges/img/legend_wzd.png"//关闭按钮的Icon
               //"cursor": "" //跟随的鼠标样式*/
           }
           var myDis = new BMapLib.DistanceTool(map, opts);
           if(flag){
               //开启鼠标测距
               myDis.open();
           }else{
               //关闭鼠标测距
               myDis.close();
           }
       }
       
       /**
        * 获取当前地图缩放级别
        */
       function getZoom(){
           var number = map.getZoom();
           $("#zoom").text(number +"级");
       }
       getZoom();
       
       /**
        * 点击事件
        */
       function personnelClick(params){
           if(params){
               var lng = params.lng,
                   lat = params.lat;
               if(isEmpty(lng) || isEmpty(lat)){
                   return ;
               }
               var point = new BMap.Point(lng, lat);
               //定位初始地点
               centerAndZoom(point, 13);
               //添加圆
               addCircle(point, 500)
               //定义弹窗信息模板
               var content = "<table border='0' style='margin-top:5px;'>"+
                   "<tr><td rowspan='5'><img src='"+ params.photo +"' width='150px' height='160px'></td><td class='padd'>编号：</td><td>"+ params.number +"</td></tr>"+
                   "<tr><td class='padd'>姓名：</td><td>"+ params.name +"</td></tr>"+
                   "<tr><td class='padd'>性别：</td><td>"+ params.sex +"</td></tr>"+
                   "<tr><td class='padd'>手机：</td><td>"+ params.phone +"</td></tr>"+
                   "<tr><td class='padd'>地址：</td><td>"+ params.address +"</td></tr></table>";

               //自定义图片标注
               var myIcon = '';
               if(params.sex == "男"){
                   myIcon = new BMap.Icon("${ctx}/static/imges/img/p_huang.png", new BMap.Size(55,45));
               }else if(params.sex == "女"){
                   myIcon = new BMap.Icon("${ctx}/static/imges/img/p_hong.png", new BMap.Size(55,45));
               }
               //删除标注(防止重复)
               removeMarker(point);
               //添加标注
               var marker = addMarker(point, myIcon, true, true, params.name);
               //为标注绑定点击事件
               addMarkerClick(content, marker);
               //开启信息窗口
               openInfoWindow(content, point);
           }
       }
       
       /**
        * 删除指定标注 (如果是同一地址的标注  将会保留最新的一个标注)
        * @param point 经纬度
        */
       function removeMarker(point){
           //获取地图上所有的覆盖物
           var allOverlay = map.getOverlays();
           for(var i = 0; i < allOverlay.length; i++) {
               if(allOverlay[i].toString() == "[object Marker]"){
                   var markerObj = allOverlay[i];
                   if (markerObj.getPosition().lng == point.lng && markerObj.getPosition().lat == point.lat) {
                       map.removeOverlay(markerObj);
                   }
               }
           }
       }

       /**
        * 自定义图片标注
        * @param point 定位点Point
        * @param myIcon 图标Icon
        * @param isAnimation 是否跳动
        * @param isDragging 是否开启标注拖拽功能
        * @returns {BMap.Marker}
        */
       function addMarker(point, myIcon, isAnimation, isDragging, title){
           var opts = {};
           if(isNotEmpty(title)){
               //鼠标移到marker上的显示内容
               opts.title = title;
           }
           if(isNotEmpty(myIcon)){
               //自定义图片标注
               opts.icon = myIcon;
           }
           //创建标注
           var marker = new BMap.Marker(point, opts);
           // 将标注添加到地图中
           map.addOverlay(marker);
           if(isAnimation){
               //跳动的动画  BMAP_ANIMATION_DROP:坠落动画 / BMAP_ANIMATION_BOUNC:跳动动画
               marker.setAnimation(BMAP_ANIMATION_BOUNCE);
           }
           if(isDragging){
               //开启标注拖拽功能
               marker.enableDragging();
           }
           return marker;
       }

       /**
        * 添加label文字
        * @param point 定位点Point
        * @param text label文字描述
        */
       function addLabel(point, text){
           var opts = {
               position : point,    // 指定文本标注所在的地理位置
               offset   : new BMap.Size(10, -45)    //设置文本偏移量
           }
           var label = new BMap.Label(text, opts);  // 创建文本标注对象
           var minWidth = (text.length+2)*12;
           label.setStyle({
               color : "red",
               fontSize : "12px",
               height : "20px",
               fontFamily:"微软雅黑",
               minWidth: minWidth+"px"
           });
           map.addOverlay(label);
       }

       /**
        * 为标注绑定点击事件  打开弹窗
        * @param content (String)弹窗内容  可以是一段HTML内容
        * @param marker 标注Marker
        */
       function addMarkerClick(content, marker){
           marker.addEventListener("click", function(e){
               var p = e.target.getPosition();
               var point = new BMap.Point(p.lng, p.lat);
               //打开弹窗
               /* openInfoWindow(content, point) */
               
        	   var params = {
                   lng: point.lng,
                   lat: point.lat,
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
        * @param point 定位点Point
        */
       function openInfoWindow(content, point){
           var opts = {
               width : 450,     // 信息窗口宽度
               height: 200,     // 信息窗口高度
               title : "<table border='0' class='titleClass'><th style='text-align:center'>【人员信息】</th></table>" , // 信息窗口标题
               enableMessage:true//是否在信息窗里显示短信发送按钮（默认开启）
           };
           // 创建信息窗口对象
           var infoWindow = new BMap.InfoWindow(content, opts);
           //开启信息窗口
           map.openInfoWindow(infoWindow, point);
       }
       
       /**
        * 添加圆覆盖物
        * @param point 定位点Point
        * @param radius 覆盖范围(m)
        */
       function addCircle(point, radius){
           var circleOptions = {
               fillColor:"#6495ED",//圆形填充颜色。当参数为空时，圆形将没有填充效果
               strokeWeight: 1 , //圆形边线的宽度，以像素为单位
               fillOpacity: 0.3,//圆形填充的透明度，取值范围0 - 1
               strokeOpacity: 0.3 //圆形边线透明度，取值范围0 - 1
           }
           //创建圆覆盖物
           var circle = new BMap.Circle(point, radius, circleOptions);
           map.addOverlay(circle);
       }
       
       /**
        * 切换地图类型
        * @param mapType
        */
       function setMapType(mapType){
           map.setMapType(mapType);
           autoSize();
       }

       /**
        * 重新设置地图，恢复地图初始化时的中心点和级别
        */
       function reset(){
           map.reset();
       }

	   //清除覆盖物
	   function removeOverlay(){
  	   	   map.clearOverlays();         
	   }
       /**
        * 启用自动适应容器尺寸变化，默认启用
        */
       function autoSize(){
           map.enableAutoResize();
       }

       //地图更改缩放级别结束时触发触发此事件
       map.addEventListener("zoomend",function(e){
           getZoom();
       });

       //停止拖拽地图时触发
       map.addEventListener("dragend",function(e){
           console.log("拖拽停止了");
       });

       //当地图所有图块完成加载时触发此事件
       map.addEventListener("tilesloaded",function(e){
           console.log("地图全部加载完成");
       });

       /**
        * 地图单击事件
        */
       map.addEventListener("click",function(e){
           var point = e.point;
           getGeocoder(point);
       });

       /**
        * 解析中文地址
        */
       function geocodeSearch(address){
           if(isEmpty(address)){
               $alert("地址不能为空");
               return;
           }else{
               myGeo.getPoint(address, function(point){
                   if (point) {
                       //定位
                       centerAndZoom(point, 15);
                       //添加标注
                       var myIcon = new BMap.Icon("${ctx}/static/imges/img/p_huang.png", new BMap.Size(55,45));
                       addMarker(point, myIcon, true, false, address);
                       // 添加label文字
                       addLabel(point, address);
                       //获取解析的地址
                       getGeocoder(point);
                   }else{
                       $alert("地址解析失败");
                       return;
                   }
               }, "");
           }
       }

       /**
        * 获取两点之间的距离
        * @param pointA 地址1
        * @param pointB 地址2
        * @param uom 单位(m,km)
        * @returns {string} 米
        */
       function getDistance(pointA, pointB, uom){
           //获取两点距离,保留小数点后两位
           var totalDistance = map.getDistance(pointA,pointB);
           if(uom == 'm'){
               totalDistance = totalDistance.toFixed(2);
           }else if(uom == 'km'){
               totalDistance = Number(totalDistance/1000).toFixed(2);
           }
           return totalDistance;
       }

       /**
        * 开始导航
        */
       var startNavigation = function(flag){
           addDrivingRoute(flag);
       }

       /**
        * 解析起点和终点的地址
        */
       function addDrivingRoute(flag){
           var startAddress = $("#startAddress").val();
           var endAddress = $("#endAddress").val();
	       var mapPolicy = $("#mapPolicy").val();
           if(isEmpty(startAddress)){
               $alert("起点不能为空");
               return;
           }
           if(isEmpty(endAddress)){
               $alert("终点不能为空");
               return;
           }
           var startPoint, endPoint;
           myGeo.getPoint(startAddress, function(point){
               if (point) {
                   startPoint = point;
                   myGeo.getPoint(endAddress, function(point){
                       if (point) {
                           endPoint = point;
                           if(isNotEmpty(startPoint) && isNotEmpty(endPoint)){
        	                   $("#juli").show();
        	                   if(!flag){
        	                       //只规划路线
        	                       search(startPoint, endPoint, mapPolicy);
        	                   }else{
        	                       //规划路线并且开始导航
        	                       searchComplete(startPoint, endPoint, mapPolicy, 500);
        	                   }
                           }
                       }else{
                           $alert("终点地址解析失败");
                           return;
                       }
                   }, "");
               }else{
                   $alert("起点地址解析失败");
                   return;
               }
           }, "");
           
       }

       /**
        * 规划线路
        * @param startPoint 起点
        * @param endPoint 终点
        */
       function search(startPoint, endPoint, mapPolicy){
           //驾车实例
           var driving = new BMap.DrivingRoute(map, {
        	   renderOptions:{
        		   map: map, 
        		   autoViewport: true
        	   },
               policy: mapPolicy
           });
           driving.clearResults();
           //显示一条公交线路
           driving.search(startPoint, endPoint );
           //设置检索结束后的回调函数。参数：results: LocalResult 或 Array 如果是多关键字检索，回调函数参数为LocalResult的数组，数组中的结果顺序和检索中多关键字数组中顺序一致
           driving.setSearchCompleteCallback(function(){
               //通过驾车实例
               var plan = driving.getResults().getPlan(0);
               //距离
               $("#distance").text("[ "+ $("#startAddress").val() +" ] 到 [ "+ $("#endAddress").val() +" ] 全程共："+ getDistance(startPoint, endPoint, 'km') +"(KM), 大约需要"+ plan.getDuration());
           });
       }

       /**
        * 规划路线及导航
        * @param startPoint 起点
        * @param endPoint 终点
        * @param time 时间间隔
        */
       function searchComplete(startPoint, endPoint, mapPolicy, time){
           //驾车实例
           var driving = new BMap.DrivingRoute(map, {renderOptions:{map: map, autoViewport: true}, policy:mapPolicy});
           //显示一条公交线路
           driving.search(startPoint, endPoint );
           //设置检索结束后的回调函数。参数：results: LocalResult 或 Array 如果是多关键字检索，回调函数参数为LocalResult的数组，数组中的结果顺序和检索中多关键字数组中顺序一致
           driving.setSearchCompleteCallback(function(){
               //返回索引指定的方案。索引0表示第一条方案
               var plan = driving.getResults().getPlan(0);
               //返回路线的地理坐标点数组
               var points = plan.getRoute(0).getPath();
               //获得有几个点
               var len = points.length;
               //标注图片
               var myIcon = new BMap.Icon("${ctx}/static/imges/img/p_hong.png", new BMap.Size(55, 70), {    //小车图片
                   //offset: new BMap.Size(0, -5),    //相当于CSS精灵
                   imageOffset: new BMap.Size(0, 0)    //图片的偏移量。为了是图片底部中心对准坐标点。
               });
               //添加标注
               var marker = addMarker(points[0], myIcon, false, false, '宝宝很可爱');
               i = 0;
               function resetMkPoint(i){
                   startPoint = points[i];
                   endPoint = points[len-1];
                   //设置标注的地理坐标
                   marker.setPosition(points[i]);
                   //驾车实例
                   var driving1 = new BMap.DrivingRoute(map,{policy:mapPolicy});
                   //显示一条公交线路
                   driving1.search(startPoint, endPoint );
                   driving1.setSearchCompleteCallback(function(){
                       //返回索引指定的方案。索引0表示第一条方案
                       var plan1 = driving1.getResults().getPlan(0);
                       //距离
                       $("#distance").text("[ "+ $("#startAddress").val() +" ] 到 [ "+ $("#endAddress").val() +" ] 全程共："+ getDistance(startPoint, endPoint, 'km') +"(KM), 大约需要"+ plan1.getDuration());

                   });
                   if(i < len){
                       setTimeout(function(){
                           i++;
                           resetMkPoint(i);
                       },time);
                   }
               }
               setTimeout(function(){
                   resetMkPoint(5);
               },time)
           });
       }

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


       /**
        * --------------------------------------------------------------------
        * 批量地址解析
        * --------------------------------------------------------------------
        */

       //批量地址解析  获取数据
       var batchAddressParse = function(flagSql){
           mapService.findMapData().then(
               function(result){
                   if(result.data) {
                       //清空显示结果的div
                       document.getElementById("result").innerHTML = "";
                       //循环验证及解析数据
                       for(var i = 0; i < result.data.length; i++){
                           var person = result.data[i];
                           var province = person.province,
                               city = person.city,
                               area = person.area;
                           var address = '';
                           /*if(isNotEmpty(province)){
                               address += province;
                           }*/
                           if(isNotEmpty(city)){
                               address += city;
                           }
                           if(isNotEmpty(area)){
                               address += area;
                           }
                           if(isNotEmpty(person.address)){
                               address += person.address;
                           }
                           var params = {
                               sex: person.sex,
                               photo: person.photo,
                               name: person.name,
                               number: person.number,
                               phone: person.phone,
                               address: address
                           };
                           //生成坐标
                           setTimeout(batchGeocodeSearch(params, flagSql), 600);
                       }
                   }
               }
           );
       }

       /**
        * 开始解析
        * @param number 编号
        * @param name 姓名
        * @param address 地址
        * @param flagSql 是否打印update语句
        */
       function batchGeocodeSearch(params, flagSql){
           if(isEmpty(params.address)){
               document.getElementById("result").innerHTML += "[" + params.number + "]、" + params.name + "---->地址为空!</br>";
               return ;
           }
           myGeo.getPoint(params.address, function(point){
               if (point) {
                   if(flagSql){
                       document.getElementById("result").innerHTML += "update t_personnel set map_x = '"+ point.lat +"', map_y = '"+ point.lng +"', update_by = 1, update_date = now() where number =  '" + params.number +"';</br>";
                   }else{
                       document.getElementById("result").innerHTML += "[" + params.number + "]、" + params.name + "," + params.address + ", 经度(Y): " + point.lng + ", 纬度(X): " + point.lat + "</br>";
                   }

                   //定义弹窗信息模板
                   var content = "<table border='0' style='margin-top:5px;'>"+
                       "<tr><td rowspan='5'><img src='"+ params.photo +"' width='150px' height='160px'></td><td class='padd'>编号：</td><td>"+ params.number +"</td></tr>"+
                       "<tr><td class='padd'>姓名：</td><td>"+ params.name +"</td></tr>"+
                       "<tr><td class='padd'>性别：</td><td>"+ params.sex +"</td></tr>"+
                       "<tr><td class='padd'>手机：</td><td>"+ params.phone +"</td></tr>"+
                       "<tr><td class='padd'>地址：</td><td>"+ params.address +"</td></tr></table>";

                   //自定义图片标注
                   var myIcon = '';
                   if(params.sex == "男"){
                       myIcon = new BMap.Icon("${ctx}/static/imges/img/p_huang.png", new BMap.Size(55,45));
                   }else if(params.sex == "女"){
                       myIcon = new BMap.Icon("${ctx}/static/imges/img/p_hong.png", new BMap.Size(55,45));
                   }
                   //删除标注(防止重复)
                   removeMarker(point);
                   //添加标注
                   var marker = addMarker(point, myIcon, true, true, params.name);
                   //为标注绑定点击事件
                   addMarkerClick(content, marker);
               }
           }, "");
       }

       //批量逆地址解析
       var batchInverseAddressParse = function(){
           mapService.findMapData().then(
               function(result){
                   if(result.data) {
                       //清空显示结果的div
                       document.getElementById("result").innerHTML = "";
                       //循环验证及解析数据
                       for(var i = 0; i < result.data.length; i++){
                           var person = result.data[i];
                           var lng = person.mapY,
                               lat = person.mapX;
                           var point;
                           if(isNotEmpty(lng) && isNotEmpty(lat)){
                               point = new BMap.Point(lng, lat);
                           }
                           //生成地址
                           setTimeout(batchInverseGeocodeSearch(person.number, person.name, point), 600);
                       }
                   }
               }
           );
       }

       /**
        * 逆地址解析
        * @param point
        */
       function batchInverseGeocodeSearch(number, name, point){
           if(isEmpty(point)){
               document.getElementById("result").innerHTML += "[" + number + "]、" + name + "---->经纬度为空!</br>";
               return ;
           }
           myGeo.getLocation(point, function(rs){
               var addComp = rs.addressComponents;
               document.getElementById("result").innerHTML += "[" + number + "]、 经度(Y): " + point.lng + ", 纬度(X): " + point.lat + "： " + addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber + "<br/><br/>";
           });
       }
    </script>

</body>
</html>
