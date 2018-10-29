<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
	<title>转盘抽奖</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
	<link rel="stylesheet" href="${ctx}/static/css/draw/style.css">
    <script type="text/javascript" src="${ctx}/static/jquery/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/system/draw/awardRotate.js"></script>
</head>

<body>
	<div class="draw_left">
		<div>剩余抽奖次数：<span id="drequency">0</span></div>
		<br/>
		<div>累计获得的奖品>></div>
		<div id="prizes"></div>
	</div>
	<div class="draw_right">
		<div>抽奖记录>></div>
		<div id="drawResult" style="font-size:12px;overflow-y:auto;overflow-x:hidden;height: 400px;"></div>
	</div>
	<div class="draw_bottom"></div>
	<div class="banner">
	    <div class="turnplate" style="background-image:url(${ctx}/static/imges/draw/cj_bg.png);background-size:100% 100%;">
	        <canvas class="item" id="wheelcanvas" width="422px" height="422px"></canvas>
	        <img class="pointer" src="${ctx}/static/imges/draw/jt2.png"/>
	    </div>
	</div>
	<script type="text/javascript">
        var turnplate={
            restaraunts:[],				//大转盘奖品名称
            description:[],				//大转盘奖品描述
            colors:[],					//大转盘奖品区块对应背景颜色
            outsideRadius:192,			//大转盘外圆的半径
            textRadius:155,				//大转盘奖品位置距离圆心的距离
            insideRadius:68,			//大转盘内圆的半径
            startAngle:0,				//开始角度
            bRotate:false				//false:停止;ture:旋转
        };

        $(document).ready(function(){
        	//剩余次数
        	checkSurplusFrequency();
			//当前用户获得的奖品
        	getPrizes();
        	//查询所有抽奖结果
            getAllDrawResult();
        	
			//查询奖项对应的奖品信息  初始化转盘
        	$.ajax({
	    		url : "${ctx}/api/v1/draw/queryPrizeItem",
	    		type : 'get',
	    		data : {},
	    		async: false,
	    		success : function(result) {
	    			if(result.code == 0){
	    				//动态添加大转盘的奖品与奖品区域背景颜色
	    				for(var i = 0; i < result.data.length; i++){
	    					turnplate.restaraunts.push(result.data[i].prizeName);
	    					turnplate.description.push(result.data[i].itemName);
	    					if(i % 2 == 0){
	    						turnplate.colors.push("#96d3dc");
	    					}else{
	    						turnplate.colors.push("#FFFFFF");
	    					}
	    				}
	    				turnplate.restaraunts.push("谢谢抽奖");
    					turnplate.description.push("");
    					if(result.data.length % 2 == 0){
    						turnplate.colors.push("#96d3dc");
    					}else{
    						turnplate.colors.push("#FFFFFF");
    					}
	    			}
	    		}
            });
            //动态添加大转盘的奖品与奖品区域背景颜色
            //turnplate.restaraunts = ["特等奖", "一等奖", "二等奖", "三等奖", "四等奖", "五等奖", "幸运奖", "谢谢抽奖"];
            //turnplate.description = ["亲亲", "抱抱", "举高高", "喝酒", "真心话", "大冒险", "做运动", "再接再厉"];
            //turnplate.colors = ["#96d3dc","#FFFFFF", "#96d3dc", "#FFFFFF", "#96d3dc","#FFFFFF", "#96d3dc", "#FFFFFF" ];

            var rotateTimeOut = function (){
                $('#wheelcanvas').rotate({
                    angle:0,
                    animateTo:2160,
                    duration:8000,
                    callback:function (){
                        alert('网络超时，请检查您的网络设置！');
                    }
                });
            };

            //旋转转盘 item:奖品位置; txt：提示语;
            var rotateFn = function (item, txt){
            	var len = turnplate.restaraunts.length;
            	var angles = (item*(360/len)-(360/(len*2)));
                if(angles<270){
                    angles = 270 - angles;
                }else{
                    angles = 360 - angles + 270;
                }
                $(".draw_bottom").html("正在努力出奖....");
                $('#wheelcanvas').stopRotate();
                $('#wheelcanvas').rotate({
                    angle:0,
                    animateTo:angles+1800,
                    duration:8000,
                    callback:function (){
                    	var info = "很遗憾: 未中奖,再接再厉";
                    	if(txt != "谢谢抽奖"){
                    		info = "恭喜你: 获得【"+txt+"】";
                    		//当前用户获得的奖品
    	                	getPrizes();
    	                	//查询所有抽奖结果
    	                    getAllDrawResult();
                    	}
                        $(".draw_bottom").html(info);
                        turnplate.bRotate = !turnplate.bRotate;
                        //重新获取抽奖次数
	                    checkSurplusFrequency();
                    }
                });
            };

            $('.pointer').click(function (){
            	//清空抽奖结果
            	$(".draw_bottom").html("");
                //从后台获取奖项
                $.ajax({
		    		url : "${ctx}/api/v1/draw/luckDraw",
		    		type : 'get',
		    		data : {},
		    		error : function() {
		    			$(".draw_bottom").html("系统异常");
		    		},
		    		success : function(result) {
		    			if(result.code == 0){
		    				turnplate.bRotate = !turnplate.bRotate;
		    				//奖项名称   包含未中奖
		    				var prizeName = result.data;
		    				if(prizeName == "-1"){
		    					prizeName = "谢谢抽奖";
		    				}
		    				//获取随机数(奖品个数范围内)
		                    //var item = rnd(1,turnplate.restaraunts.length);
		    				var len = turnplate.restaraunts.length;
		    				var item = len;
		    				for(var i = 0; i < len; i++){
		    					if(prizeName == turnplate.restaraunts[i]){
		    						item = i+1;//拿到当前奖项的下标
		    						break;
		    					}
		    				}
		    				//奖品数量等于10,指针落在对应奖品区域的中心角度[252, 216, 180, 144, 108, 72, 36, 360, 324, 288]
		                    rotateFn(item, turnplate.restaraunts[item-1]);
		    			}else{
		    				$(".draw_bottom").html(result.message);
		    				if(turnplate.bRotate){
		                    	return;
		    				}
		    			}
		    		}
                });
            });
        });

        //查询剩余抽奖次数
        var checkSurplusFrequency = function(){
        	$.ajax({
	    		url : "${ctx}/api/v1/draw/checkSurplusFrequency",
	    		type : 'get',
	    		data : {},
	    		error : function() {
	    			$("#drequency").text(0);
	    		},
	    		success : function(result) {
	    			if(result.code == 0){
	    				$("#drequency").text(result.data);
	    			}else{
	    				$("#drequency").text(0);
	    			}
	    		}
            });
        }
        
      	//查询当前用户获得的奖品及数量
        var getPrizes = function(){
        	$.ajax({
	    		url : "${ctx}/api/v1/draw/queryPrize",
	    		type : 'get',
	    		data : {},
	    		success : function(result) {
    				$("#prizes").empty();
	    			if(result.code == 0){
	    				for(var i = 0; i < result.data.length; i++){
	    					$("#prizes").append("<br/><span>"+result.data[i].itemName+", 数量("+result.data[i].count+")</span><br/>");
	    				}
	    			}
	    		}
            });
        }
      	
      	//查询所有抽奖结果
        var getAllDrawResult = function(){
        	$.ajax({
	    		url : "${ctx}/api/v1/draw/queryAllDrawResult",
	    		type : 'get',
	    		data : {},
	    		success : function(result) {
    				$("#drawResult").empty();
	    			if(result.code == 0){
	    				for(var i = 0; i < result.data.length; i++){
	    					$("#drawResult").append("<br/><span>用户"+result.data[i].userName+"在"+formatDateTime(result.data[i].createDate)+"抽中了"+result.data[i].itemName+"</span><br/>");
	    				}
	    			}
	    		}
            });
        }
        
        function rnd(n, m){
            var random = Math.floor(Math.random()*(m-n+1)+n);
            console.log(random);
            return random;
        }

        //页面所有元素加载完毕后执行drawRouletteWheel()方法对转盘进行渲染
        window.onload=function(){
            drawRouletteWheel();
        }

        var formatDateTime = function(time) {    
	        var date = new Date(time);  
	        var y = date.getFullYear();    
	        var m = date.getMonth() + 1;    
	        m = m < 10 ? ('0' + m) : m;    
	        var d = date.getDate();    
	        d = d < 10 ? ('0' + d) : d;    
	        var h = date.getHours();  
	        h = h < 10 ? ('0' + h) : h;  
	        var minute = date.getMinutes();  
	        var second = date.getSeconds();  
	        minute = minute < 10 ? ('0' + minute) : minute;    
	        second = second < 10 ? ('0' + second) : second;   
	        return y + '-' + m + '-' + d+' '+h+':'+minute+':'+second;    
	    }; 
	    
        function drawRouletteWheel() {
            var canvas = document.getElementById("wheelcanvas");
            if (canvas.getContext) {
                //根据奖品个数计算圆周角度
                var arc = Math.PI / (turnplate.restaraunts.length/2);
                var ctx = canvas.getContext("2d");
                //在给定矩形内清空一个矩形
                ctx.clearRect(0,0,422,422);
                //strokeStyle 属性设置或返回用于笔触的颜色、渐变或模式
                ctx.strokeStyle = "#FFBE04";
                //font 属性设置或返回画布上文本内容的当前字体属性
                ctx.font = 'bold 20px Microsoft YaHei';
                for(var i = 0; i < turnplate.restaraunts.length; i++) {
                    var angle = turnplate.startAngle + i * arc;
                    ctx.fillStyle = turnplate.colors[i];
                    ctx.beginPath();
                    //arc(x,y,r,起始角,结束角,绘制方向) 方法创建弧/曲线（用于创建圆或部分圆）
                    ctx.arc(211, 211, turnplate.outsideRadius, angle, angle + arc, false);
                    ctx.arc(211, 211, turnplate.insideRadius, angle + arc, angle, true);
                    ctx.stroke();
                    ctx.fill();
                    //锁画布(为了保存之前的画布状态)
                    ctx.save();

                    //改变画布文字颜色
                    var b = i+2;
                    ctx.fillStyle = "#dc2873";

                    //----绘制奖品开始----


                    var text = turnplate.restaraunts[i];
                    var line_height = 17;
                    //translate方法重新映射画布上的 (0,0) 位置
                    ctx.translate(211 + Math.cos(angle + arc / 2) * turnplate.textRadius, 211 + Math.sin(angle + arc / 2) * turnplate.textRadius);

                    //rotate方法旋转当前的绘图
                    ctx.rotate(angle + arc / 2 + Math.PI / 2);

                    /** 下面代码根据奖品类型、奖品名称长度渲染不同效果，如字体、颜色、图片效果。(具体根据实际情况改变) **/
                    if (text.indexOf("谢谢抽奖") >= 0) {//谢谢抽奖
                        ctx.fillText(text, -ctx.measureText(text).width / 2, 25);
                    }else{
                        //在画布上绘制填色的文本。文本的默认颜色是黑色
                        //measureText()方法返回包含一个对象，该对象包含以像素计的指定字体宽度
                        ctx.fillText(text, -ctx.measureText(text).width / 2, 0);
                    }

                    ctx.font = '14px Microsoft YaHei';
                    //添加对应图标
                    if(text.indexOf(turnplate.restaraunts[0])>=0){
                        var texts = turnplate.description[0].split("||");
                        for(var j = 0; j<texts.length; j++){
                            if(j > 0){
                                line_height = line_height*1.2
                            }
                            ctx.fillText(texts[j], -ctx.measureText(texts[j]).width / 2, j * line_height + 25);
                        }
                    }
                    if(text.indexOf(turnplate.restaraunts[1])>=0){
                        var texts = turnplate.description[1].split("||");
                        for(var j = 0; j<texts.length; j++){
                            if(j > 0){
                                line_height = line_height*1.2
                            }
                            ctx.fillText(texts[j], -ctx.measureText(texts[j]).width / 2, j * line_height + 25);
                        }
                    }
                    if(text.indexOf(turnplate.restaraunts[2])>=0){
                        var texts = turnplate.description[2].split("||");
                        for(var j = 0; j<texts.length; j++){
                            if(j > 0){
                                line_height = line_height*1.2
                            }
                            ctx.fillText(texts[j], -ctx.measureText(texts[j]).width / 2, j * line_height + 25);
                        }
                    }
                    if(text.indexOf(turnplate.restaraunts[3])>=0){
                        var texts = turnplate.description[3].split("||");
                        for(var j = 0; j<texts.length; j++){
                            if(j > 0){
                                line_height = line_height*1.2
                            }
                            ctx.fillText(texts[j], -ctx.measureText(texts[j]).width / 2, j * line_height + 25);
                        }
                    }
                    if(text.indexOf(turnplate.restaraunts[4])>=0){
                        var texts = turnplate.description[4].split("||");
                        for(var j = 0; j<texts.length; j++){
                            if(j > 0){
                                line_height = line_height*1.2
                            }
                            ctx.fillText(texts[j], -ctx.measureText(texts[j]).width / 2, j * line_height + 25);
                        }
                    }
                    if(text.indexOf(turnplate.restaraunts[5])>=0){
                        var texts = turnplate.description[5].split("||");
                        for(var j = 0; j<texts.length; j++){
                            if(j > 0){
                                line_height = line_height*1.2
                            }
                            ctx.fillText(texts[j], -ctx.measureText(texts[j]).width / 2, j * line_height + 25);
                        }
                    }
                    if(text.indexOf(turnplate.restaraunts[6])>=0){
                        var texts = turnplate.description[6].split("||");
                        for(var j = 0; j<texts.length; j++){
                            if(j > 0){
                                line_height = line_height*1.2
                            }
                            ctx.fillText(texts[j], -ctx.measureText(texts[j]).width / 2, j * line_height + 25);
                        }
                    }

                    //把当前画布返回（调整）到上一个save()状态之前
                    ctx.restore();
                    //----绘制奖品结束----
                }
            }
        }

    </script>
</body>
</html>


