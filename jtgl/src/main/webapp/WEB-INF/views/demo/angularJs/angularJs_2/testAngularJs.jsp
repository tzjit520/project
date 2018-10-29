<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<%@ include file="/templates/include.jsp"%>
<html>
<head>
	<title>AngularJs服务</title>
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
			// float:left;
			width:auto;
			height:auto;
			margin-left:15px;
		}
		table, th , td {
		  border: 1px solid grey;
		  border-collapse: collapse;
		  padding: 5px;
		}
		table tr:nth-child(odd) {
		  background-color: #f1f1f1;
		}
		table tr:nth-child(even) {
		  background-color: #ffffff;
		}
	</style>
</head>	
<body id="_right_panel_body" class="body_rightPanel">	
    <div id="wrapper" ng-app="myApp">
		<h1 style="margin-left:15px;">AngularJs服务</h1>
		<div>
			<div style="width:100%;height:auto;">   		
		    	<!-- 返回当前页面URL -->
		    	<div class="div-style" ng-controller="myCtrl1">
			    	<h3>返回当前页面URL ： {{myUrl}}</h3>  
		    	</div>
	    	</div>
	    	
	    	<div style="width:100%;height:auto;">   		
		    	<!-- 使用 $http 服务向服务器请求数据 -->
		    	<div class="div-style" ng-controller="myCtrl2">
			    	<h3>http请求内容：{{myWelcome}}</h3>  
		    	</div>
	    	</div>
    		  		
    		<div style="width:100%;height:auto;">   		
		    	<!-- 使用延时器 -->
		    	<div class="div-style" ng-controller="myCtrl3">
			    	<h3>延时器：{{myHeader}}</h3>  
		    	</div>
	    	</div>
	    	
	    	<div style="width:100%;height:auto;">   		
		    	<!-- 使用定时器 -->
		    	<div class="div-style" ng-controller="myCtrl4">
			    	<h3>定时器：现在是北京时间：{{myDate}}</h3>  
		    	</div>
	    	</div>
	    	
	    	<div style="width:100%;height:auto;">   		
		    	<!-- 自定义服务 -->
		    	<div class="div-style" ng-controller="myCtrl5">
			    	<h3>自定义服务：{{str | myFilter}} &nbsp; {{str1 | myFilter}}</h3>  
		    	</div>
	    	</div>
	    	
	    	<div style="width:100%;height:auto;" ng-controller="myCtrl6">   		
		    	<!-- 
			    	下拉框(选择的是对象) 
			    	使用 ng-options 指令，选择的值是一个对象：
		    	-->
		    	<div class="div-style">
			    	<h3>
				    	下拉框(选择的是对象)：
				    	<select ng-model="s" ng-options="s.value as s.name for s in selectData" style="width:80px;height:22px">
				    	</select>
				    	&nbsp;{{s}}
			    	</h3>  
		    	</div>
		    	<!-- 
			    	  下拉框(选择的是字符串)
			    	 ng-repeat 指令来创建下拉列表，选中的值是一个字符串
		    	-->
		    	<div class="div-style">
			    	<h3>
				    	下拉框(选择的是字符串)：
				    	<select ng-model="s1" style="width:80px;height:22px">
				    		<option value="">请选择</option>
				    		<option ng-repeat="s1 in selectData" value="{{s1.value}}">{{s1.name}}</option>
				    	</select>
				    	&nbsp; {{s1}}
			    	</h3>  
		    	</div>
		    	
		    	<!-- 
			    	  分组下拉框(选择的是字符串)
			    	 ng-repeat 指令来创建下拉列表，选中的值是一个字符串
		    	-->
		    	<div class="div-style">
			    	<h3>
				    	分组下拉框(选择的是字符串)：
				    	<select ng-model="s3" ng-options="v.value as v.name group by v.parent for (k,v) in selectData" style="width:80px;height:22px">
				    	</select>
				    	&nbsp; {{s3}}
			    	</h3>  
		    	</div>
		    	
		    	<select id="selectbox" name=""></select>
		    	<script type="text/javascript">
			    	var d = [
						{ id: 19, pid: 0, name: 'nodejs',
							 children:[
							   { id: 20, pid: 19, name: 'express',children:[{ id: 60, pid: 20, name: 'ejs' }]},
							   { id: 21, pid: 19, name: 'mongodb' }
							   ]
							},
							{ id: 59, pid: 0, name: '前端开发',
							 children:[
							  { id: 70, pid: 59, name: 'javascript' },
							  { id: 71, pid: 59, name: 'css' },
							  { id: 72, pid: 59, name: 'html' },
							  { id: 73, pid: 59, name: 'bootstrap' }
							   ]
							},
							{ id: 61, pid: 0, name: '视觉设计',children:[{ id: 63, pid: 61, name: '网页设计' }]}
							
						];
			    	
			    	
			    	//js脚本，递归生成
			    	//获取容器对象
			    	var selectbox=document.getElementById("selectbox");
			    	 
			    	//生成树下拉菜单
			    	var j="-";//前缀符号，用于显示父子关系，这里可以使用其它符号
			    	function creatSelectTree(d){
			    	 var option="";
			    	 for(var i=0;i<d.length;i++){
			    	 if(d[i].children.length){//如果有子集
			    	  option+="<option value='"+d[i].id+"'>"+j+d[i].name+"</option>";
			    	 j+="-";//前缀符号加一个符号
			    	  option+=creatSelectTree(d[i].children);//递归调用子集
			    	 j=j.slice(0,j.length-1);//每次递归结束返回上级时，前缀符号需要减一个符号
			    	  }else{//没有子集直接显示
			    	  option+="<option value='"+d[i].id+"'>"+j+d[i].name+"</option>";
			    	  }
			    	  }
			    	 return option;//返回最终html结果
			    	 }
			    	 
			    	//调用函数，并将结构出入到下拉框容器中
			    	selectbox.innerHTML=creatSelectTree(tree);
		    	</script>
		    	
		    	<div style="width:100%;height:auto;">   		
			    	<!-- 格式化日期 -->
			    	<div class="div-style" ng-controller="myDate">
				    	<h3>格式化日期(yyyy-MM-dd)：{{today | date:'yyyy-MM-dd'}}</h3>
				    	<h3>格式化日期(yyyy-MM-dd HH:mm:ss)：{{today | date:'yyyy-MM-dd HH:mm:ss'}}</h3>
				    	<h3>格式化日期(yyyy年MM月dd日  HH时mm分ss秒)：{{today | date:'yyyy年MM月dd日  HH时mm分ss秒'}}</h3>
				    	
				    	<h3>格式化日期(yyyy-MM-dd HH:mm:ss EEEE)：{{today | date:'yyyy-MM-dd HH:mm:ss EEEE'}}</h3>
			    	</div>
		    	</div>
		    	
		    	<!--  表格     -->
		    	<div class="div-style">
			    	<h3>表格</h3>
			    	<table ng-controller="myTable">
			    		<tr>
			    			<th>行号</th>
			    			<th>姓名</th>
			    			<th>性别</th>
			    			<th>年龄</th>
			    			<th>身高</th>
			    			<th>体重</th>
			    			<th>生日</th>
			    			<th>描述</th>
			    			<th>职业</th>
			    		</tr>
			    		<tr ng-repeat="row in tableData.rows | orderBy:age:true">
			    			<th>{{$index + 1}}</th>
			    			<td>{{row.name}}</td>
			    			<td>{{row.sex}}</td>
			    			<td>{{row.age}}</td>
			    			<td>{{row.height}}</td>
			    			<td>{{row.weight}}</td>
			    			<td>{{row.birthday | myFilterDate}}</td>
			    			<td>{{row.desc}}</td>
			    			<td>{{row.position.pname}}</td>			    			
			    		</tr>
			    	</table> 
		    	</div>
		    	
		    	<div style="width:100%;height:auto;">   		
			    	<!-- ng-disabled 指令 -->
			    	<div class="div-style" ng-controller="myCtrl7">
				    	<h3>ng-disabled 指令：
					    	<button ng-disabled="mySwitch">
						    	<span ng-if="!mySwitch">可以点我</span>
						    	<span ng-if="mySwitch">不能点了</span>
					    	</button>				    		
				    		&nbsp;
				    		状态：
				    		<span ng-if="mySwitch">禁用</span>
				    		<span ng-if="!mySwitch">正常</span>
				    		&nbsp;
				    		<input type="checkbox" ng-model="mySwitch">按钮
				    	</h3> 
				    	
				    	<h3>ng-show 指令：
					    	<span ng-show="!mySwitch">我是乖露露，我爱杰宝宝</span>
					    	<span ng-show="mySwitch">我是杰宝宝，我爱乖露露</span>
					    	&nbsp;
					    	<!-- 可以使用表达式来计算布尔值（ true 或 false） -->
					    	<span ng-show="1 == 1">I LOVE YOU ♥</span>					    	
				    		&nbsp;
				    		<input type="checkbox" ng-model="mySwitch">按钮
				    	</h3> 
				    	
				    	<h3>ng-hide 指令：
					    	<span ng-hide="mySwitch">我是乖露露，我的老公是杰宝宝</span>
					    	<span ng-hide="!mySwitch">我是杰宝宝，我的老婆是乖露露</span>
					    	&nbsp;
					    	<!-- 可以使用表达式来计算布尔值（ true 或 false） -->
					    	<span ng-hide="1 == 2">I LOVE YOU ♥</span>					    	
				    		&nbsp;
				    		<input type="checkbox" ng-model="mySwitch">按钮
				    	</h3>
				    	
				    	<h3 ng-init="count=0">ng-click 指令：
					    	<button ng-click="count = count + 1">点我加</button>				    		
				    		&nbsp;
				    		目前数值为：{{count}}
				    		&nbsp;
				    		<button ng-click="count = count - 1">点我减</button>				    						    		
				    	</h3>
			    	</div>
		    	</div>
		    	
		    	<div style="width:100%;height:auto;">   		
			    	<!-- 隐藏 HTML 元素 -->
			    	<div class="div-style" ng-controller="myCtrl8">				    	
				    	<h3>隐藏 HTML 元素：<button ng-click="toggle()">隐藏/显示</button></h3> 				    	
			    		<table ng-hide="bool">
				    		<tr>
				    			<th>行号</th><th>姓名</th><th>性别</th>
				    			<th>年龄</th><th>身高</th><th>体重</th>
				    			<th>生日</th><th>描述</th><th>职业</th>
				    		</tr>
				    		<tr ng-repeat="row in tableData.rows | orderBy:age:true">
				    			<th>{{$index + 1}}</th>
				    			<td>{{row.name}}</td>
				    			<td>{{row.sex}}</td>
				    			<td>{{row.age}}</td>
				    			<td>{{row.height}}</td>
				    			<td>{{row.weight}}</td>
				    			<td>{{row.birthday | myFilterDate}}</td>
				    			<td>{{row.desc}}</td>
				    			<td>{{row.position.pname}}</td>			    			
				    		</tr>
				    	</table>
			    	</div>
		    	</div>
		    	
	    	</div>
		</div>    	    	
	</div>		
</body>	
<script type="text/javascript" src="<%=request.getContextPath()%>/family/angularJs/angularJs_2/js/testAngularJs.js?t=1"></script>
	
</html>