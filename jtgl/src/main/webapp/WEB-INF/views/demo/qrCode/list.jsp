<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>二维码</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">二维码生成</h1><hr/>
			</div>
			<div class="panel-body">
				<form id="fileupload" name="fileupload" action="${ctx}/api/v1/file/upload" method="POST" enctype="multipart/form-data" class="form-horizontal group-border hover-stripped">
					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">内容:</label>
						<div class="col-xs-3">
							<textarea name="conText" id="conText" rows="3" cols="" class="form-control"></textarea>
						</div>
						<div class="col-xs-1"></div>
						<div class="col-xs-2">
							<span class="btn btn-success fileinput-button">
								<i class="en-plus3"></i>
								<span>上传图片</span>
								<span id="fileInput">
									<input type="file" id="file" name="files[]" multiple>
								</span>
							</span>
						</div>
						<div class="col-xs-2">
							<div id="imgDiv"></div>
							<input type="hidden" id="imgPath" />
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-2">
							<button type="button" class="btn btn-pink" id="qrButton">生成二维码</button>
						</div>
						<div class="col-xs-2">
							<button type="button" class="btn btn-pink" id="qrLogoButton">生成带LoGo二维码</button>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-3">
							<div id="qrDiv"></div>
						</div>
					</div>
				</form>
			</div>
			
			<div class="col-xs-12 heading">
				<h1 class="page-header">JS二维码生成</h1><hr/>
			</div>
			<div class="panel-body">
				<div class="col-xs-3">
					<p>不带logo</p>
				 	<div id="qrcodeTable"></div>
				</div>
				<div class="col-xs-3">
				 	<p>带logo</p>
				 	<div id="qrcodeCanvas"></div>	
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<!-- js生成二维码 -->
	<script type="text/javascript" src="${ctx}/static/plugin/qrCode/jquery.qrcode.js" ></script>
    <script type="text/javascript" src="${ctx}/static/plugin/qrCode/qrcode.js" ></script> 
    <script type="text/javascript" src="${ctx}/static/plugin/qrCode/utf.js" ></script>
    <script type="text/javascript">
	    $('#qrcodeTable').qrcode({
	        render    : "table",                //二维码生成方式
	        text    : "http://www.baidu.com" , //二维码内容  
	        width : "120",               //二维码的宽度
	        height : "120",
	    });    
	    $('#qrcodeCanvas').qrcode({
	    	render    : "canvas",
	        text    : "http://www.baidu.com",
	        width : "120",               //二维码的宽度
	        height : "120",              //二维码的高度
	        background : "#ffffff",       //二维码的后景色
	        foreground : "#000000",        //二维码的前景色
	        src: '${ctx}/static/imges/girl.jpg'             //二维码中间的图片
	    });  
    </script>
    
	<script type="text/javascript">
	   	$(function(){
	   	//生成带logo二维码
	   		$("#qrLogoButton").click(function(){
	   			var conText = $("#conText").val();
	   			if(conText == ""){
					$alert("请填写内容!", "提示");
					return ;
				}
	   			var imgPath = $("#imgPath").val();
	   			if(imgPath == ""){
					$alert("请先上传图片!", "提示");
					return ;
				}
	   			$.ajax({
	    			type: 'post',
	    			url: "${ctx}/api/v1/qrCode",
	    			data: {
	    				conText: conText,
	    				imgPath: imgPath
    				},
	    			success:function(result){
	    				if(result.code == 0){
	    					var qrCodeUrlString = result.data;
	    		    	  	var imgHTML = '<img src="${ctx}/upload' + qrCodeUrlString+'" width="150" height="150"/>';
	    		    	  	$("#qrDiv").html(imgHTML);
	    				}
	    			}
	    		});
	   		});	
	   		
	   		//生成不带logo二维码
	   		$("#qrButton").click(function(){	
	   			var conText = $("#conText").val();
	   			if(conText == ""){
					$alert("请填写内容!", "提示");
					return ;
				}
	   			$.ajax({
	    			type: 'post',
	    			url: "${ctx}/api/v1/qrCode",
	    			data: {
	    				conText: conText
    				},
	    			success:function(result){
	    				if(result.code == 0){
	    					var qrCodeUrlString = result.data;
	    		    	  	var imgHTML = '<img src="${ctx}/upload' + qrCodeUrlString+'" width="150" height="150"/>';
	    		    	  	$("#qrDiv").html(imgHTML);
	    				}
	    			}
	    		});
	   		});	
	   		
			$("#fileupload").fileupload({
		        autoUpload: true,//默认情况下，只要用户点击了开始按钮被添加至组件的文件会立即上传。将autoUpload值设为true可以自动上传。
		      	acceptFileTypes: /(\.|\/)(gif|jpe?g|png)$/i, //允许上传的的文件类型
		        maxFileSize: 1024*1024*30 // 最大上传文件大小
			}).on('fileuploadadd', function (e, data) {
                data.submit();
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
		    	  	var imgHTML = '<img alt="'+fileName+'" src="${ctx}/upload/'+location+'" width="80" height="80"/>';
		    	  	$("#imgDiv").html(imgHTML);
		    	  	$("#imgPath").val(location);
			  	}else{
			  		$alert("图片上传失败");
			  	}
			});
		})
   	</script>
</body>
</html>
