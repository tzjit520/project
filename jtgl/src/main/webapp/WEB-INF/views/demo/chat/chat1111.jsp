<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
	<title>聊天</title>
	<%@ include file="/templates/include.jsp"%>
	<style type="text/css">
        html,body{height:98%;}
        div .left{width:280px;height:100%;float:left;position:relative;background:#2e3238;}
        div .right{width:60%;height:100%;float:left;background-color:#eee;}
        i{font-size:20px}
        .tab{overflow:hidden;padding-bottom:12px;border-bottom: 1px solid #2f2424}
        .tab_item{float: left; width: 33.33%;display: block; text-align: center;}
        .nick_name{padding-left:10px;width:160px;display:table-cell;vertical-align:middle;font-weight:400;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;color:#fff;font-size:18px;}
		textarea{width:100%;height:100%;resize:none;overflow-y:auto;overflow-x:hidden;border:0;font-size:14px;background-color:#eee;}
		.active{color:#1aad19}
		.d_active{background: #3a3f45}
	</style>
</head>
<body>
	<div style="height:100%;width:100%;">
		<!-- 左边begin -->
   		<div class="left">
   			<c:set value="${fns:getUser()}" var="user"/>
   			<div style="height:80px;padding:18px;">
   				<div style="display:table-cell; vertical-align:middle; ">
					<img src="${ctx}/uploads/headImg/${user.headimgurl}" width="45" height="45">
   				</div>
   				<div class="nick_name">
					${user.name}
   				</div>
   				<div style="display:table-cell;vertical-align:middle;">
					<a><i class="im-paragraph-justify"></i></a>
   				</div>
   			</div>
   			<div class="tab">
   				<div class="tab_item">
	   				<i class="im-bubble2 active"></i>
   				</div>
   				<div class="tab_item" style="border-left: 1px solid #24272c;border-right: 1px solid #24272c;">
	   				<i class="im-heart2"></i>
   				</div>
   				<div class="tab_item">
	   				<i class="im-users2"></i>
   				</div>
   			</div>
   			<div>
   				<div id="chat_items" class="scroll">
	   				<c:forEach items="${listUser}" var="user">
	   					<div style="padding:12px;height:70px;border-bottom: 1px solid #2f2424;" id="chat_left_${user.code}">
		   					<p style="width:25%;float:left;"><img src="${ctx}/uploads/headImg/${user.headimgurl}" width="45" height="45"></p>
		   					<p style="width:75%;float:left;color:#fff;font-weight:normal;font-size:14px;font-weight:bold;">${user.name}</p>
		   					<p style="width:75%;float:left;color:#fff;font-size:13px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis">哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈</p>
	   					</div>
	   				</c:forEach>
   				</div>
   				<div id="read_items" style="display:none">
	   				这是发表的说说
   				</div>
   				<div id="contact_items" style="display:none">
	   				这是联系人页面
   				</div>
   			</div>
   		</div>
   		<!-- 左边end -->
   		<!-- 右边begin -->
   		<div class="right">
   			<div style="height:7%;text-align:center">
   				<div style="padding: 18px; margin: 0 19px; border-bottom: 1px solid #d6d6d6; ">
	   				<a style="text-decoration: none;color: #000;"><span id="chat_title"></span></a>
   				</div>
   			</div>
   			<div style="height:70%;border-bottom: 1px solid #d6d6d6;padding: 18px;">
  				<img alt="" src="${ctx}/uploads/headImg/girl.png" width="40" height="40" style="float: right;">
   				<div style="text-align: right;margin-bottom: 16px;">
   					<div style="background-color:#b2e281; display: inline-block;padding: 10px 13px;margin: 0 10px;">
	   					<span style="font-size: 14px;color:#0c0c0c">您好</span>
   					</div>
   				</div>
   	
   				
   				<img alt="" src="${ctx}/uploads/headImg/girl.png" width="40" height="40" style="float: left;">
				<div style="margin-bottom: 16px;">
					<div style="background-color:#fff; display: inline-block;padding: 10px 13px;margin: 0 10px;">
	  					<span style="font-size:14px;color:#0c0c0c">您好</span>
	 				</div>
 				</div>
   			</div>
   			<div style="height:7%;">
   				<div style="padding: 10px 8px;">
	   				<a style="display:table-cell;padding-left:10px">
		   				<i class="im-happy" style="font-size:25px"></i>
	   				</a>
	   				<a style="display:table-cell;padding-left:10px">
		   				<i class="im-folder" style="font-size:25px"></i>
	   				</a>
   				</div>
   			</div>
   			<div style="height:16%">
   				<div style="height:65%;vertical-align:;padding: 0px 15px 0px 15px">
	   				<textarea></textarea>
   				</div>
   				<div style="text-align:right;margin:0px 7px 0px 7px">
   					<span style="color: #888; font-size: 12px; ">按住Enter发送</span>
   					<button class="btn" style="background-color: #fff; color: #222; padding-left: 30px; padding-right: 30px;">发送</button>
   				</div>
   			</div>
   		</div>
   		<!-- 右边end -->
   		<ul style="width:100px;display:none;position:absolute;" id="menu">
        <li>Item 1</li>
        <li>Item 2</li>
        <li>Item 3
            <ul>
                <li>Item 3-1</li>
                <li>Item 3-2</li>
                <li>Item 3-3</li>
                <li>Item 3-4</li>
                <li>Item 3-5</li>
            </ul>
        </li>
        <li>Item 4</li>
        <li>Item 5</li>
    </ul>
   	</div>
	<script type="text/javascript">
		$(function(){
			$(".tab_item").click(function(){
				$('[id$=_items]').eq($(this).index()).show().siblings().hide();
				$(this).siblings().children("i").removeClass("active");
				$(this).children("i").addClass("active");
			})
			
			$('[id^=chat_left_]').click(function(){
				$("#chat_title").text($(this).children("p")[1].innerText);
				$(this).siblings().removeClass("d_active");
				$(this).addClass("d_active");
			})
			
			
			$("[id^=chat_left_]").unbind("mousedown").bind("contextmenu", function (e) {
	            
	            $("#menu").css({
	                //定义菜单显示位置为事件发生的X坐标和Y坐标
	                top : event.pageY,
	                left : event.pageX
	            }).slideDown(100);

	            return false;

	        });
			$("[id^=chat_left_]").unbind("mousedown").bind("mousedown", function (event) {
	            if (event.which == 3) {
	            	
	            
	            }else if(event.which == 1){
	           	alert("我单击了左键");
				} 
	          
	        });
		})
	</script>
</body>
</html>


