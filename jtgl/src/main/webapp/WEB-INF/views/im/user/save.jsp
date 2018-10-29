<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>IM</title>
<%@ include file="/templates/include.jsp"%>
<link rel="stylesheet" href="${ctx}/static/plugin/layui/css/layui.css" />
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty imUsers.id?'添加':'修改'}用户</h1>
				<hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="imUsers" role="form" id="imUsersForm" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty imUsers.id?'POST':'PUT'}">
					<form:hidden path="headImg" id="headImg"/>
					<div class="form-group">
						<label for="code" class="col-xs-1 control-label">头像:</label>
						<div class="col-xs-2">
							<button type="button" class="btn btn-primary" id="headImgButton">上传图片</button>
						</div>
						<div class="col-xs-4">
							<c:if test="${not empty imUsers.headImg}">
								<div id="headImgDiv"><img alt="" src="${ctx}/upload/images/${imUsers.headImg}" width="60" height="60"></div>
							</c:if>
							<c:if test="${empty imUsers.headImg}">
								<div id="headImgDiv"></div>
							</c:if>
						</div>
					</div>
					<div class="form-group">
						<label for="code" class="col-xs-1 control-label">登录名:</label>
						<div class="col-xs-2">
							<form:input path="code" id="code" cssClass="form-control required" />
						</div>
						<label for="nickName" class="col-xs-1 control-label">昵称:</label>
						<div class="col-xs-2">
							<form:input path="nickName" id="nickName" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">真实姓名:</label>
						<div class="col-xs-2">
							<form:input path="name" id="name" cssClass="form-control required" />
						</div>
						<label for="password" class="col-xs-1 control-label">密码:</label>
						<div class="col-xs-2">
							<form:password path="password" id="password" cssClass="form-control"/>
						</div>
					</div>
					<div class="form-group">
						<label for="sex" class="col-xs-1 control-label">性别:</label>
						<div class="col-xs-2">
							<label class="radio-inline">
								<form:radiobutton path="sex" value="男" />男
							</label>
							<label class="radio-inline">
								<form:radiobutton path="sex" value="女" />女
							</label>
						</div>
						<label for="age" class="col-xs-1 control-label">年龄:</label>
						<div class="col-xs-2">
							<form:input path="age" id="age" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="birthday" class="col-xs-1 control-label">出生日期:</label>
						<div class="col-xs-2">
							<div class='input-group date' id='birthdayDatetimepicker'>
								<form:input path="birthday" id="birthday" class="form-control" />
								<span class="input-group-addon">
									<span class="glyphicon glyphicon-calendar"></span>
								</span>
							</div>
						</div>
						<label for="telePhone" class="col-xs-1 control-label">电话:</label>
						<div class="col-xs-2">
							<form:input path="telePhone" id="telePhone" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="email" class="col-xs-1 control-label">邮箱:</label>
						<div class="col-xs-2">
							<form:input path="email" id="email" cssClass="form-control" />
						</div>
						<label for="schoolTag" class="col-xs-1 control-label">毕业学校:</label>
						<div class="col-xs-2">
							<form:input path="schoolTag" id="schoolTag" cssClass="form-control" />
						</div>
						<label for="vocation" class="col-xs-1 control-label">职业:</label>
						<div class="col-xs-2">
							<form:input path="vocation" id="vocation" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="zodiac" class="col-xs-1 control-label">生肖：</label>
						<div class="col-xs-2">
							<form:select path="zodiac" id="zodiac" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${fns:getLineList('zodiacs')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
						<label for="constellation" class="col-xs-1 control-label">星座：</label>
						<div class="col-xs-2">
							<form:select path="constellation" id="constellation" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${fns:getLineList('constellations')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
						<label for="bloodType" class="col-xs-1 control-label">血型：</label>
						<div class="col-xs-2">
							<form:select path="bloodType" id="bloodType" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${fns:getLineList('bloodTypes')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="nation" class="col-xs-1 control-label">国家：</label>
						<div class="col-xs-2">
							<form:select path="nation" id="nation" cssClass="form-control select2">
								<form:option value="中国">中国</form:option>
							</form:select>
						</div>
						<label for="signaTure" class="col-xs-1 control-label">个性签名:</label>
						<div class="col-xs-5">
							<form:input path="signaTure" id="signaTure" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">省份：</label>
						<div class="col-xs-2">
							<form:select id="province" path="province" onchange="doProvAndCityRelation();" cssClass="form-control">
								<form:option id="choosePro" value="">--请选择--</form:option>
							</form:select>
						</div>
						<label class="col-xs-1 control-label">城市：</label>
						<div class="col-xs-2">
							<form:select id="city" path="city" onchange="doCityAndCountyRelation();" cssClass="form-control">
								<form:option id="chooseCity" value="">--请选择--</form:option>
							</form:select>
						</div>
						<label class="col-xs-1 control-label">区域：</label>
						<div class="col-xs-2">
							<form:select id="county" path="county" cssClass="form-control">
								<form:option id="chooseCounty" value="">--请选择--</form:option>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="intro" class="col-xs-1 control-label">简介:</label>
						<div class="col-xs-5">
							<form:textarea path="intro" id="intro" rows="2" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-xs-1 control-label">描述:</label>
						<div class="col-xs-2">
							<form:input path="remark" id="remark" cssClass="form-control" />
						</div>
						<label for="status" class="col-xs-1 control-label">状态:</label>
						<div class="col-xs-2">
							<form:select path="status" id="status" cssClass="form-control select2">
								<form:options items="${fns:getLineList('statuses')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
					</div>
					
					<div class="form-group">
						<div class="col-xs-offset-1">
							<input type="button" id="submitForm1" class="btn btn-primary ml15" onclick="submitForm()" value="保存">
							<input type="button" value="返回" onclick="history.go(-1)" class="btn btn-info ml15" />
						</div>
					</div>
				</form:form>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript" src="${ctx}/static/system/district/district.js"></script>
	<script src="${ctx}/static/plugin/layui/layui.js"></script>
	<script type="text/javascript">
		layui.use('upload', function(){
			var $ = layui.jquery, upload = layui.upload;
			upload.render({
				elem: '#headImgButton',
				url: '${ctx}/api/v1/file/upload',
				auto: false,
				bindAction: '#submitForm1',
				before: function(obj){//在 choose 回调之后、done/error 回调之前触发。返回的参数完全类似 choose 回调。一般用于上传完毕前的loading、图片预览等
				  //预读本地文件示例，不支持ie8
				  obj.preview(function(index, file, result){
			   		  $('#headImgDiv').append('<img src="'+ result +'" width="50" height="50" alt="'+ file.name +'">')
				  });
				},
				//在上传接口请求完毕后触发，但文件不一定是上传成功的，只是接口的响应状态正常（200）。回调返回三个参数，分别为：服务端响应信息、当前文件的索引、重新上传的方法
				done: function(res){
				  //上传完毕
				  $("#headImg").val(res.data[0].name);
				},
				//在文件被选择后触发，该回调会在 before 回调之前
				choose: function(obj){
				    //将每次选择的文件追加到文件队列
				    var files = obj.pushFile();
				    //预读本地文件，如果是多文件，则会遍历。(不支持ie8/9)
				    obj.preview(function(index, file, result){
				      $('#headImgDiv').append('<img src="'+ result +'" width="50" height="50" alt="'+ file.name +'">')
				      console.log(index); //得到文件索引
				      console.log(file); //得到文件对象
				      console.log(result); // 得到文件base64编码，比如图片
				      //obj.resetFile(index, file, '123.jpg'); //重命名文件名，layui 2.3.0 开始新增
				      //这里还可以做一些 append 文件列表 DOM 的操作
				      //obj.upload(index, file); //对上传失败的单个文件重新上传，一般在某个事件中使用
				      //delete files[index]; //删除列表中对应的文件，一般在某个事件中使用
				    });
				  }
			});
		})
		
		//表单提交
		function submitForm() {
			if($("#imUsersForm").valid()){
				$.ajax({
					type: "POST",
					url: "${ctx}/api/v1/imUsers",
					data: $("#imUsersForm").serialize(),
					success: function(result){
						if(result.code == 0){
							$.jBox.tip("保存成功");
							setTimeout(function(){
								window.location.href = "${ctx}/api/v1/imUsers";
							}, 1000)
						}else{
							$.jBox.tip("保存失败");
						}
					}
				});
			}
		}

		$(document).ready(function() {
			//页面加载完初始化省市区下拉框
	    	initProvince("${imUsers.province}");
	    	doProvAndCityRelation("${imUsers.city}");
	    	doCityAndCountyRelation("${imUsers.county}");
			
			$('#birthdayDatetimepicker').datetimepicker({
				format : 'YYYY-MM-DD',
				locale : moment.locale('zh-cn')
			});

			$("#imUsersForm").validate({
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
					code: {
						required : true
					}
				},
				messages : {
					name : {
						required : "姓名不能为空"
					},
					code: {
						required : "登录名不能为空"
					}
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


