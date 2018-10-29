<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
	<title>抽奖管理</title>
	<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">抽奖列表</h1><hr/>
			</div>
			<div class="panel-body">
              	<form:form modelAttribute="draw" class="form-horizontal group-border hover-stripped" method="get" role="form" id="seachForm" cssStyle="margin-bottom:20px;">
          			<form:hidden path="pageIndex" id="pageIndex"/>
              		<form:hidden path="pageSize" id="pageSize"/>
              		<div class="form-group">
          				<label for="drawName" class="col-xs-1 control-label">抽奖名称：</label>
          				<div class="col-xs-2">
          					<form:input path="drawName" id="drawName" cssClass="form-control"/>
          				</div>
          				<div class="col-xs-5">
          					<input type="button" class="btn btn-primary" onclick="page()" value="查询">
          					<shiro:hasAnyPermissions name="draw:add,draw:update">
	                  			<input type="button" id="btnAdd" class="btn btn-success" onclick="window.location.href='${ctx}/api/v1/draw/0'" value="添加">
	                  			<input type="button" id="btnUpdate" class="btn btn-purple" value="修改">
                			</shiro:hasAnyPermissions>
                			<shiro:hasPermission name="draw:delete">
                 				<input type="button" id="btnDel" class="btn btn-danger" value="批量删除">
                			</shiro:hasPermission>
          				</div>
              		</div>
              	</form:form>
              	<table class="table table-bordered table-hover table-striped">
                 	<thead>
                      	<tr>
                			<th><input type="checkbox" id="parentCheckbox"></th>
							<th>抽奖名称</th>
							<th>抽奖标题</th>
							<th>抽奖类型</th>
							<th>开始日期</th>
							<th>结束日期</th>
							<th>抽奖比率</th>
							<th>过期天数</th>
						</tr>
                  	</thead>
                  	<tbody>
                      	<c:forEach items="${page.data}" var="draw">
							<tr>
								<td style="width:5px;">
	                           		<input type="checkbox" value="${draw.id}" name="child_items">
	                           	</td>
								<td>${draw.drawName}</td>
								<td>${draw.drawTitle}</td>
								<td>${draw.drawType}</td>
								<td><fmt:formatDate value="${draw.startDate}" pattern="yyyy-MM-dd"/></td>
								<td><fmt:formatDate value="${draw.endDate}" pattern="yyyy-MM-dd"/></td>
								<td>${draw.drawRatio}</td>
								<td>${draw.expiredDay}</td>
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
				window.location.href = "${ctx}/api/v1/draw/"+id;
			}
		});
    
	  	//删除数据
	    $('#btnDel').click(function() {
	    	var node_count = $("[name=child_items]:checked").length;
			if(node_count <= 0){
				$alert("请最少选择一行!",'提示');
				return ;
			}else{
				var url = '${ctx}/api/v1/test';
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
			$("#seachForm").attr("action","${ctx}/api/v1/draw");
			$("#seachForm").submit();
		}

    </script>
</body>
</html>


