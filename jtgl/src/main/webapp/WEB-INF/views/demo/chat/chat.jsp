<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>聊天</title>
<%@ include file="/templates/include.jsp"%>
<link href="${ctx}/static/system/chat/chat.css" rel="stylesheet" />	
</head>
<body>
	<!-- 左边begin -->
	<div class="left">
		<c:set value="${fns:getUser()}" var="user" />
		<div class="left_head">
			<div style="display: table-cell; vertical-align: middle;">
				<img src="${ctx}/uploads/headImg/${user.headimgurl}">
			</div>
			<div class="left_head_name">${user.name}</div>
			<div style="display: table-cell; vertical-align: middle;">
				<a>
					<i class="im-paragraph-justify"></i>
				</a>
			</div>
		</div>
		<div class="left_tab">
			<div class="left_tab_item">
				<i class="im-bubble2 active"></i>
			</div>
			<div class="left_tab_item" style="border-left: 1px solid #24272c; border-right: 1px solid #24272c;">
				<i class="im-heart2"></i>
			</div>
			<div class="left_tab_item">
				<i class="im-users2"></i>
			</div>
		</div>
		<div id="">
			<div id="chat_left_items" style="position: absolute; top: 140px; bottom: 12px; overflow-y: auto; overflow-x: hidden;">
				<c:forEach items="${listUser}" var="user">
					<div id="chat_left_list_${user.code}" style="width: 280px; padding: 12px; height: 70px; border-bottom: 1px solid #2f2424;">
						<div style="float: left;">
							<img src="${ctx}/uploads/headImg/${user.headimgurl}">
						</div>
						<div style="margin-left: 55px;">
							<p style="color: #fff; font-size: 14px; font-weight: bold;">${user.name}</p>
							<p style="color: #fff; font-size: 13px; overflow: hidden; white-space: nowrap; text-overflow: ellipsis">天上的白云真美啊</p>
						</div>
					</div>
				</c:forEach>
			</div>
			<div id="read_left_items" style="display: none">这是发表的说说</div>
			<div id="contact_left_items" style="display: none">这是联系人页面</div>
		</div>
	</div>
	<!-- 左边end -->
	<!-- 右边begin -->
	<div class="right">
		<div class="right_header">
			<div class="title_button">
				<a style="text-decoration: none; color: #000;">
					<span id="chat_title">未选择聊天</span>
					<i class="en-arrow-down5"></i>
				</a>
			</div>
			<div class="chat_title_info">
				<c:set value="${fns:getUser()}" var="user" />
				<img src="${ctx}/uploads/headImg/${user.headimgurl}">
			</div>
		</div>
		<div class="right_content">
			<ul style="-webkit-margin-before: 1em; -webkit-padding-start: 40px;">
				<li style="text-align: right; padding-right: 10px;">
					<div style="position: relative; display: inline-block; vertical-align: top; font-size: 14px;">
						<img alt="" src="${ctx}/uploads/headImg/girl.png" width="40" height="40">
						<cite style="right: 65px; top: 0;">
							<span style="padding-right: 15px; font-size: 12px;">2018-08-20 08:47:53</span>
							谭志杰
						</cite>
					</div>
					<div style="position: relative; line-height: 22px; top: -26px; right: 50px; padding: 8px 15px; word-break: break-all;">
						<span class="right_content_chat_text"> 您好打算佛挡杀佛杀佛到是非得失发送到发送到水电费水电费水电费水电费水电费水电费是的打算倒萨大萨达杀佛到是非得失发送到发送到水电费水电费水电费水电费水电费水电费是的打算倒萨大萨达杀佛到是非得失发送到发送到水电费水电费水电费水电费水电费水电费是的打算倒萨大萨达 </span>
					</div>
				</li>

				<li style="position: relative; left: -100px;">
					<div style="position: relative; display: inline-block; vertical-align: top; font-size: 14px;">
						<img alt="" src="${ctx}/uploads/headImg/girl.png" width="40" height="40">
						<cite style="left: 65px; top: -2px;">
							刘露<span style="padding-left: 15px; font-size: 12px;">2018-08-20 08:47:53</span>
						</cite>
					</div>
					<div style="position: relative; line-height: 22px; top: -26px; left: 50px; padding: 8px 15px; word-break: break-all;">
						<span class="left_content_chat_text"> 您好打算佛挡杀佛到是非得失发送到发送到水电费水电费水电费水电费水电费水电费是的打算倒萨大萨达萨达萨达撒大所 </span>
					</div>
				</li>
			</ul>
		</div>
		<!-- 图标  -->
		<div class="right_icon">
			<div style="padding: 10px">
				<a style="display: table-cell; padding-left: 10px">
					<i class="im-happy" style="font-size: 25px"></i>
				</a>
				<a style="display: table-cell; padding-left: 20px">
					<i class="im-folder" style="font-size: 25px"></i>
				</a>
			</div>
		</div>
		<div class="right_textarea">
			<textarea rows="3"></textarea>
		</div>
		<div class="right_send">
			<span style="color: #888; font-size: 12px;"></span>
			<button class="btn btn-primary">发送</button>
		</div>
	</div>



	<!-- 右边end -->
	<script type="text/javascript">
		$(function() {
			//左边tab切换
			$(".left_tab_item").click(function() {
				$('[id$=left_items]').eq($(this).index()).show().siblings().hide();
				$(this).siblings().children("i").removeClass("active");
				$(this).children("i").addClass("active");
			})

			$('[id^=chat_left_list]').click(function() {
				$("#chat_title").text($(this).children("div")[1].children[0].innerText);
				$(this).siblings().removeClass("d_active");
				$(this).addClass("d_active");
			})

			$(".title_button").click(function() {
				$(".chat_title_info").slideToggle(500);
				var icon = $(this).children("a").children("i");
				if (icon[0].className == "en-arrow-down5") {
					icon.attr("class", "en-arrow-up5");
				} else {
					icon.attr("class", "en-arrow-down5");
				}
			});

			/* $("[id^=chat_left_]").unbind("mousedown").bind("contextmenu", function (e) {
			    
			    $("#menu").css({
			        //定义菜单显示位置为事件发生的X坐标和Y坐标
			        top : event.pageY,
			        left : event.pageX
			    }).slideDown(100);

			    return false;

			}); */
			/* $("[id^=chat_left_]").unbind("mousedown").bind("mousedown", function (event) {
			    if (event.which == 3) {
			    	
			    
			    }else if(event.which == 1){
			   	alert("我单击了左键");
				} 
			  
			}); */
		})
	</script>
</body>
</html>


