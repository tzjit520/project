/** restrict 值可以是以下几种:
	E 作为元素名使用
	A 作为属性使用
	C 作为类名使用
	M 作为注释使用
	restrict 默认值为 EA, 即可以通过元素名和属性名来调用指令。
*/
var app = angular.module("myApp",[]);
app.directive("yuansuDirective",function(){
	return {
		restrict : "E",
		template:"这是以元素名调用指令"
	};
});
app.directive("propertyDirective",function(){
	return {
		restrict : "A",
		template:"这是以属性调用指令"
	};
});
app.directive("classDirective",function(){
	return {
		restrict : "C",
		template:"这是以类名调用指令"
	};
});
app.directive("zhuShiDirective", function() {
    return {
        restrict : "M",
        replace : true,
        template : "<h3>这是以注释调用指令</h3>"
    };
});

app.controller("myCtrl1",function($scope,$rootScope){
	$scope.name = "谭志杰love";
	$rootScope.tName = "乖露露";
});

app.controller("myCtrl2",function($scope,$rootScope){
	$scope.name = $rootScope.tName;
});

app.controller("myCtrl3",function($scope,$rootScope){
	$scope.price = 5.8;
	$scope.name = "dMo";
	$scope.num = [6,8,4,7,2,3];
	$scope.zm = ["g","c","d","a","j","m"];
	$scope.zlist = [{name:"a",age:18},{name:"c",age:20}];
});
