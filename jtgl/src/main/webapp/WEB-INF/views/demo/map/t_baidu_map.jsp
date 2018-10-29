<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<%@ include file="/templates/include.jsp"%>

<html>
	<head>
		<title>百度地图地址解析坐标</title>
	</head>	
	<link rel="stylesheet" href="css/style.css">
	<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=x2SVorYNX5WcawbfUnpOyPpK"></script>
	<link rel="stylesheet" type="text/css" href="<%=path%>/family/map/css/style.css" media="screen" />
	<link rel="stylesheet" type="text/css" href="<%=path%>/css/fd.css" media="screen" />
	<style type="text/css">
		body, html{width: 100%;height: 100%;margin:0;font-family:"微软雅黑";}
		#allmap{height:100%;width:100%;}
		#r-result{width:100%;}
		.anchorBL{display:none;}
		.titleClass{margin-top:10px;background-color:#8F52C8;color:#FFFFFF;}
		.nrClass{}
	</style>
	<link rel="stylesheet" href="css/editor.css">
	<body id="_right_panel_body" class="body_rightPanel">
		<input id="path" type="hidden" value="<%=path%>"/>
		<div id="panel">
	        <input type="button" value="批量地址解析" onclick="initAgent()" />
	        <div id="pil">
	        
	        </div>
    	</div>
		<div id="container">
	        <div id="allmap"></div>
	    </div>	
	</body>	
	<script type="text/javascript">
		// 百度地图API功能
		var map = new BMap.Map("allmap", {enableMapClick:false});
		
		map.addControl(new BMap.NavigationControl());// 添加平移缩放控件
		map.addControl(new BMap.OverviewMapControl());  //添加地图类型控件
		map.enableScrollWheelZoom();  //启用滚轮放大缩小
		var top_left_control = new BMap.ScaleControl({anchor: BMAP_ANCHOR_BOTTOM_RIGHT});// 左上角，添加比例尺
		map.addControl(top_left_control);
		//定位初始地点
		var point = new BMap.Point(106.560615,29.563709);
		map.centerAndZoom(point, 12);


		//终端信息数组
		var adds = [];
		function ajaxAgent(){
			$.ajax({
				url:'${ctx}/family/demo/listLsShopDetail.action',
			    type:'get',
			    data:{},
			    async: false,
			    success:function(data){
			    	adds = eval("("+ data +")");
			    }
			}); 
		}
		ajaxAgent();
		
		//初始化坐标
		function initAgent(){
			for( var i = 0 ; i < adds.length ; i++ ){
				var franchiseId = adds[i].franchiseId;//id
	    		var address = adds[i].address;//地址
	    		var fnumber = adds[i].fnumber;//编号
	    		if(address != undefined && address != ""){
	    			setTimeout(geocodeSearch(franchiseId, address,fnumber),600);//生成坐标
	    		}
	    	}
		}
		
		var myGeo = new BMap.Geocoder();
		function geocodeSearch(franchiseId,address,fnumber){
			if(address==''){
				console.log(fnumber +"地址为空");
				return ;
			}else{
				myGeo.getPoint(address, function(point){
					if (point) {
						var p = point.lng+","+point.lat;
						//定位
						var point = new BMap.Point(point.lng, point.lat);
						//map.centerAndZoom(point, 12);
						//添加标注
						//addMarker(point,new BMap.Label(address,{offset:new BMap.Size(20,-10)}));
						
						//获取省市区
						myGeo.getLocation(point, function(rs){
							var province = '',city = '',area = '';
							var addComp = rs.addressComponents;
							province = addComp.province;//省
							city = addComp.city;//市
							area = addComp.district;//区
							//addComp.street;//什么路
							//addComp.streetNumber;//多少号
							console.log("update t_franchise set map_x='"+point.lng+"', map_y='"+point.lat+"', province='"+province+"', city='"+city+"', area='"+area+"', franchise_level=5,created_by=1,creation_date=now(),last_updated_by=1,last_update_date=now(),deleted=0 where franchise_number='"+fnumber+"' and franchise_id="+franchiseId+";");
						});  
					}else{
						console.log(fnumber +"地址解析失败");
					}
				}, "");
			}
		}
		
		// 编写自定义函数,创建标注
		function addMarker(point,label){
			var marker = new BMap.Marker(point);
			map.addOverlay(marker);
			marker.setLabel(label);
		}
		
		map.addEventListener("click", function(e){        
			var point = e.point;
			myGeo.getLocation(point, function(rs){
				var local = [];
				var addComp = rs.addressComponents;
				local.push(addComp.province);
				local.push(addComp.city);
				local.push(addComp.district);
				local.push(addComp.street);
				local.push(addComp.streetNumber);
				console.log(local);
				alert(local.toString());
			});
		});
	</script>
</html>




