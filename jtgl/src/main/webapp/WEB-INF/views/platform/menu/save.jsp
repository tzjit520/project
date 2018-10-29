<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>菜单管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">${empty menu.id?'添加':'修改'}菜单</h1><hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="menu" action="${ctx}/api/v1/menu" role="form" id="menuForm" onsubmit="return submitForm()" class="form-horizontal group-border hover-stripped">
					<form:hidden path="id" id="id" />
					<input type="hidden" name="_method" value="${empty menu.id?'POST':'PUT'}">
					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">名称：</label>
						<div class="col-xs-2">
							<form:input path="name" id="name" cssClass="form-control required" />
						</div>
						<label for="code" class="col-xs-1 control-label">编码：</label>
						<div class="col-xs-2">
							<form:input path="code" id="code" cssClass="form-control required" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">父级菜单：</label>
						<div class="col-xs-2">
							<form:select path="parentId" id="parentId" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:options items="${result}" itemLabel="name" itemValue="id" />
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="url" class="col-xs-1 control-label">路径：</label>
						<div class="col-xs-5">
							<form:input path="url" id="url" cssClass="form-control" />
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">权限：</label>
						<div class="col-xs-10">
							<form:hidden path="permission" id="permission" />
							<button type="button" id="selectPermissionBtn" class="btn btn-purple" >选择</button>
							<span id="permissionText" style="font-size: 18px">${menu.permission}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label">图标：</label>
						<div class="col-xs-10">
							<input type="button" id="selectBtn" class="btn btn-purple" value="选择">
							<form:hidden path="css" id="css" />
							<i id="iconTag" style="font-size: 25px" class="${menu.css}"></i>
						</div>
					</div>
					<div class="form-group">
						<label for="sort" class="col-xs-1 control-label">排序：</label>
						<div class="col-xs-2">
							<form:input path="sort" id="sort" cssClass="form-control" />
						</div>
						<label for="type" class="col-xs-1 control-label">类型：</label>
						<div class="col-xs-2">
							<form:select path="type" id="type" cssClass="form-control select2">
								<form:options items="${fns:getLineList('menuTypes')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label for="remark" class="col-xs-1 control-label">菜单描述：</label>
						<div class="col-xs-2">
							<form:input path="remark" id="remark" cssClass="form-control" />
						</div>
						<label for="status" class="col-xs-1 control-label">状态：</label>
						<div class="col-xs-2">
							<form:select path="status" id="status" cssClass="form-control select2">
								<form:options items="${fns:getLineList('statuses')}" itemLabel="name" itemValue="code"/>
							</form:select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-xs-1 control-label"></label>
						<div class="col-xs-2">
							<button class="btn btn-primary" type="submit">保存</button>
							<button class="btn btn-info" type="button" onclick="window.location.href='${ctx}/api/v1/menu'">返回</button>
						</div>
					</div>

					<!-- 图标 -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
						<div class="modal-dialog" style="width: 1250px">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModal2Label">选择图标</h4>
								</div>
								<div class="modal-body" id="iconDiv"></div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary" onclick="javascript:changeIcon();" data-dismiss="modal">确定</button>
									<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
								</div>
							</div>
						</div>
					</div>

				</form:form>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
    	//表单提交
	    function submitForm(){
	    	return true;
	    }
     
	    $(document).ready(function() {
	    	$("#menuForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			error.insertAfter(element);
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			code: {
	    				required: true,
	    				remote: "${ctx}/api/v1/menu/unique?id=${menu.id}"
	    			},
	    			name: {
	    				required: true,
	    				remote: "${ctx}/api/v1/menu/unique?id=${menu.id}"
	    			}
	    		},
	    		messages: {
	    			code: {
	    				required: "编码不能为空",
	    				remote: '编码已存在'
	    			},
	    			name: {
	    				required: "名称不能为空",
	    				remote: '名称已存在'
	    			}
	    		},
	    		highlight: function(element) {
	    			$(element).addClass("validator_error");
	    	    },
	    	    unhighlight: function(element,errorClass) {
	    	    	$(element).addClass("validator_success");
	    		}
	    	});
    	});
	    
        //改变图标
        $('#selectBtn').click(function() {
        	$.jBox.open("iframe:${ctx}/api/v1/icon?value=${menu.css}&_method=GET", "选择图标", 900, 450, {
				buttons:{ 
					"确定": "ok", "关闭": true 
				},submit:function(v, h, f){
					if(v == "ok"){
						var css = h.find("iframe")[0].contentWindow.iconText.value;
			        	if(css != '' && css != undefined){
			        		$("#iconTag").attr("class", "");
				        	$("#iconTag").addClass(css);
					    	$("#css").val(css);
			        	}
					}
				},loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
        })
        
      	//选择权限
        $('#selectPermissionBtn').click(function() {
        	$.jBox.open("iframe:${ctx}/api/v1/permission/view?_method=GET&permission="+$("#permission").val(), "选择权限", 800, 450, {
				buttons:{ 
					"确定": "ok", "关闭": true 
				},submit:function(v, h, f){
					if(v == "ok"){
						var operations = h.find("iframe")[0].contentWindow.operations.value;
						$("#permissionText").text(operations);
						$("#permission").val(operations);
					}
				},loaded:function(h){
					$(".jbox-content", top.document).css("overflow-y","hidden");
				}
			});
        })
    </script>
</body>
</html>


