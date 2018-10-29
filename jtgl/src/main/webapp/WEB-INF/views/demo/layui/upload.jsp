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
			<legend>上传</legend>
		</fieldset>

		<form class="layui-form layui-form-pane1" action="" lay-filter="first" onsubmit="return false">
			<div class="layui-upload">
				<button type="button" class="layui-btn" id="test1">上传图片</button>

				<div class="layui-upload-list">
					<img class="layui-upload-img" src="" id="demo1" width="80" height="80">
					<p id="demoText"></p>
				</div>
			</div>

			<hr>

			<div class="layui-upload">
				<button type="button" class="layui-btn" id="test2">多图片上传</button>
				<div class="layui-upload-list" id="demo2"></div>
			</div>

			<hr>

			<div class="layui-upload">
				<button type="button" class="layui-btn layui-btn-normal" id="testList">选择多文件</button>
				<div class="layui-upload-list">
					<table class="layui-table">
						<thead>
							<tr>
								<th>文件名</th>
								<th>大小</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody id="demoList"></tbody>
					</table>
				</div>
				<button type="button" class="layui-btn" id="testListAction">开始上传</button>
			</div>

			<hr>

			<button type="button" class="layui-btn test333" lay-data="{size:1000,url:'a'}" id="test3">
				<i class="layui-icon">&#xe67c;</i>
				上传文件
			</button>
			<button type="button" class="layui-btn layui-btn-primary test333" lay-data="{size:2000,url:'b'}" id="test33">
				<i class="layui-icon">&#xe67c;</i>
				换个样式
			</button>

			<button type="button" class="layui-btn" id="test4">
				<i class="layui-icon">&#xe67c;</i>
				上传视频
			</button>
			<button type="button" class="layui-btn" id="test5">
				<i class="layui-icon">&#xe67c;</i>
				上传音频
			</button>

			<hr>

			<button class="layui-btn testm" lay-data="{url: '${ctx}/api/v1/file/upload'}">参数设在元素上</button>
			<button class="layui-btn testm" lay-data="{url: '${ctx}/api/v1/file/upload', accept: 'file',size:5}">参数设在元素上</button>

			<hr>

			<div class="layui-upload">
				<button type="button" class="layui-btn layui-btn-normal" id="test6">选择文件</button>
				<button type="button" class="layui-btn" id="test7">开始上传</button>
			</div>

			<hr>
			<br>

			<div class="layui-upload-drag" id="test9">
				<i class="layui-icon">&#xe67c;</i>
				<p>点击上传，或将文件拖拽到此处</p>
			</div>

			<hr>
			<br>
		</form>
	</div>
	<script src="${ctx}/static/plugin/layui/layui.js"></script>
	<script type="text/javascript">
		layui.use('upload', function(){
		  var $ = layui.jquery, upload = layui.upload;

		  var uploadInst = upload.render({
		    elem: '#test1'
		    ,url: '${ctx}/api/v1/file/upload'
		    ,size: 2000 //限制文件大小，单位 KB
		    ,accept: 'file'
		    ,fileAccept: 'image/*'
		    ,exts: "jpg|png|gif|bmp|jpeg|pdf"
		    ,data: { //额外参数
		      a: 1 ,b: function(){
		        return 2
		      }
		    }
		    ,choose: function(){
		      console.log(1)
		    }
		    ,before: function(obj){
		      //预读本地文件示例，不支持ie8
		      obj.preview(function(index, file, result){
		        $('#demo1').attr('src', result); //图片链接（base64）
		      });
		    }
		    ,done: function(res){
		      //如果上传失败
		      if(res.code > 0){
		        return layer.msg('上传失败');
		      }
		      //上传成功
		    }
		    ,error: function(){
		      //演示失败状态，并实现重传
		      var demoText = $('#demoText');
		      demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-mini demo-reload">重试</a>');
		      demoText.find('.demo-reload').on('click', function(){
		        uploadInst.upload();
		      });
		    }
		  });
		  
		  upload.render({
		    elem: '#test2'
		    ,url: '${ctx}/api/v1/file/upload'
		    ,multiple: true
		    ,number: 3
		    ,size: 1024
		    ,before: function(obj){
		      //预读本地文件示例，不支持ie8
		      obj.preview(function(index, file, result){
		        $('#demo2').append('<img src="'+ result +'" width="80" height="80" alt="'+ file.name +'" class="layui-upload-img">')
		      });
		    }
		    ,done: function(res){
		      //上传完毕
		    }
		    ,allDone: function(obj){
		      console.log(obj)
		    }
		  });
		  
		  //演示多文件列表
		  var demoListView = $('#demoList');
		  var uploadListIns = upload.render({
		    elem: '#testList'
		    ,url: '${ctx}/api/v1/file/upload'
		    ,accept: 'file'
		    ,multiple: true
		    ,number: 3
		    ,auto: false
		    ,bindAction: '#testListAction'
		    ,choose: function(obj){   
		      var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列

		      //读取本地文件
		      obj.preview(function(index, file, result){
		        var tr = $(['<tr id="upload-'+ index +'">'
		          ,'<td>'+ file.name +'</td>'
		          ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
		          ,'<td>等待上传</td>'
		          ,'<td>'
		            ,'<button class="layui-btn layui-btn-mini demo-reload layui-hide">重传</button>'
		            ,'<button class="layui-btn layui-btn-mini layui-btn-danger demo-delete">删除</button>'
		          ,'</td>'
		        ,'</tr>'].join(''));
		        
		        //单个重传
		        tr.find('.demo-reload').on('click', function(){
		          obj.upload(index, file);
		        });
		        
		        //删除
		        tr.find('.demo-delete').on('click', function(){
		          delete files[index]; //删除对应的文件
		          tr.remove();
		          uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
		        });
		        
		        demoListView.append(tr);
		      });
		    }
		    ,done: function(res, index, upload){
		      if(res.code == 0){ //上传成功
		        var tr = demoListView.find('tr#upload-'+ index)
		        ,tds = tr.children();
		        tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
		        tds.eq(3).html(''); //清空操作
		        delete this.files[index]; //删除文件队列已经上传成功的文件
		        return;
		      }
		      this.error(index, upload);
		    }
		    ,allDone: function(obj){
		      console.log(obj)
		    }
		    ,error: function(index, upload){
		      var tr = demoListView.find('tr#upload-'+ index)
		      ,tds = tr.children();
		      tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
		      tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
		    }
		  });
		  

		  upload.render({
		    elem: '.test333'
		    ,url: '${ctx}/api/v1/file/upload'
		    ,accept: 'file'
		    ,before: function(obj){
		      console.log(this.item);
		    }
		    ,done: function(res){
		      console.log(res)
		    }
		  });
		  
		  upload.render({
		    elem: '.testm'
		    ,done: function(res, index, upload){
		      //获取当前触发上传的元素，一般用于 elem 绑定 class 的情况，注意：此乃 layui 2.1.0 新增
		      var item = this.item;
		    }
		  })
		  
		  /*
		  upload.render({
		    elem: '#test33'
		    ,url: ''
		    ,accept: 'file'
		    ,done: function(res){
		      console.log(res)
		    }
		  });*/
		  
		  upload.render({
		    elem: '#test4'
		    ,url: '${ctx}/api/v1/file/uploadFile'
		    ,accept: 'video'
		    ,done: function(res){
		      console.log(res)
		    }
		  });
		  
		  upload.render({
		    elem: '#test5'
		    ,url: '${ctx}/api/v1/file/uploadFile'
		    ,accept: 'audio'
		    ,done: function(res){
		      console.log(res)
		    }
		  });
		  
		  
		  //手动上传
		  upload.render({
		    elem: '#test6'
		    ,url: '${ctx}/api/v1/file/upload'
		    ,auto: false
		    //,multiple: true
		    ,bindAction: '#test7'
		    ,choose: function(obj){   
		      var that = this;
		      obj.preview(function(index, file){
		        obj.resetFile(index, file, '123.jpg');
		      });
		    }
		    ,before: function(){
		      console.log(345);
		    }
		    ,done: function(res){
		      console.log(res);
		    }
		  });
		  
		  upload.render({
		    elem: '#test9',
		    url: '${ctx}/api/v1/file/upload',
		    done: function(res){
		      console.log(res);
		    }
		  });
		  
		});
	</script>
</body>
</html>
