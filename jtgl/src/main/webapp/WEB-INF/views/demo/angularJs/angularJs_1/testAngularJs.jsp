<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<%@ include file="/templates/include.jsp"%>
<html>
<head>
	<title>测试AngularJs</title>
	<script src="http://cdn.static.runoob.com/libs/angular.js/1.4.6/angular.min.js"></script>
	<style type="text/css">
		.ng-font{
			font-size:18px; 
			line-height:100%; 
			background:#fff text-align:center; 
			color:#333; 
			font-family:'宋体';
		}
		.div-line{
			float:left;
			width:1px;
			height:230px;
			background:#CDC8B1; 
		}
		.div-style{
			float:left;
			width:220px;
			height:auto;
			margin-left:15px;
		}
	</style>
</head>	
<body id="_right_panel_body" class="body_rightPanel">
	<input id="path" type="hidden" value="<%=path%>"/>
	<form method="post" id="updateForm">
		<input type="hidden" id="id" name="id"  />
	</form>
    <div id="wrapper" ng-app="myApp">
		<h1 style="margin-left:15px;">这是AngularJs小程序</h1>
    	<hr/>
   		<div style="width:100%;height:230px;">   		
	    	<!-- 简单的输入 -->
	    	<div class="div-style">
		    	<h2>简单的输入</h2>  
		        <h3 class="ng-font">在下面输入框中尝试输入</h3>	
                <input type="text" id="name" ng-model="name" style="width:200px;height:22px" />
		        <h3 class="ng-font">你输入的信息为:</h3>
		        <h4 class="ng-font">{{name}}</h4>  	
	    	</div>
	    	
	    	<!-- 分割线 -->
    		<div class="div-line"></div> 
    		   	
	    	<!-- 循环 -->
	    	<div class="div-style">
		    	<h2>AngularJs循环</h2>
				<label ng-init="listName=[{name:'付慧',sex:'女',age:20},{name:'谭志杰',sex:'男',age:24},{name:'未来宝宝',sex:'女',age:0}]"></label>		      
	        	<div ng-repeat="list in listName">
	        		<h4 class="ng-font">{{list.name}}，{{list.sex}}，{{list.age}}</h4>
	        	</div>				       	  	
	    	</div>

			<!-- 分割线 -->
    		<div class="div-line"></div> 
    		   	
	    	<!-- AngularJs表达式  -->
	    	<div class="div-style">
		    	<h2>AngularJs表达式</h2>
		    	<label ng-init="one=100;two=50"></label>		      
		    	<h3 class="ng-font">数字one: <input type="text" ng-model="one" style="width:100px;height:22px"></h3>				
		    	<h3 class="ng-font">数字two: <input type="text" ng-model="two" style="width:100px;height:22px"></h3>
	    	</div>
			<div style="float:left">
	        	<h4 class="ng-font">相加结果: {{one}} + {{two}} = {{one+two}}</h4>			       	  	
	        	<h4 class="ng-font">相减结果: {{one}} - {{two}} = {{one-two}}</h4>			       	  	
	        	<h4 class="ng-font">相乘结果: {{one}} * {{two}} = {{one*two}}</h4>			       	  	
	        	<h4 class="ng-font">相除结果: {{one}} / {{two}} = {{one/two}}</h4>			       	  	
			</div>	      
		</div>
			
		<!-- 分割线 -->
		<hr style="width:100%"/>
		
		<h1 style="margin-left:15px;">AngularJs指令</h1>
		<!-- 分割线 -->
		<hr style="width:100%"/>
		<div style="width:100%;height:230px;">   		
	    	<!-- 自定义的指令 -->
	    	<div class="div-style">
		    	<h2>自定义的指令</h2>  
		    	
		    	<h3><yuansu-directive></yuansu-directive></h3>  
		    	
		    	<h3><span property-directive></span></h3> 
		    	
		    	<!-- 
		    		注意： 你必须设置 restrict 的值为 "C" 才能通过类名来调用指令。 
		    	--> 
		    	<h3><span class="class-directive"></span></h3> 
		    	 
		    	<!-- 
		    		我们需要在该实例添加 replace 属性， 否则评论是不可见的。
					注意： 你必须设置 restrict 的值为 "M" 才能通过注释来调用指令。 
					template需要加标签
				-->
				<!-- directive: zhuShi-directive -->		    	 
	    	</div>

	   		<!-- 分割线 -->
	   		<div class="div-line"></div> 				
	    	<!-- AngularJs Scope(作用域) -->
	    	<div class="div-style" >
		    	<h2>$scope And $rootScope</h2>
		    	<div ng-controller="myCtrl1">
		    		<h3>{{name}}{{tName}}</h3>		    			
		    	</div> 
		    	<div ng-controller="myCtrl2">
		    		<h3>{{$root.tName}}love谭志杰</h3>
		    	</div> 		    	    			    	 
	    	</div>	
	    	
	    	<!-- 分割线 -->
	   		<div class="div-line"></div>   
	   		<!-- AngularJs 过滤器 -->
	   		<div ng-controller="myCtrl3">
	   			<div class="div-style" >
		    	<h2>AngularJs 过滤器</h2>
		    	<div>
		    		<!-- currency 格式化数字为货币格式  -->
		    		<h3>数字货币格式：{{price | currency}}</h3>
		    		<h3>字母转大写：{{name | uppercase}}</h3>
		    		<h3>字母转小写：{{name | lowercase}}</h3>
		    		<!-- 
		    			1.num ：你需要排序的数组
　　　　　　				2.x ：你需要根据哪个条件排序
　　　　　　				3.false ：正序还是倒序（boolean） 
					-->
		    		<h3>数字排序：<span ng-repeat="x in num | orderBy:x:false"> {{x}} </span></h3>
		    		<h3>字母排序：<span ng-repeat="x in zm | orderBy:x:true"> {{x}} </span></h3>	    			
		    	</div> 		    	    			    	 
	    	</div> 
	    	<div style="float:left">
	        	<h3>过滤排序：<input ng-model="n" style="width:50px"/></h3>
	    		<h3 ng-repeat="x in zlist | filter:n | orderBy:x.name:true">
	    			姓名：{{x.name}} 年龄：{{x.age}}<br/>
	    		</h3>		       	  	
			</div> 
	   		</div>
	    		
    	</div>
	    		    	
	</div>		
</body>	
<script type="text/javascript" src="<%=request.getContextPath()%>/family/angularJs/angularJs_1/js/testAngularJs.js?t=1"></script>
	
</html>