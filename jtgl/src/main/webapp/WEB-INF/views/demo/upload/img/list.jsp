<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>上传</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">图片上传</h1><hr/>
			</div>
			<div class="panel-body">
				<form id="fileupload" name="fileupload" action="${ctx}/api/v1/file/upload" method="POST" enctype="multipart/form-data" class="form-horizontal group-border hover-stripped">
					<div class="form-group">
						<div class="col-xs-5">
							<span class="btn btn-success fileinput-button">
								<i class="en-plus3"></i>
								<span>选择图片</span>
								<span id="fileInput">
									<input type="file" id="file" name="files[]" multiple>
								</span>
							</span>
							<button type="button" id="startUpload" class="btn btn-primary start">
								<i class="en-upload"></i>
								<span>开始上传</span>
							</button>
						</div>
					</div>
					<div class="form-group" style="display: none" id="progressDiv">
						<div class="col-xs-3">
							<div class="progress progress-striped">
								<div class="progress-bar progress-bar-success" id="progress" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-2">
							<ul class="list-group" id="imgList"></ul>
						</div>
						<div class="col-xs-10" id="imgs"></div>
					</div>

				</form>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
	    $(function(){
			$("#fileupload").fileupload({
		        autoUpload: false,//默认情况下，只要用户点击了开始按钮被添加至组件的文件会立即上传。将autoUpload值设为true可以自动上传。
		        singleFileUploads: true, //一次上传多个文件
		      	//limitMultiFileUploads: 3, //每个请求最多上传3个文件
		      	maxNumberOfFiles: 3, //允许上传的文件数量
		      	acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i, //允许上传的的文件类型
		      	minFileSize: 0, //最小上传文件大小
		        maxFileSize: 1024*1024*30, // 最大上传文件大小
		      	messages: {
		            maxFileSize: '超过允许的最大值！',
		            maxNumberOfFiles: '上传的文件数量超过允许的最大值！'
		        },
		        start: function (e) {
		            // 开始上传后不能再选文件了
		            $(".fileinput-button").attr("disabled", "disabled");
		        },
		        process: function (e, data) {
		            console.log('回调为单个文件的处理队列的开始。')
		        },
		        processdone: function (e, data) {
		            console.log('单个文件处理圆满结束', data)
		        },
		        processstart: function (e, data) {
		            console.log('上传队列处理开始')
		        },
		        send: function (e, data) {
		            console.log('每个上传文件开始的时候')
		        },
		        sent: function (e, data) {
		            console.log('sent')
		        },
		        started: function (e, data) {
		            console.log('开始的回调等效于开始回调，并且在开始回调运行之后触发，并且在开始回调中调用的过渡效果已经完成。')
		        },
		        stopped: function (e, data) {
		            console.log('停止的回调等效于停止回调，并且在停止回调运行并且在停止回调和所有完成回调中调用的过渡效果已完成之后触发')
		        },
		        always: function (e, data) {
		        	setTimeout(function(){
		        		$("#startUpload").attr("disabled", "disabled");
		        	}, 2000);
		            //    回调结束（成功，中止或错误）上传请求。这个回调相当于所提供的完整的回调
		        },
		        chunkalways: function (e, data) {
		            console.log('回调结束', data)
		            //    回调结束，不论是上传成功还是失败还是终止
		        },
		     	// 当一个单独的文件处理队列结束（完成或失败时）触发
		        processalways: function (e, data) {
		            console.log('结束一个文件上传队列', data)
		        },
		        processstop: function (e, data) {
		            console.log('文件上传队列停止', data)
		        },
		        completed: function () {
		            $alert('completed');
		        },
		        //全局上传处理事件的回调函数  
		        progressall: function (e, data) {
		            //回调全局上传进度事件。 
		            var progress = parseInt(data.loaded / data.total * 100, 10);
		          	//进度条显示
		            $('#progress').css('width', progress + '%');
		            $('#progress').html(progress + '%')
		        }
			}) 
			//当文件被添加到上传组件时被触发   或者$('#fileupload').on('fileuploadadd', function (e, data) {/* ... */});
			.on('fileuploadadd', function (e, data) {
				for (var i = 0; i < data.files.length; i++) {
					if(data.files[i].size <= 1024*1024*30){
			            $('#imgList').prepend('<li class="list-group-item list-group-item-success">'+data.files[i].name+'</li>');
					}
		        }
				//点击按钮上传
				data.context = $('#startUpload').click(function () {
					$("#progressDiv").show();
	                data.submit();
	            });
			}).on('fileuploadprocessalways', function (e, data) {
				if(data.files.error){
				   if(data.files[0].error=='File type not allowed'){
					   $alert("图片类型错误");
				   }
				   if(data.files[0].error=='File is too large'){
					   $alert("图片不能大于30M");
				   }  
				}
			}).on('fileuploaddone', function (e, data) {
		      	if(data.result.code == 0){
		    	  	var fileName = data.result.data[0].name;
		    	  	var location = data.result.data[0].location;
		    	  	var imgHTML = '<img alt="'+fileName+'" src="${ctx}/upload/' + location+'" class="img-thumbnail" width="140" height="160"/>';
		    	  	$("#imgs").prepend(imgHTML);
			  	}else{
			  		$alert("图片上传失败");
			  	}
			});
		})
    </script>
</body>
</html>
