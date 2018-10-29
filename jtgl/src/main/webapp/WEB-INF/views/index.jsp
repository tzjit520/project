<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
    <head>
        <title>家庭管理系统</title>
        <%@ include file="/templates/include.jsp"%>
        <script type="text/javascript" src="${ctx}/static/system/message/jquery.mintTabify.js"></script>
        
        <style type="text/css">
	        html,body{height:100%;}
	        /* 消息通知样式   */
	        #topbar {
			    height: 50px;
			    overflow: hidden;
			}
			.rolling-notice {
			    margin: 14px 0 0 100px;
			    float: left;
			}
			.rolling-notice .notice-title { 
				float: left;
				font-size: 17px;
				color: #ffffff
			}
			.rolling-notice .notice-list {
			    list-style: none;
			    margin: 0;
			    padding: 0;
			    overflow: hidden;
			    height: 1.5em;
			    position: relative;
			    width: 25em;
			}
			.rolling-notice .notice-list li {
			    list-style: none;
			    margin: 1px;
			    padding: 0;
			    overflow: hidden;
			    height: 1.5em;
			    position: relative;
			    font-size: 17px;
			    color: #ffffff;
			    width: 18em;
			}
			/* 字数长度限制   超出用...表示 */
			.line-limit-length {
				overflow: hidden;
				text-overflow: ellipsis;
				white-space: nowrap;
			}
		</style>
    </head>
    <body>
        <div id="header">
            <div class="container-fluid">
                <div class="navbar">
                    <div class="navbar-header">
                        <a class="navbar-brand" href="javascript:void(0)">
                            <i class="im-windows8 text-logo-element animated bounceIn"></i><span class="text-logo">家庭</span><span class="text-slogan">管理系统</span> 
                        </a>
                    </div>
                    <nav class="top-nav" role="navigation">
                        <ul class="nav navbar-nav pull-left">
                            <li id="toggle-sidebar-li">
                                <a href="#" id="toggle-sidebar"><i class="en-arrow-left2"></i></a>
                            </li>
                            <li>
                                <a href="#" class="full-screen"><i class="fa-fullscreen"></i></a>
                            </li>
                            <li>
                            	<!-- 滚动消息通知 -->
                                <div id="topbar">
									<div class="rolling-notice">
										<strong class="notice-title">通知：</strong>
										<ul class="notice-list" id="announce"></ul>
									</div>
								</div>
                            </li>
                        </ul>
                        <ul class="nav navbar-nav pull-right">
                            <li>
                                <a href="#" id="toggle-header-area"><i class="ec-download"></i></a>
                            </li>
                        
                            <li class="dropdown">
                                <a href="#" data-toggle="dropdown">
                                    <img class="user-avatar" src="${ctx}/uploads/headImg/${fns:getUser().headimgurl}" alt="${fns:getUser().name}">${fns:getUser().name}</a>
                                <ul class="dropdown-menu right" role="menu">
                                    <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/user/profile')"><i class="st-user"></i> 个人信息</a>
                                    </li>
                                    <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/demo/photo')"><i class="st-cloud"></i> 图片库</a>
                                    </li>
                                    <li><a href="javascript:" onclick="go(this,'${ctx}/api/v1/demo/chat')"><i class="st-settings"></i> 聊天</a>
                                    </li>
                                    <li><a href="${ctx}/api/v1/access/logout"><i class="im-exit"></i> 登出</a>
                                    </li>
                                </ul>
                            </li>
                        </ul>
                    </nav>
                </div>
                <div id="header-area" class="fadeInDown">
                    <div class="header-area-inner">
                        <ul class="list-unstyled list-inline">
                            <li>
                                <div class="shortcut-button">
                                    <a href="#">
                                        <i class="im-pie"></i>
                                        <span>图形报表</span>
                                    </a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="sidebar">
            <div class="sidebar-inner">
                <ul id="sideNav" class="nav nav-pills nav-stacked">
                    <li class="top-search">
                        <form>
                            <input type="text" name="search" placeholder="菜单搜索 ...">
                            <button type="submit"><i class="ec-search s20"></i></button>
                        </form>
                    </li>
                    <li><a href="javascript:" id="zy" onclick="go(this,'${ctx}/api/v1/demo/home')">主页 <i class="im-screen"></i></a></li>
                    <c:forEach items="${fns:getMenus()}" var="menu">
                    	<!-- ↓↓↓↓有二级菜单↓↓↓↓ -->
                    	<c:if test="${fn:length(menu.childrenMenus) > 0}">
                    		<li>
	                    		<a href="#">${menu.name} <i class="${menu.css}"></i></a>
	                    		<ul class="nav sub">
	                    			<!-- 循环二级菜单 -->
	                    			<c:forEach items="${menu.childrenMenus}" var="twoMenu">
	                    				<!-- 有三级菜单  -->
	                    				<c:if test="${fn:length(twoMenu.childrenMenus) > 0}">
	                    					<li>
					                    		<a href="#">${twoMenu.name} <i class="${twoMenu.css}"></i></a>
					                    		<ul class="nav sub">
					                    			<!-- 循环三级菜单 -->
	                    							<c:forEach items="${twoMenu.childrenMenus}" var="threeMenu">
	                    								<!-- 有四级菜单  -->
	                    								<c:if test="${fn:length(threeMenu.childrenMenus) > 0}">
	                    									<li>
									                    		<a href="#">${threeMenu.name} <i class="${threeMenu.css}"></i></a>
									                    		<ul class="nav sub">
									                    			<!-- 循环四级菜单 -->
	                    											<c:forEach items="${threeMenu.childrenMenus}" var="fourMenu">
		                                    							<li>
			                                    							<c:if test="${fourMenu.type==1}">
				                                    							<a href="javascript:" onclick="go(this,'${ctx}/${fourMenu.url}')"><i class="${fourMenu.css}"></i>${fourMenu.name}</a>
			                                    							</c:if>
			                                    							<c:if test="${fourMenu.type==2}">
				                                    							<a href="${ctx}/${fourMenu.url}" target="_blank"><i class="${fourMenu.css}"></i>${fourMenu.name}</a>
			                                    							</c:if>
		                                    							</li>
	                    											</c:forEach>
	                    										</ul>
				                    						</li>
	                    								</c:if>
	                    								<!-- 没有四级菜单  -->
	                    								<c:if test="${fn:length(threeMenu.childrenMenus) <= 0}">
	                    									<!-- 三级菜单路径为空   -->
						                    				<c:if test="${empty threeMenu.url}">
								                    			<li><a href="javascript:"><i class="${threeMenu.css}"></i>${threeMenu.name}</a></li>
								                    		</c:if>
								                    		<!-- 三级菜单路径不为空   -->
								                    		<c:if test="${not empty threeMenu.url}">
																<li>
																	<c:if test="${threeMenu.type==1}">
								            							<a href="javascript:" onclick="go(this,'${ctx}/${threeMenu.url}')"><i class="${threeMenu.css}"></i>${threeMenu.name}</a>
								           							</c:if>
								           							<c:if test="${threeMenu.type==2}">
								            							<a href="${ctx}/${threeMenu.url}" target="_blank"><i class="${threeMenu.css}"></i>${threeMenu.name}</a>
								           							</c:if>
																</li>
								                    		</c:if>
	                    								</c:if>
	                    								
					                    			</c:forEach>
					                    		</ul>
				                    		</li>
	                    				</c:if>
	                    				<!-- 没有三级菜单  -->
	                    				<c:if test="${fn:length(twoMenu.childrenMenus) <= 0}">
		                    				<!-- 二级菜单路径为空   -->
		                    				<c:if test="${empty twoMenu.url}">
				                    			<li><a href="javascript:"><i class="${twoMenu.css}"></i>${twoMenu.name}</a></li>
				                    		</c:if>
				                    		<!-- 二级菜单路径不为空   -->
				                    		<c:if test="${not empty twoMenu.url}">
				                    			<li>
                           							<c:if test="${twoMenu.type==1}">
                            							<a href="javascript:" onclick="go(this,'${ctx}/${twoMenu.url}')"><i class="${twoMenu.css}"></i>${twoMenu.name}</a>
                           							</c:if>
                           							<c:if test="${twoMenu.type==2}">
                            							<a href="${ctx}/${twoMenu.url}" target="_blank"><i class="${twoMenu.css}"></i>${twoMenu.name}</a>
                           							</c:if>
                       							</li>
				                    		</c:if>
	                    				</c:if>
	                    			</c:forEach>
	                    		</ul>
                    		</li>
                    	</c:if>
                    	<!-- ↓↓↓↓没有二级菜单↓↓↓↓   -->
                    	<c:if test="${fn:length(menu.childrenMenus) <= 0}">
                    		<!-- 一级菜单路径如果为空   -->
                    		<c:if test="${empty menu.url}">
                    			<li><a href="javascript:"><i class="${menu.css}"></i>${menu.name}</a></li>
                    		</c:if>
                    		<!-- 一级菜单路径不为空   -->
                    		<c:if test="${not empty menu.url}">
								<li>
									<c:if test="${menu.type==1}">
            							<a href="javascript:" onclick="go(this,'${ctx}/${menu.url}')"><i class="${menu.css}"></i>${menu.name}</a>
           							</c:if>
           							<c:if test="${menu.type==2}">
            							<a href="${ctx}/${menu.url}" target="_blank"><i class="${menu.css}"></i>${menu.name}</a>
           							</c:if>
								</li>
                    		</c:if>
                    	</c:if>
					</c:forEach>
                </ul>
            </div>
        </div>
        
        <div id="content" style="height:100%">
	   		<iframe src="${ctx}/api/v1/demo/home" id="iframeContent" name="iframeContent" style="overflow: visible;padding-top: 10px" width="100%" height="100%"  frameborder="0"></iframe>
        </div>
        
        <script src="${ctx}/static/assets/js/jquery.sprFlat.js?i=6"></script>
        <script src="${ctx}/static/assets/js/app.js?i=3"></script>
        <!-- 消息 -->
        <script type="text/javascript" src="${ctx}/static/system/message/message.js"></script>
        <script type="text/javascript">
        
        	var go = function(obj, url){
        		
        		if($(".active")){
        			$(".active").removeClass("active");
        		}
        		$(obj).addClass("active");
        		
        		$("#iframeContent").attr("src", encodeURI(url));
        	}
        
        	$(function(){
        		$("#zy").addClass("active");
        		//onload="javascript:this.height=this.contentWindow.document.body.scrollHeight+140;"
        		console.log($("#content").height);
        		console.log($("#iframeContent").height);
        	})
        </script>
    </body>
</html>