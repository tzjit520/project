<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java"  pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<%@ include file="/templates/include.jsp"%>
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>地理编码</title>
    <link rel="stylesheet" href="http://cache.amap.com/lbs/static/main1119.css"/>
    <script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=6cf74401bde6045cbb6bf91778d864fe&plugin=AMap.Geocoder"></script>
    <script type="text/javascript" src="http://cache.amap.com/lbs/static/addToolbar.js"></script>
    <style>
        input[type="text"] {
            height: 25px;
            outline: none;
            border: 0;
            border: 1px solid #CCCCCC;
            padding: 0 4px;
        }
     </style>
</head>	
<body>
	<div id="container"></div>
	<div class="button-group">
	    <input id="cityName"  placeholder="请输入城市的名称" type="text"/>
	    <input id="zdcs" class="button" value="到指定的城市" type="button"/>
	    <br/>
	    <input id="lngVal" class="inputtext" placeholder="请输入Lng" type="text" value="116.396574"/>
	    <input id="latVal" class="inputtext" placeholder="请输入Lat" type="text" value="39.992706"/>
	    <input id="jxdz" class="button" value="解析地址" type="button"/>
	    <br/>
	    <input id="address"  placeholder="请输入地址" type="text" value="上海市申波苑"/>
	    <input id="jxzb" class="button" value="解析坐标" type="button"/>
	</div>
	
	<div id="tip">
	    <span id="result"></span>
	</div> 
	<script type="text/javascript">
		$(function(){
			ajaxAddress();
			initAgent();
		})
	    var map = new AMap.Map("container", {
	        resizeEnable: true
	    });

		var mapGeocoder = new AMap.Geocoder({
            city: "150103", //城市，地理编码时，设置地址描述所在城市 可选值：城市名（中文或中文全拼）、citycode、adcode； 默认值：“全国”
            radius: 100, //逆地理编码时，以给定坐标为中心点，单位：米 取值范围：0-3000 默认值：1000
            extensions: "all" //逆地理编码时，返回信息的详略 默认值：base，返回基本地址信息； 取值为：all，返回地址信息及附近poi、道路、道路交叉口等信息
        });
		
		var adds = [];
		//查询数据库需要获取坐标的地址
		function ajaxAddress(){
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
		
		//鼠标点击获取经纬度
		map.on('click', function(e) {
			document.getElementById('lngVal').value = e.lnglat.getLng();
			document.getElementById('latVal').value = e.lnglat.getLat();
	    });
		 
	    //设置城市
	    AMap.event.addDomListener(document.getElementById('zdcs'), 'click', function() {
	        var cityName = document.getElementById('cityName').value;
	        if (!cityName) {
	            cityName = '北京市';
	        }
	        map.setCity(cityName);
	    });
	    
	  	//解析地址
	    AMap.event.addDomListener(document.getElementById('jxdz'), 'click', function() {
	        var lngVal = document.getElementById('lngVal').value;
	        var latVal = document.getElementById('latVal').value;
	        if (lngVal == "" || latVal == "") {
	        	$.messager.alert("提示", "请输入坐标！");
	        	return false;
	        }
	        regeocoder(lngVal, latVal);
	    });
	  
	    //根据坐标获取地址
	    function regeocoder(lngVal, latVal) {  //逆地理编码        
	    	mapGeocoder.getAddress([lngVal, latVal], function(status, result) {
	            if (status === 'complete' && result.info === 'OK') {
	            	var address = result.regeocode.formattedAddress; //返回地址描述
	            	//地理编码结果数组
	    	        var geocode = result.geocodes;
	            	resultStr += "<span style=\"font-size: 12px;padding:0px 0 4px 2px; border-bottom:1px solid #C1FFC1;\">" + 
		            "<b>地址</b>：" + address + "" + "&nbsp;&nbsp;<b>的地理编码结果是:</b><b>&nbsp;&nbsp;&nbsp;&nbsp;坐标</b>：" + 
		            lngVal + ", " + latVal + "" + "<b>&nbsp;&nbsp;&nbsp;&nbsp;匹配级别</b>：" + 
		            geocode[0].level + "&nbsp;&nbsp;区域："+ geocode[0].adcode + "</span>";
	    	        document.getElementById("result").innerHTML = address;
	            }
	        });        
	        var marker = new AMap.Marker({  //加点
	            map: map,
	            position: [lngVal, latVal]
	        });
	        map.setFitView();
	    }
	  
	  	//解析坐标
	    AMap.event.addDomListener(document.getElementById('jxzb'), 'click', function() {
	        var address = document.getElementById('address').value;
	        if (address == "") {
	            cityName = '北京市';
	        }
	      	//地理编码,返回地理编码结果
	        mapGeocoder.getLocation(address, function(status, result) {
	            if (status === 'complete' && result.info === 'OK') {
	            	//地理编码结果数组
	    	        var g = result.geocodes;
	    	        document.getElementById('lngVal').value = g[0].location.getLng();
	    			document.getElementById('latVal').value = g[0].location.getLat();
	                geocoder_CallBack(result);
	            }
	        });
	    });

		//初始化坐标
		function initAgent(){
			for( var i = 0 ; i < adds.length ; i++ ){
				var shopId = adds[i].shop_id;
	    		var address = adds[i].shop_addr;
	    		if(address != undefined && address != ""){
	    			setTimeout(geocoder(shopId, address,i),600);//生成坐标
	    		}
	    	}
		}
		
		//地址解析坐标
	    function geocoder(shopId, address, index) {
	        //地理编码,返回地理编码结果
	        mapGeocoder.getLocation(address, function(status, result) {
	            if (status === 'complete' && result.info === 'OK') {
	            	//地理编码结果数组
	    	        var g = result.geocodes;
	    	        //console.log("地址："+ address + "---坐标：" +g[0].location.getLng(),  g[0].location.getLat()+"--区域编码:"+g[0].adcode);
	    	        console.log("update ls_shop_dealer d set d.longitude = '"+ g[0].location.getLng() +"', d.latitude='"+ g[0].location.getLat() +"' where d.shop_id = "+shopId+";");
	    	        console.log("update ls_shop_detail d set d.areaid = "+ g[0].adcode +" where d.shop_id = "+shopId+";");
	            }
	        });
	    }
		
	    function addMarker(d) {
	        var marker = new AMap.Marker({
	            map: map,
	            position: [ d.location.getLng(),  d.location.getLat()]
	        });
	        var infoWindow = new AMap.InfoWindow({
	            content: d.formattedAddress,
	            offset: {x: 0, y: -30}
	        });
	        marker.on("mouseover", function(e) {
	            infoWindow.open(map, marker.getPosition());
	        });
	    }
	    
	    //地理编码返回结果展示
	    function geocoder_CallBack(data) {
	        var resultStr = "";
	        //地理编码结果数组
	        var geocode = data.geocodes;
	        for (var i = 0; i < geocode.length; i++) {
	            //拼接输出html
	            resultStr += "<span style=\"font-size: 12px;padding:0px 0 4px 2px; border-bottom:1px solid #C1FFC1;\">" + 
		            "<b>地址</b>：" + geocode[i].formattedAddress + "" + "&nbsp;&nbsp;<b>的地理编码结果是:</b><b>&nbsp;&nbsp;&nbsp;&nbsp;坐标</b>：" + 
		            geocode[i].location.getLng() + ", " + geocode[i].location.getLat() + "" + "<b>&nbsp;&nbsp;&nbsp;&nbsp;匹配级别</b>：" + 
		            geocode[i].level + "&nbsp;&nbsp;区域："+ geocode[0].adcode +"</span>";
	            addMarker(geocode[i]);
	        }
	        map.setFitView();
	        document.getElementById("result").innerHTML = resultStr;
	    }
	</script>
</body>	
	
</html>




