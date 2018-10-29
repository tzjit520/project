<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
	<title>邮箱</title>
	<%@ include file="/templates/include.jsp"%>
	<style type="text/css">
		.e_active{
			background: #8a7c5d2b
		}
	</style>
</head>

<body>
	<div class="content-wrapper">
        <div class="outlet">
        	<div id="email-sidebar" style="float:left">
	            <div class="p15">
	                <a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail/0')" class="btn btn-danger btn-block uppercase"><i class="im-quill"></i> 写邮件</a>
	            </div>
	            <ul id="email-nav" class="nav nav-pills nav-stacked">
	                <li class="e_active"><a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail?emailType=1')"><i class="ec-archive"></i> 收件箱 <span class="notification blue">27</span></a>
	                </li>
	                <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail?mark=1')"><i class="ec-star"></i> 星标邮件 <span class="notification orange">2</span></a>
	                </li>
	                <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail?emailType=2')"><i class="en-location2"></i> 已发送 <span class="notification green">14</span></a>
	                </li>
	                <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail?emailType=3')"><i class="ec-pencil2"></i> 草稿箱 <span class="notification brown">1</span></a>
	                </li>
	                <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail?deleted=1')"><i class="ec-trashcan"></i> 已删除 <span class="notification red">3</span></a>
	                </li>
	                <li class="nav-header">我的文件夹</li>
	                <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail')"><span class="circle"></span> 漂流瓶</a>
	                </li>
	                <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail')"><span class="circle color-red"></span> 日历</a>
	                </li>
	                <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail')"><span class="circle color-green"></span> 在线文档</a>
	                </li>
	                <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail')"><span class="circle color-pink"></span> 记事本</a>
	                </li>
	                <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/mail')"><span class="circle color-teal"></span> 订阅</a>
	                </li>
	            </ul>
	        </div>
	        <div id="email-content">
	            <div class="email-wrapper">
	            	<div class="email-toolbar col-xs-12">
	                    <div class="pull-left" role="toolbar">
	                        <button id="email-toggle" class="email-toggle" type="button">
	                            <span class="sr-only">Toggle email nav</span>
	                            <span class="icon-bar"></span>
	                            <span class="icon-bar"></span>
	                            <span class="icon-bar"></span>
	                        </button>
	                        <a href="#" class="btn btn-default btn-round btn-sm tip mr5" title="刷新"><i class="ec-refresh s16"></i></a>
	                        <a href="#" class="btn btn-default btn-round btn-sm tip mr5" title="回复"><i class="im-undo s16"></i></a>
	                        <a href="#" class="btn btn-default btn-round btn-sm tip mr5" title="转发"><i class="im-redo s16"></i></a>
	                        <a href="#" class="btn btn-danger btn-round btn-sm tip mr5" title="删除"><i class="ec-trashcan s16"></i></a>
	                    </div>
	                    <ul class="email-pager">
	                        <li class="pager-info">1-20 of 345</li>
	                        <li><a href="#" class="btn btn-default btn-round btn-sm"><i class="en-arrow-left4 s16"></i></a>
	                        </li>
	                        <li><a href="#" class="btn btn-default btn-round btn-sm"><i class="en-arrow-right5 s16"></i></a>
	                        </li>
	                    </ul>
	                </div>
	                <div class="email-list col-xs-12">
	            		<iframe id="emailContent" name="emailContent" src="${ctx}/api/v1/mail?emailType=1" style="width:100%" onload="javascript:this.height=this.contentWindow.document.body.scrollHeight+140" frameborder="0"></iframe>
	        		</div>
	        	</div>
	        </div>
        </div>
    </div>
 	<div class="clearfix"></div>
    
    <script type="text/javascript">
	    var go = function(obj, url){
	    	if($(".e_active")){
    			$(".e_active").removeClass("e_active");
    		}
    		$(obj).parent().addClass("e_active");
			$("#emailContent").attr("src", encodeURI(url));
		}
	    
    	function tableHighlight () {
    	    var table = $('.table');
    	    var chboxes = table.find('input.check');

    	    chboxes.on('ifChecked ifUnchecked', function(event) {        
    	        if (event.type == 'ifChecked') {
    	            $(this).closest('tr').addClass('highlight');
    	        } else {
    	            $(this).closest('tr').removeClass('highlight');
    	        }
    	    });
    	}
    	
	    $(function(){
	    	tableHighlight();
			
			var emailTable = $('.email-list table');
			var emailStar = emailTable.find('td.email-star>i');

			//setup the star in click
			emailStar.click(function() {
				if($(this).hasClass('im-star')) {
					$(this).removeClass('im-star s20').addClass('im-star3 s20');
					//make callback here

				} else {
					$(this).removeClass('im-star3 s20').addClass('im-star s20');
					//make callback here
				}
			});
		})
		
    </script>
</body>
</html>