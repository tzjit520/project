<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>照片墙</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">照片墙</h1><hr/>
			</div>

			<div class="panel-body">
				<div class="gallery">
					<div class="gallery-toolbar">
						<div class="col-xs-12">
							<button class="filter btn btn-primary btn-alt mr5" data-filter="all">全部</button>
							<button class="filter btn btn-primary btn-alt mr5" data-filter=".sea">海洋</button>
							<button class="filter btn btn-primary btn-alt mr5" data-filter=".city">城市</button>
							<button class="filter btn btn-primary btn-alt mr5" data-filter=".nature">自然</button>
							<button class="filter btn btn-primary btn-alt mr5" data-filter=".vegetables">蔬菜</button>
							<span class="sort btn btn-primary btn-alt" data-sort="random">随机</span>
						</div>
					</div>
					<div class="gallery-inner">
						<div class="col-xs-4 mix sea" data-my-order="1">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/1.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/1.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix city" data-my-order="2">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/2.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/2.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix city" data-my-order="3">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/3.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/3.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix nature" data-my-order="4">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/4.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/4.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix nature" data-my-order="5">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/5.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/5.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix nature" data-my-order="6">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/6.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/6.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix sea" data-my-order="7">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/7.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/7.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix sea" data-my-order="8">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/8.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/8.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix vegetables" data-my-order="9">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/9.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/9.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix vegetables" data-my-order="10">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/10.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/10.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix sea" data-my-order="11">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/11.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/11.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
						<div class="col-xs-4 mix city" data-my-order="12">
							<a href="#" class="thumbnail">
								<img src="${ctx}/static/media/photo/12.jpg" alt="image">
							</a>
							<div class="gallery-image-controls">
								<div class="action-btn">
									<a class="gallery-image-open btn btn-primary btn-round tipB" title="Open image" href="${ctx}/static/media/photo/12.jpg">
										<i class="ec-search"></i>
									</a>
									<a class="gallery-image-download btn btn-primary btn-round tipB" title="Download" href="#">
										<i class="st-download"></i>
									</a>
									<a class="gallery-image-delete btn btn-primary btn-round tipB" href="#" title="Delete">
										<i class="ec-trashcan"></i>
									</a>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript" src="${ctx}/static/assets/plugins/misc/gallery/jquery.magnific-popup.js"></script>
	<script type="text/javascript" src="${ctx}/static/assets/plugins/misc/mixitup/jquery.mixitup.js"></script>
	<script type="text/javascript">
    	$(function(){
    		//------------- MixitUp sorting -------------//
    		$('.gallery-inner').mixItUp({
    			animation: {
    		        effects: 'fade translateZ(500px)',
    		        duration: 300
    		    },
    		}); 

    		//------------- Open image -------------//
    		$('.gallery-inner').magnificPopup({
    		  	delegate: 'a.gallery-image-open', // child items selector, by clicking on it popup will open
    		  	type: 'image',
    		  	gallery: {
    		    	enabled: true
    		    }
    		});

    		//------------- hover direction plugin -------------//
    	    $(function () {
    			$('.mix').hoverDirection();      
    			$('.mix .gallery-image-controls ').on('animationend', function (event) {
    				var $box = $(this).parent();
    				$box.filter('[class*="-leave-"]').hoverDirection('removeClass');
    			});
    	    });
    	})
    </script>
</body>
</html>
