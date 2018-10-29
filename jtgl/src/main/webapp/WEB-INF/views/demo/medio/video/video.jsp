<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>视频</title>
<%@ include file="/templates/include.jsp"%>
<script type="text/javascript" src="${ctx}/static/assets/plugins/ui/video/video.js"></script>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">视频</h1><hr/>
			</div>
			<div class="panel-body">
				<div class="col-xs-6">
					<video id="example_video_1" class="video-js vjs-default-skin per100" controls preload="auto" height="450" poster="http://video-js.zencoder.com/oceans-clip.png"
						data-setup='{"example_option":true}'> <source src="${ctx}/static/media/video/lulu.mp4" type='video/mp4' /> </video>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>

	<script type="text/javascript">
		$(function() {

		})
	</script>
</body>
</html>
