$("#hcharts1").height(250);
//设置默认颜色
Highcharts.setOptions({
    //colors: ['#FF9655', '#B23AEE', '#CD4F39', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
	global: { 
		useUTC: false 
	}
});

var chart1;
$(function () {
	//ajax查询数据
	queryData();
});

//查询数据
function queryData(){
	createGraph();
}

function createGraph(){
	chart1 = new Highcharts.Chart({ 
        chart: { 
            renderTo: 'hcharts1', //图表放置的容器，DIV 
            defaultSeriesType: 'spline', //图表类型为曲线图 
            events: { 
                load: function() {  
                    var series = this.get('qq'); 
                    var series1 = this.get('weixin'); 
                    var series2 = this.get('eclipse'); 
                    //每隔5秒钟，图表更新一次，y数据值在0-100之间的随机数 
                    setInterval(function() { 
                        var x = (new Date()).getTime(), // 当前时间 
                        y = Math.random()*20;  
                        y1 = Math.random()*40;  
                        y2 = Math.random()*70;  
                        series.addPoint([x, y], true, true); 
                        series1.addPoint([x, y1], true, true); 
                        series2.addPoint([x, y2], true, true); 
                    }, 
                    3000); 
                } 
            } 
        }, 
        title: { 
        	text: ''/*'CPU使用情况'*/,
            style: {//标题样式。用于设置文字颜色、字体、字号，但是字体的对齐则使用algin、x和y元素。默认是： { "color": "#333333", "fontSize": "18px" } 默认是：[object Object].
        		color: '#6D869F',
				fontWeight: 'bold'
            }
        }, 
        xAxis: { //设置X轴 
            type: 'datetime',  //X轴为日期时间类型 
            /*title: {//坐标轴标题，显示在轴线旁。
          		align: 'middle',//String 轴标题相对于轴值的对齐方式。可能的值是“low”，“middle”或“high”。 默认是：middle
          		text: '这是坐标轴(X)标题',//String 轴标题的显示文本。它可以包含类似的，基本的HTML标签
          		margin: 5,//Number 轴标题距离轴值或者轴线的像素值。水平轴默认为0，垂直轴默认为10
          		offset: 40,//Number 轴标题到轴线的距离
          		rotation: 0,//Number 轴标题的旋转角度，水平轴默认为0度，垂直轴默认为270度。 默认是：0
          		style: {//CSSObject 轴标题的CSS样式。然而轴标题的旋转是使用矢量图形渲染技术实现的，并不是所有的样式都是可使用的。 默认是：[object Object]
          			color: '#6D869F',
					fontWeight: 'bold'
          		}
          	},*/
          	lineWidth: 2, //基线宽度 
            tickPixelInterval: 150  //X轴标签间隔 
        }, 
        yAxis: { //设置Y轴 
            max: 100, //Y轴最大值 
            min: 0,  //Y轴最小值 
            title: {
                text: ''/*'单位：( GHz )'*/,
                style: {
                    color: Highcharts.getOptions().colors[0]
                }
            },
            lineWidth: 2 //基线宽度 
        }, 
        tooltip: {//当鼠标悬置数据点时的提示框 
            formatter: function() { //格式化提示信息 
            	if(this.y > 60){
	                return '<font style="font-size:14px;color:#A020F0">' + Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '</font><br/><font style="font-size:14px;color:#CD0000">' + this.series.name +
	                	   ' 占用：' + Highcharts.numberFormat(this.y, 2)+'%</font>'; 
            	}else{
	                return '<font style="font-size:14px;color:#A020F0">' + Highcharts.dateFormat('%Y-%m-%d %H:%M:%S', this.x) + '</font><br/><font style="font-size:14px;color:#436EEE">' + this.series.name +
	                	   ' 占用：' + Highcharts.numberFormat(this.y, 2)+'%</font>'; 
            	}
            }
        }, 
        legend: { 
            enabled: false  //设置图例不可见 
        }, 
        credits: { //图表版权信息
            enabled: false//是否显示版权信息。通过设置为false即可禁用版权信息。 默认是：true.
        }, 
        series: [{ 
        	name: 'CPU使用情况 (QQ)',
        	id: 'qq',
            data: (function() { //设置默认数据， 
                var data = [], 
                time = (new Date()).getTime(), 
                i; 
                for (i = -5; i <= 0; i++) { 
                    data.push({
                        x: time + i * 3000,  
                        y: Math.random()*70 
                    }); 
                } 
                return data; 
            })() 
        },{ 
        	name: 'CPU使用情况 (微信)',
        	id: 'weixin',
            data: (function() { //设置默认数据， 
                var data = [], 
                time = (new Date()).getTime(), 
                i; 
                for (i = -5; i <= 0; i++) { 
                    data.push({
                        x: time + i * 3000,  
                        y: Math.random()*50 
                    }); 
                } 
                return data; 
            })() 
        },{ 
        	name: 'CPU使用情况 (eclipse)',
        	id: 'eclipse',
            data: (function() { //设置默认数据， 
                var data = [], 
                time = (new Date()).getTime(), 
                i; 
                for (i = -5; i <= 0; i++) { 
                    data.push({
                        x: time + i * 3000,  
                        y: Math.random()*60 
                    }); 
                } 
                return data; 
            })() 
        }] 
    }); 
}