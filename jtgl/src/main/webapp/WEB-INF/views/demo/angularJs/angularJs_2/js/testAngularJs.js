var app = angular.module("myApp",[]);
app.controller("myCtrl1",function($scope,$location){
	$scope.myUrl = $location.absUrl();
})

app.controller("myCtrl2",function($scope,$http){
	$http.get("family/angularJs/angularJs_2/welcome.js").then(function(response){
		$scope.myWelcome = response.data;
	});
})

/***
 * 延时器
 */
app.controller("myCtrl3",function($scope,$timeout,$interval){
	var n = 5;
	$scope.myHeader = n + "秒后跳入主内容";
	$scope.timer = $interval(function(){			
		n--;
		$scope.myHeader = n + "秒后跳入主内容";
		if(n == 0){
			$interval.cancel($scope.timer);//停止计时器
		}
	},1000);
	/*** 
		$timeout(fn,[delay],[invokeApply]);	
		fn：一个将被延迟执行的函数。	
		delay：延迟的时间（毫秒）。	
		invokeApply：如果设置为false，则跳过脏值检测，否则将调用$apply。
	 */
	$timeout(function(){
		
		$scope.myHeader = "杰宝宝爱乖露露";
	},5000);
})

/***
 * 定时器
 */
app.controller("myCtrl4",function($scope,$interval){	
	$scope.myDate = formatDate();
	/***	 
	  	$interval(fn,delay,[count],[invokeApply],[Pass]);
		fn:一个将被反复执行的函数。		
		delay：每次调用的间隔毫秒数值。		
		count：循环次数的数值，如果没设置，则无限制循环。		
		invokeApply：如果设置为false，则避开脏值检查，否则将调用$apply。		
		Pass：函数的附加参数。
    */
	$interval(function(){
		$scope.myDate = formatDate();
	},1000)
})

/***
 * 自定义服务   服务名：myService1
 */
app.service("myService1",function(){
	this.getStr1 = function(type){
		if(type == "1")
			return "杰宝宝爱乖露露";
		if(type == "2")
			return "乖露露爱杰宝宝";
	}
});

app.filter("myFilter",['myService1',function(myService1){
	return function(type){
		return myService1.getStr1(type);
	}
}]);

/***
 * 调用自定义服务
 */
app.controller("myCtrl5",function($scope){
	$scope.str = 1;
	$scope.str1 = 2;
})

/***
 * 下拉框
 */
app.controller("myCtrl6",function($scope){
	$scope.selectData = [
	    {name:"谭志杰",value:"Tzj",parent:"男孩"},{name:"刘露",value:"ll",parent:"女孩"},
	    {name:"向雨晴",value:"Xyq",parent:"女孩"},{name:"向超凡",value:"Xcf",parent:"男孩"}
	];
	$scope.s = $scope.selectData[1].value;
	$scope.s1 = $scope.selectData[0].value;
	$scope.s3 = $scope.selectData[2].value;
});

/***
 * 表格
 */
app.controller("myTable",function($scope,$http){
	$http.get("family/angularJs/angularJs_2/listTestAngularJs.action").then(function(response){
		$scope.tableData = response.data;
	})
});


app.controller('myDate',function($scope, $parse) {
    $scope.today = new Date();
 });

app.filter("myFilterDate",function(){
	return function(val){
		return formatDate1(val);
	}
});


/***
 * ng-disabled 指令
 */
app.controller("myCtrl7",function($scope){	
	$scope.mySwitch = false;
})


/***
 * 隐藏 HTML 元素
 */
app.controller("myCtrl8",function($scope,$http){
	$http.get("family/angularJs/angularJs_2/listTestAngularJs.action").then(function(response){
		$scope.tableData = response.data;
	})
	$scope.bool = false;
	$scope.toggle = function(){
		$scope.bool = !$scope.bool;
	}
});

function formatDate1(val){
	var y = 1900 + parseInt(val.year);
	var m = parseInt(val.month) + 1 + "";
	if(m.length<2){
		m = "0" + m;
	}
	var d = val.date + "";
	if(d.length<2){
		d = "0" + d;
	}
	var h = val.hours + "";
	if(h.length<2){
		h = "0" + h;
	}
	var mi = val.minutes + "";
	if(mi.length<2){
		mi = "0" + mi;
	}
	var s = val.seconds + "";
	if(s.length<2){
		s = "0" + s;
	}
	//return y+"-"+m+"-"+d+" "+h+":"+mi+":"+s;
	return y+"-"+m+"-"+d;
}


/***
 * 格式化时间
 * @returns {String}
 */
function formatDate(){
	var date = new Date();
	var year = date.getFullYear();
	var month = date.getMonth() + 1;
	if(month < 10){ month = "0" + month; }
	var day = date.getDate();
	if(day < 10){ day = "0" + day; }
	var h = date.getHours();
	if(h < 10){ h = "0" + h; }
	var m = date.getMinutes();
	if(m < 10){ m = "0" + m; }
	var s = date.getSeconds();
	if(s < 10){ s = "0" + s; }
	
	var week;
    switch (date.getDay()){
	    case 1: week="星期一"; break;
	    case 2: week="星期二"; break;
	    case 3: week="星期三"; break;
	    case 4: week="星期四"; break;
	    case 5: week="星期五"; break;
	    case 6: week="星期六"; break;
	    default: week="星期天";
    }
	var str =  year + "年" + month + "月" + day + "日 " + h + "时" + m + "分" + s + "秒 " + week;
	return str;
}