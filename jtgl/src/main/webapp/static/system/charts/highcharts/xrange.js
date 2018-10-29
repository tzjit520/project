$("#hcharts2").height(250);
Highcharts.setOptions({
    //colors: ['#FF9655', '#FFF263', '#DDDF00', '#DDDF00', '#24CBE5', '#64E572', '#FF9655', '#FFF263', '#6AF9C4'],
    plotOptions: {
    	series: {
    		turboThreshold: 0 //防止数据超过1000不显示
    	}
    },
	global: {
		useUTC: false
	},
	title: {
        style: {
    		color: '#6D869F',
			fontWeight: 'bold'
        } 
    },
    subtitle: { 
    	style: {
    		color: '#6D869F',
			fontWeight: 'bold'
        }
    }
});

$(function(){
	var resultData = [
  	  	{"x":1514736000000,"x2":1514761200000,"y":3},
  	  	{"x":1514761200000,"x2":1514766000000,"y":0},
  	  	{"x":1514766600000,"x2":1514777400000,"y":1},
  	  	{"x":1514777400000,"x2":1514784600000,"y":3},
  	  	{"x":1514784600000,"x2":1514797200000,"y":1},
  	  	{"x":1514797200000,"x2":1514800800000,"y":0},
  	  	{"x":1514800800000,"x2":1514806200000,"y":2},
  	  	{"x":1514806200000,"x2":1514817000000,"y":4},
  	  	{"x":1514817000000,"x2":1514822400000,"y":3}
    ];
 	var minTime = 1514736000000;
 	var maxTime = 1514822340000;
 	//初始化图形数据
 	initData(resultData, minTime, maxTime);
})

var time = 1000*60*5;//5分钟

//初始化图形数据
function initData(resultData, minTime, maxTime){
	var categoriesArray = ["地铁", "工作", "家务", "休息", "家庭"];
	var seriesArray = [];
	for(var c = 0; c < categoriesArray.length; c++){
		var series = {};
 		series.name = categoriesArray[c];
 		series.pointWidth = 20;
 		//填充数据
 		var dataArray = [];
		for(var i = 0; i < resultData.length; i++){
			var data = resultData[i];
			if(data.y == c){
				//这一句加额外时间  只为显示直观
				data.x2 = data.x2 + time;
 				dataArray.push(data);
			}
		}
		series.data = dataArray;
		seriesArray.push(series);
	}
	//填充图形数据并加载
	initXrange(seriesArray, categoriesArray, minTime, maxTime)
}

//填充图形数据并加载
function initXrange(seriesArray, categoriesArray, minTime, maxTime){
	chart = new Highcharts.Chart({
		chart: {
			renderTo: 'hcharts2',
			type: 'xrange'
		},
		title: {
            text: ''
        },
        subtitle: { 
            text: ''
        }, 
		xAxis: {
			type: 'datetime',
			dateTimeLabelFormats: {
				day : '%Y-%m-%d',
            	month : '%Y-%m-%d',
            	year : '%Y-%m-%d'
            },
            min: minTime,
            max: maxTime,
            tickInterval: 1000*60*60*5,
            lineWidth: 2 //基线宽度 
		},
		yAxis: {
			title: {
				text: ''
			},
			categories: categoriesArray,
			reversed: true,//反转
			//opposite: true,//对立面显示
			lineWidth:1
		},
		tooltip: {
			formatter: function () {
				var t1 = formatDate(this.x);
				var t2 = formatDate(this.x2-time);
				return '<b>'+t1+'至'+t2+'</b><br/>'+this.point.series.name;
			}
		},
		legend: { 
            enabled: false  //设置图例不可见 
        }, 
		credits: { //图表版权信息
            enabled: false
        }, 
        plotOptions: {
	    	xrange: {
	    		grouping: false //是否将非堆叠列分组或使它们彼此独立地呈现,非分组列将单独布局并相互重叠
	    	}
	    },
		series: seriesArray
	});
}

//时间格式化
function formatDate(time){
	var d = new Date();
	d.setTime(time);
	var year = d.getFullYear();
	var month = (d.getMonth() + 1) < 10 ? "0" + (d.getMonth()+1) : d.getMonth()+1;		
	var day = d.getDate() < 10 ? "0" + d.getDate() : d.getDate();
	var hours = d.getHours() < 10 ? "0" + d.getHours() : d.getHours();
	var minutes = d.getMinutes() < 10 ? "0" + d.getMinutes() : d.getMinutes();
	var seconds = d.getSeconds() < 10 ? "0" + d.getSeconds() : d.getSeconds();
	return year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" + seconds;						
}

/*String jsonData = "";
String bdate = "2018-01-01 00:00:00", edate = "2018-01-01 07:00:00";
jsonData += "{\"x\":"+ sdf.parse(bdate).getTime() +",\"x2\":"+ sdf.parse(edate).getTime() +",\"y\":"+ 4 +"},";

bdate = "2018-01-01 07:00:00"; edate = "2018-01-01 08:20:00";
jsonData += "{\"x\":"+ sdf.parse(bdate).getTime() +",\"x2\":"+ sdf.parse(edate).getTime() +",\"y\":"+ 1 +"},";

bdate = "2018-01-01 08:30:00"; edate = "2018-01-01 11:30:00";
jsonData += "{\"x\":"+ sdf.parse(bdate).getTime() +",\"x2\":"+ sdf.parse(edate).getTime() +",\"y\":"+ 2 +"},";
//
bdate = "2018-01-01 11:30:00"; edate = "2018-01-01 13:30:00";
jsonData += "{\"x\":"+ sdf.parse(bdate).getTime() +",\"x2\":"+ sdf.parse(edate).getTime() +",\"y\":"+ 4 +"},";

bdate = "2018-01-01 13:30:00"; edate = "2018-01-01 17:00:00";
jsonData += "{\"x\":"+ sdf.parse(bdate).getTime() +",\"x2\":"+ sdf.parse(edate).getTime() +",\"y\":"+ 2 +"},";

bdate = "2018-01-01 17:00:00"; edate = "2018-01-01 18:00:00";
jsonData += "{\"x\":"+ sdf.parse(bdate).getTime() +",\"x2\":"+ sdf.parse(edate).getTime() +",\"y\":"+ 1 +"},";

bdate = "2018-01-01 18:00:00"; edate = "2018-01-01 19:30:00";
jsonData += "{\"x\":"+ sdf.parse(bdate).getTime() +",\"x2\":"+ sdf.parse(edate).getTime() +",\"y\":"+ 3 +"},";

bdate = "2018-01-01 19:30:00"; edate = "2018-01-01 22:30:00";
jsonData += "{\"x\":"+ sdf.parse(bdate).getTime() +",\"x2\":"+ sdf.parse(edate).getTime() +",\"y\":"+ 5 +"},";

bdate = "2018-01-01 22:30:00"; edate = "2018-01-02 00:00:00";
jsonData += "{\"x\":"+ sdf.parse(bdate).getTime() +",\"x2\":"+ sdf.parse(edate).getTime() +",\"y\":"+ 4 +"}";

String json = "[" +jsonData +"]";
System.out.println(json);*/