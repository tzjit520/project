<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
	<title>IM</title>
	<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">IM用户</h1>
				<hr/>
			</div>
			<div class="panel-body">
              	<form:form modelAttribute="imUsers" class="form-horizontal group-border hover-stripped" method="get" role="form" id="seachForm" cssStyle="margin-bottom:20px;">
          			<form:hidden path="pageIndex" id="pageIndex"/>
              		<form:hidden path="pageSize" id="pageSize"/>
              		<div class="form-group">
          				<label for="name" class="col-xs-1 control-label">姓名：</label>
          				<div class="col-xs-2">
          					<form:input path="name" id="name" cssClass="form-control"/>
          				</div>
          				<div class="col-xs-8">
          					<input type="button" class="btn btn-primary" onclick="page()" value="查询">
          					<shiro:hasAnyPermissions name="im:add,im:update">
	                  			<input type="button" id="btnAdd" class="btn btn-success" onclick="window.location.href='${ctx}/api/v1/imUsers/0'" value="添加">
	                  			<input type="button" id="btnUpdate" class="btn btn-purple" value="修改">
                			</shiro:hasAnyPermissions>
                			<shiro:hasPermission name="im:delete">
                 				<input type="button" id="btnDel" class="btn btn-danger" value="批量删除">
                			</shiro:hasPermission>
          				</div>
              		</div>
              	</form:form>
              	<table class="table table-bordered table-hover table-striped">
                 	<thead>
                      	<tr>
                			<th><input type="checkbox" id="parentCheckbox"></th>
							<th>登录名</th>
							<th>昵称</th>
							<th>姓名</th>
							<th>性别</th>
							<th>年龄</th>
							<th>生日</th>
							<th>电话</th>
							<th>邮箱</th>
						</tr>
                  	</thead>
                  	<tbody>
                      	<c:forEach items="${page.data}" var="user">
							<tr>
								<td style="width:5px;">
	                           		<input type="checkbox" value="${user.id}" name="child_items">
	                           	</td>
								<td>${user.code}</td>
								<td>${user.nickName}</td>
								<td>${user.name}</td>
								<td>${user.sex}</td>
								<td>${user.age}</td>
								<td><fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd"/></td>
								<td>${user.telePhone}</td>
								<td>${user.email}</td>
							</tr>
						</c:forEach>
                	</tbody>
            	</table>
           	 	<div class="form-group" style="margin-top:-20px">
       	 	 		<div id="page"></div>
          		</div>
   			</div>
       	</div>
   	</div>
 	<div class="clearfix"></div>
    
    <script type="text/javascript">
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
				window.location.href = "${ctx}/api/v1/imUsers/"+id;
			}
		});
    
	  	//删除数据
	    $('#btnDel').click(function() {
	    	var node_count = $("[name=child_items]:checked").length;
			if(node_count <= 0){
				$alert("请最少选择一行!",'提示');
				return ;
			}else{
				var url = '${ctx}/api/v1/imUsers';
				var ids = "";
				for(var i = 0 ; i < node_count ; i++){
					var node = $("[name=child_items]:checked")[i];
					if(i == 0){
						ids += node.value;
					}else{
						ids += ","+ node.value;
					}
				}
				commonService.deleteByIds(url,{ids:ids});
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
			$("#seachForm").attr("action","${ctx}/api/v1/imUsers");
			$("#seachForm").submit();
		}

    </script>
</body>
</html>


