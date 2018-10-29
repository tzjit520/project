<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>用户管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">个人信息</h1>
			</div>
			<div class="col-xs-6">
				<div class="panel panel-default plain profile-widget">
					<div class="panel-heading white-bg pl0 pr0">
						<img class="profile-image img-responsive" src="${ctx}/static/assets/img/profile-cover.jpg" alt="profile cover">
					</div>
					<div class="panel-body">
						<div class="col-xs-3">
							<div class="profile-avatar">
								<img class="img-responsive" src="${ctx}/uploads/headImg/${user.headimgurl}" alt="${user.name}">
							</div>
						</div>
						<div class="col-xs-9">
							<div class="profile-name">
								${user.name}
								<span class="label label-success">${user.roleList[0].name}</span>
							</div>
							<div class="profile-quote">
								<p>${user.remark}</p>
							</div>
							<div class="profile-stats-info">
								<a href="#" class="tipB" title="Views">
									<i class="ec-mobile"></i>
									<strong>${user.mobile}</strong>
								</a>
							</div>
						</div>
					</div>
					<div class="panel-footer white-bg">
						<ul class="profile-info">
							<li>
								<i class="ec-mail"></i>
								${user.email}
							</li>
							<%-- <li>
									<i class="ec-mail"></i>
									${user.email}
								</li> --%>
						</ul>
					</div>
				</div>
			</div>
			<div class="col-xs-6">
				<div class="panel panel-default plain">
					<div class="panel-heading white-bg">
						<h4 class="panel-title">
							<i class="ec-user"></i>
							修改个人信息
						</h4>
					</div>
					<div class="panel-body">
						<form class="form-vertical hover-stripped" id="userForm" role="form">
							<input type="hidden" name="_method" value="PUT"/>
							<input type="hidden" name="id" value="${user.id}"/>
							<input type="hidden" name="headimgurl" value="${user.headimgurl}"/>
							<div class="form-group">
								<label class="control-label">登录名</label>
								<input type="text" class="form-control" name="code" value="${user.code}" readonly="readonly">
								<!-- <a href="#" class="help-block color-red">Request new ?</a> -->
							</div>
							<div class="form-group">
								<label class="control-label">姓名</label>
								<input type="text" class="form-control" name="name" value="${user.name}">
							</div>
							<div class="form-group">
								<label class="control-label">邮箱</label>
								<input type="text" class="form-control" name="email" value="${user.email}">
							</div>
							<div class="form-group">
								<label class="control-label">电话</label>
								<input type="text" class="form-control" name="mobile" value="${user.mobile}">
							</div>
							<div class="form-group">
								<label class="control-label">新密码</label>
								<input type="password" id="password" name="password" class="form-control" value="${user.password}">
							</div>
							<div class="form-group">
								<label class="control-label">确认密码</label>
								<input type="password" name="password2" class="form-control" value="${user.password}">
							</div>
							<div class="form-group">
								<label class="control-label">描述</label>
								<textarea class="form-control" name="remark" rows="3" >${user.remark}</textarea>
							</div>
							<div class="form-group mb15">
								<input type="button" class="btn btn-primary" onclick="submitForm()" value="更新">
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>

	<script type="text/javascript">
		function submitForm(){
			if($("#userForm").valid()){
				$.ajax({
					type: "POST",
					url: "${ctx}/api/v1/user/changeInfo",
					data: $("#userForm").serialize(),
					success: function(result){
						if(result.code == 0){
							$.jBox.tip("更新成功");
							setTimeout(function(){
								window.location.href = "${ctx}/api/v1/user/profile";
							}, 1000)
						}else{
							$.jBox.tip("更新失败");
						}
					}
				});
			}
		}
		
		$(document).ready(function() {
			
			$("#userForm").validate({
				ignore : null,
				ignore : 'input[type="hidden"]',
				errorPlacement : function(error, element) {
					error.insertAfter(element);
				},
				errorClass : 'help-block',
				rules : {
					name : {
						required : true
					},
					password: {
						minlength: 6
					},
					password2: {
						minlength: 6,
						equalTo: "#password"
					}
				},
				messages : {
					name : {
						required : "姓名不能为空"
					},
					password: {
						minlength: "密码最少6位"
					},
					password2: {
						minlength: "确认密码最少6位",
						equalTo: "2次密码不一致"
					},
				},
				highlight : function(element) {
					$(element).addClass("validator_error");
				},
				unhighlight : function(element, errorClass) {
					$(element).addClass("validator_success");
				}
			});
		});
	</script>
</body>
</html>