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
				<h1 class="page-header">文件上传</h1><hr/>
			</div>
			<div class="panel-body">
				<form id="fileupload" name="fileupload" action="${ctx}/api/v1/file/uploadFile" method="POST" enctype="multipart/form-data" class="form-horizontal group-border hover-stripped">
					<div class="form-group">
						<div class="col-xs-5">
							<span class="btn btn-success fileinput-button">
								<i class="en-plus3"></i>
								<span>选择文件</span>
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
							<ul class="list-group" id="fileList"></ul>
						</div>
						<div class="col-xs-10">
							<ul class="list-group" id="files"></ul>
						</div>
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
		        singleFileUploads: false, //一次上传多个文件
		        maxFileSize: 1024*1024*64, // 最大上传文件大小
		        start: function (e) {
		            // 开始上传后不能再选文件了
		            $(".fileinput-button").attr("disabled", "disabled");
		        },
		        always: function (e, data) {
		        	setTimeout(function(){
		        		$("#startUpload").attr("disabled", "disabled");
		        	}, 2000);
		            //    回调结束（成功，中止或错误）上传请求。这个回调相当于所提供的完整的回调
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
					if(data.files[i].size <= 1024*1024*64){
			            $('#fileList').prepend('<li class="list-group-item list-group-item-success">'+data.files[i].name+'</li>');
					}
		        }
				//点击按钮上传
				data.context = $('#startUpload').click(function () {
					$("#progressDiv").show();
	                data.submit();
	            });
			}).on('fileuploadprocessalways', function (e, data) {
				if(data.files.error){
				   if(data.files[0].error=='File is too large'){
					   $alert("选择的文件不能大于64M");
				   }  
				}
			}).on('fileuploaddone', function (e, data) {
		      	if(data.result.code == 0){
		    	  	var fileName = data.result.data[0].name;
		    	  	var location = data.result.data[0].location;
		    		var fileHTML = '<li class="list-group-item list-group-item-success">'+ fileName +'&nbsp;&nbsp;<a href="${ctx}/upload/' +location +'">下载</a></li>';
		    	  	$("#files").prepend(fileHTML);
			  	}else{
			  		$alert("文件上传失败");
			  	}
			});
		})
    </script>
</body>
</html>
