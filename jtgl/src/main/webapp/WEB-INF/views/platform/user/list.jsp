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
                <h1 class="page-header">用户信息</h1><hr/>
            </div>
            <div class="panel-body">
              	<form:form modelAttribute="user" class="form-horizontal group-border hover-stripped" method="get" role="form" id="userForm" cssStyle="padding-bottom:20px;">
           			<form:hidden path="pageIndex" id="pageIndex"/>
               		<form:hidden path="pageSize" id="pageSize"/>
               		<div class="form-group">
   						<label for="code" class="col-xs-1 control-label">用户名：</label>
   						<div class="col-xs-2">
          					<form:input path="code" id="code" cssClass="form-control"/>
          				</div>
   						<label for="name" class="col-xs-1 control-label">姓名：</label>
   						<div class="col-xs-2">
          					<form:input path="name" id="name" cssClass="form-control"/>
          				</div>
          				<div class="col-xs-5">
          					<input type="button" class="btn btn-primary" onclick="page()" value="查询">
          					<shiro:hasAnyPermissions name="user:add,user:update">
                    			<input type="button" id="btnAdd" class="btn btn-success" value="添加">
                    			<input type="button" id="btnUpdate" class="btn btn-purple" value="修改">
                   			</shiro:hasAnyPermissions>
                   			<shiro:hasPermission name="user:delete">
                    			<input type="button" id="btnDel" class="btn btn-danger" value="删除">
                   			</shiro:hasPermission>
                   			<shiro:hasPermission name="user:add">
                    			<input type="button" id="btnImport" class="btn btn-magenta" data-toggle="modal" data-target="#myModal" value="导入">
                   			</shiro:hasPermission>
          				</div>
               		</div>
               	</form:form>
               	<div id="message" style="display: none"></div>

       			<table class="table table-bordered table-hover table-striped">
                   	<thead>
                      	<tr>
                   			<th style="width:5px"><input type="checkbox" id="parentCheckbox"></th>
							<th style="width:35px">头像</th>
							<th>公司</th>
							<th>部门</th>
							<th>用户名</th>
							<th>姓名</th>
							<th>工号</th>
							<th>性别</th>
							<th>手机 </th>
							<th>邮箱</th>
							<th>描述</th>
						</tr>
                   	</thead>
                    <tbody>
                        <c:forEach items="${page.data}" var="user">
							<tr>
								<td><input type="checkbox" value="${user.id}" name="child_items"></td>
								<td>
              						<c:if test="${!empty user.headimgurl}">
	              						<img alt="${user.name}" src="${ctx}/upload/headImg/${user.headimgurl}" width="40" height="40">
              						</c:if>
								</td>
								<td>${user.companyUnit.name}</td>
								<td>${user.departmentUnit.name}</td>
								<td>${user.code}</td>
								<td>${user.name}</td>
								<td>${user.workNumber}</td>
								<td>${user.sex}</td>
								<td>${user.mobile}</td>
								<td>${user.email}</td>
								<td>${user.remark}</td>
							</tr>
						</c:forEach>
                   	</tbody>
               	</table>
               	<div class="form-group" style="margin-top:-20px">
       	 	 		<div id="page"></div>
          		</div>
                <!-- 导入模板 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog" style="width:450px">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                <h4 class="modal-title" id="myModal2Label">导入用户数据</h4>
                            </div>
                            <div class="modal-body">
                                <form id="importForm" name="importForm" action="${ctx}/api/v1/user/import" method="post" enctype="multipart/form-data" class="form-search" style="padding-left:20px;" >
									<div>
										<input type="file" name="file" id="file" style="display:none">
									</div>
									<div style="margin-top:8px;">
										<input class="btn btn-primary" id="uploadUser" style="height:32px;" type="button" value="导入"/>
										<span style="padding-left:20px"><a href="${ctx}/static/template/sys_user.xlsx">下载模板</a></span>
									</div>
									<div style="margin-top:8px;">
										<small style="color:red">仅允许导入<strong>"xls"</strong> 或 <strong>"xlsx"</strong> 格式文件！</small>
									</div>
								</form>
                            </div>
                            <!-- <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                <button type="button" class="btn btn-primary">Save changes</button>
                            </div> -->
                        </div>
                    </div>
                </div>
        	</div>
        </div>
    </div>
 	<div class="clearfix"></div>
    
    <script type="text/javascript">
    
	    $(function(){

			$(":file").filestyle({
				buttonText: "选择文件",
				classButton: "btn btn-primary",
				classInput: "form-control file-upload",
				classIcon: "fa-plus-sign"
			});

		    //导入用户数据
		    $("#importForm").fileupload({
		        autoUpload: false,//不立即上传
		        acceptFileTypes: /(\.|\/)(xls?x)$/i
		        //maxFileSize: 20971520 // 20 MB
			}).on('fileuploadadd', function (e, data) {
				data.context = $('#uploadUser').click(function () {
                    data.submit();
                });
    		}).on('fileuploaddone', function (e, data) {
    			var mclass = 'bs-callout bs-callout-info fade in';
	      		var phtm = "";
		      	if(data.result.code == 0){
		      		$('#myModal').modal('hide')
		    	  	var results = data.result.data;
		      		for(var i=0; i<results.length; i++){
		      			phtm += "<p>"+results[i]+"</p>";
		      		}
			  	}else{
			  		var msg = data.result.message;
			  		mclass = 'bs-callout bs-callout-danger fade in';
			  		phtm += "<p>"+msg+"</p>";
			  	}
		      	var htm = '<div class="'+mclass+'">'+
	      			'<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>'+
	                '<h4>导入用户提示</h4>'+
	                '<div>'+ phtm+ '</div></div>';
	      		$("#message").show();
	      		$("#message").html(htm);
			});
		})

		//添加数据
	    $('#btnAdd').click(function() {
	    	window.location.href = "${ctx}/api/v1/user/0";
			//window.parent.frames.location.href="${ctx}/api/v1/user/0";
		});
	    
		//修改数据 
	    $('#btnUpdate').click(function() {
	    	var node_count = $("[name=child_items]:checked").length;
			if(node_count <= 0){
				$alert("请选择一行!",'提示');
				return ;
			}else if(node_count > 1){
				$alert("不能选择多行进行修改!",'提示');
				return ;
			}else{
				var id = $("[name=child_items]:checked")[0].value;
				window.location.href = "${ctx}/api/v1/user/"+id;
				//window.parent.frames.location.href="${ctx}/api/v1/user/"+id;
			}
		});
    
	  	//删除数据
	    $('#btnDel').click(function() {
	    	var node_count = $("[name=child_items]:checked").length;
			if(node_count <= 0){
				$alert("请最少选择一行!",'提示');
				return ;
			}else{
				bootbox.confirm({
					title: "删除提示",
					message: "确定删除选中的数据?",
					buttons: {
				        confirm: {
				            label: '确定',
				            className: 'btn-success'
				        },
				        cancel: {
				            label: '取消',
				            className: 'btn-danger'
				        }
				    },
				    callback: function(result) {
				    	console.log(result);
				    	if(result){
				    		var ids = "";
							for(var i = 0 ; i < node_count ; i++){
								var node = $("[name=child_items]:checked")[i];
								if(i == 0){
									ids += node.value;
								}else{
									ids += ","+ node.value;
								}
							}
							var url = '${ctx}/api/v1/user';
							$.ajax({
				    			type: 'post',
				    			url: url,
				    			data: {
				    				_method : "delete",
				    				ids: ids
			    				},
				    			success:function(data){
				    				if(data.code == 0){
				    					$.jBox.tip("删除成功", '提示');
				    					setTimeout(function(){
					    					window.location.href = url;
				    					}, 1500);
				    				}else{
				    					$alert(data.message,'错误提示');
				    				}
				    			}
				    		});
				    	}
				    }
				});
			}
		});
	  
		createPageNav({
		  $container: $("#page"),
			pageCount: '${page.pageCount}',//总页数
			currentNum: '${page.pageIndex}',//当前页码
			totalCount: '${page.total}', //总数量
			pageSize: '${page.pageSize}',//每页显示多少条
			maxCommonLen: 8,
			beforeFun: page
		});

		function page(num, pageSize){
			if(num == undefined){
				num = 1;
			}
			if(pageSize == undefined){
				pageSize = 15;
			}
			$("#pageIndex").val(num);
			$("#pageSize").val(pageSize);
			$("#userForm").attr("action","${ctx}/api/v1/user");
			$("#userForm").submit();
		}

    </script>
</body>
</html>