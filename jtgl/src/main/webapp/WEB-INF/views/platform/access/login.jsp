<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
    <head>
        <title>欢迎登陆</title>
        <%@ include file="/templates/include.jsp"%>
    </head>
    <body class="login-page">
        <div id="login" class="animated bounceIn">
            <img id="logo" src="${ctx}/static/assets/img/logo2.png" alt="sprFlat Logo">
            <div class="login-wrapper">
                <ul id="myTab" class="nav nav-tabs nav-justified bn">
                    <li class="">
                        <a href="#log-in" data-toggle="tab">登录</a>
                    </li>
                    <!-- <li class="">
                        <a href="#register" data-toggle="tab">注册</a>
                    </li> -->
                </ul>
                <div id="myTabContent" class="tab-content bn">
                    <div class="tab-pane fade active in" id="log-in">
                        <!-- <div class="social-buttons text-center mt10">
                            <a href="#" class="btn btn-primary btn-alt btn-round btn-lg mr10"><i class="fa-facebook s24"></i></a>
                            <a href="#" class="btn btn-primary btn-alt btn-round btn-lg mr10"><i class="fa-twitter s24"></i></a>
                            <a href="#" class="btn btn-danger btn-alt btn-round btn-lg mr10"><i class="fa-google-plus s24"></i></a>
                            <a href="#" class="btn btn-info btn-alt btn-round btn-lg"><i class="fa-linkedin s24"></i></a>
                        </div> -->
                        <!-- <div class="seperator">
                            <strong>or</strong>
                            <hr>
                        </div> -->
                        <div style="text-align: center;width: 100%;display: inline-block;" class="help-block">
                            <strong id="failMsg">${failMsg}</strong>
                        </div>
                        <form class="form-horizontal mt10" action="${ctx}/api/v1/access/login" id="login-form" role="form" method="POST"> 
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <input type="text" name="code" class="form-control left-icon" value="tzj" placeholder="用户名" style="height:40px">
                                    <i class="ec-user s16 left-input-icon"></i>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <input type="password" name="password" id="password" class="form-control left-icon" value="111111" placeholder="密码" style="height:40px">
                                    <i class="ec-locked s16 left-input-icon"></i>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-3" style="float:left;width:60%;">
                                    <input type="text" name="validateCode" id="validateCode" class="form-control left-icon" placeholder="验证码" style="height:51px">
                                    <i class="st-cube s16 left-input-icon" style="margin-top:5px"></i>
                                </div>
                                <div style="float:left;width:40%;">
                                    <img src="${ctx}/getValidateCode" id="kaptchaImage" style="width:140px"/> 
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-6">
                                    <span class="help-block"><a href="#"><small>忘记密码?</small></a></span> 
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-8">
                                    <label class="checkbox">
                                        <input type="checkbox" name="remember" id="remember" checked="checked" value="1">记住我?
                                    </label>
                                </div>
                                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-4">
                                    <button class="btn btn-success pull-right" type="submit">登录</button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="tab-pane fade" id="register">
                        <form class="form-horizontal mt20" action="#" id="register-form" role="form">
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <input name="code" type="text" class="form-control left-icon" placeholder="输入用户名" style="height:40px">
                                    <i class="ec-mail s16 left-input-icon"></i> 
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <input type="password" class="form-control left-icon" id="password1" name="password" placeholder="输入密码" style="height:40px">
                                    <i class="ec-locked s16 left-input-icon"></i> 
                                </div>
                                <div class="col-lg-12 mt15">
                                    <input type="password" class="form-control left-icon" id="confirm_password" name="confirm_passowrd" placeholder="确认密码" style="height:40px">
                                    <i class="ec-locked s16 left-input-icon"></i> 
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-12">
                                    <button class="btn btn-success btn-block">注册</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
        	if(window!=top){
        		top.location.href = location.href;
        	}
        
        	$('#kaptchaImage').click(function () {//生成验证码  
	            $(this).attr('src', '${ctx}/getValidateCode?' + Math.floor(Math.random()*100) );  
	            event.cancelBubble=true;  
           	});  
        
        	setTimeout(function(){
        		$("#failMsg").text("");
        	}, 5000);
        	
	        $(document).ready(function() {
	        	//validate login form 
	        	$("#login-form").validate({
	        		ignore: null,
	        		ignore: 'input[type="hidden"]',
	        		errorPlacement: function(error, element) {
	        			wrap = element.parent();
	        			wrap1 = wrap.parent();
	        			if (wrap1.hasClass('checkbox')) {
	        				error.insertAfter(wrap1);
	        			} else {
	        				if (element.attr('type')=='file') {
	        					error.insertAfter(element.next());
	        				} else {
	        					error.insertAfter(element);
	        				}
	        			}
	        		}, 
	        		errorClass: 'help-block',
	        		rules: {
	        			code: {
	        				required: true
	        			},
	        			password: {
	        				required: true,
	        				minlength: 6
	        			}
	        		},
	        		messages: {
	        			password: {
	        				required: "密码不能为空",
	        				minlength: "密码长度最少6位"
	        			},
	        			code: "用户名不能为空",
	        		},
	        		highlight: function(element) {
	        			if ($(element).offsetParent().parent().hasClass('form-group')) {
	        				$(element).offsetParent().parent().removeClass('has-success').addClass('has-error');
	        			} else {
	        				if ($(element).attr('type')=='file') {
	        					$(element).parent().parent().removeClass('has-success').addClass('has-error');
	        				}
	        				$(element).offsetParent().parent().parent().parent().removeClass('has-success').addClass('has-error');
	        				
	        			}
	        	    },
	        	    unhighlight: function(element,errorClass) {
	        	    	if ($(element).offsetParent().parent().hasClass('form-group')) {
	        	    		$(element).offsetParent().parent().removeClass('has-error').addClass('has-success');
	        		    	$(element.form).find("label[for=" + element.id + "]").removeClass(errorClass);
	        	    	} else if ($(element).offsetParent().parent().hasClass('checkbox')) {
	        	    		$(element).offsetParent().parent().parent().parent().removeClass('has-error').addClass('has-success');
	        	    		$(element.form).find("label[for=" + element.id + "]").removeClass(errorClass);
	        	    	} else if ($(element).next().hasClass('bootstrap-filestyle')) {
	        	    		$(element).parent().parent().removeClass('has-error').addClass('has-success');
	        	    	}
	        	    	else {
	        	    		$(element).offsetParent().parent().parent().removeClass('has-error').addClass('has-success');
	        	    	}
	        		}
	        	});
	
	        });
        </script>
    </body>
</html>