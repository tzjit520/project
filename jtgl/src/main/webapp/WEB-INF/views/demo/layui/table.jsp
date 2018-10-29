<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>LayUI</title>
<link rel="stylesheet" href="${ctx}/static/plugin/layui/css/layui.css" />
</head>

<body>
	<div class="layui-fluid">
		<fieldset class="layui-elem-field layui-field-title">
			<legend>数据表格</legend>
		</fieldset>
		<div class="layui-btn-group">
			<button class="layui-btn" data-type="getCheckData">获取选中行数据</button>
			<button class="layui-btn" data-type="getCheckLength">获取选中数目</button>
			<button class="layui-btn" data-type="isAll">验证是否全选</button>
		</div>

		<table id="test" lay-filter="test"></table>

		<script type="text/html" id="barDemo">
  			<a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
  			<a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
		</script>

		<script type="text/html" id="toolbarDemo">
  			<i class="layui-icon" data-type="add">&#xe654;</i>
  			<i class="layui-icon" data-type="delete">&#xe640;</i>
		</script>

		<script src="${ctx}/static/plugin/layui/layui.js"></script>

		<script type="text/javascript">
		layui.use('table', function(){
			  var table = layui.table;
			  
			  //渲染
			  table.render({
			    elem: '#test'
			    //,height: 350
			    ,url: '${ctx}/static/system/layui/json/table/demo1.json'
			    //,size: 'sm'
			    ,page: {
			      
			    }
			    ,limit: 30
			    ,toolbar: '#toolbarDemo'
			    ,cols: [[
			      {type: 'checkbox', fixed: 'left'}
			      ,{field:'id', title:'ID', fixed: 'left', unresize: true, sort: true}
			      ,{field:'username', title:'用户名', edit: 'text', templet: '#usernameTpl'}
			      ,{field:'email', title:'邮箱'}
			      ,{field:'sex', title:'性别', edit: 'text', sort: true}
			      ,{field:'city', title:'城市'}
			      ,{field:'sign', title:'签名'}
			      ,{field:'experience', title:'积分', sort: true}
			      ,{field:'ip', title:'IP'}
			      ,{field:'logins', title:'登入次数', sort: true}
			      ,{field:'joinTime', title:'加入时间'}
			      ,{fixed:'right', title:'操作', toolbar: '#barDemo'}
			    ]]
			  });
			  
			  //监听表格行点击
			  table.on('tr', function(obj){
			    console.log(obj)
			  });

			  //监听表格复选框选择
			  table.on('checkbox(test)', function(obj){
			    console.log(obj)
			  });

			  //监听工具条
			  table.on('tool(test)', function(obj){
			    var data = obj.data;
			    if(obj.event === 'del'){
			      layer.confirm('真的删除行么', function(index){
			        obj.del();
			        layer.close(index);
			      });
			    } else if(obj.event === 'edit'){
			      layer.prompt({
			        formType: 2
			        ,value: data.username
			      }, function(value, index){
			        obj.update({
			          username: value
			        });
			        layer.close(index);
			      });
			    }
			  });
			  
			  //监听排序
			  table.on('sort(test)', function(obj){
			    console.log(this, obj.field, obj.type)
			    
			    //return;
			    //服务端排序
			    table.reload('test', {
			      initSort: obj
			      //,page: {curr: 1} //重新从第一页开始
			      ,where: { //重新请求服务端
			        key: obj.field //排序字段
			        ,order: obj.type //排序方式
			      }
			    });
			  });
			  
			  var $ = layui.jquery, active = {
					    getCheckData: function(){
					      var checkStatus = table.checkStatus('test')
					      ,data = checkStatus.data;
					      layer.alert(JSON.stringify(data));
					    }
					    ,getCheckLength: function(){
					      var checkStatus = table.checkStatus('test')
					      ,data = checkStatus.data;
					      layer.msg('选中了：'+ data.length + ' 个');
					    }
					    ,isAll: function(){
					      var checkStatus = table.checkStatus('test');
					      layer.msg(checkStatus.isAll ? '全选': '未全选')
					    }
					    ,parseTable: function(){
					      table.init('parse-table-demo', {
					        limit: 3
					      });
					    }
					    ,add: function(){
					      table.addRow('test')
					    }
					    ,delete: function(){
					      layer.confirm('确认删除吗？', function(index){
					        table.deleteRow('test')
					        layer.close(index);
					      });
					    }
					  };
					  $('i').on('click', function(){
					    var type = $(this).data('type');
					    active[type] ? active[type].call(this) : '';
					  });
					  $('.layui-btn').on('click', function(){
					    var type = $(this).data('type');
					    active[type] ? active[type].call(this) : '';
					  });
			  
			});
		</script>
	</div>
</body>
</html>
