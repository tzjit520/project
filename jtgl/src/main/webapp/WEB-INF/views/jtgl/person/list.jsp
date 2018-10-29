<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>人员管理</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">人员管理</h1>
				<hr/>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="person" class="form-horizontal group-border hover-stripped" method="get" role="form" id="seachForm" cssStyle="margin-bottom:20px;">
					<form:hidden path="pageIndex" id="pageIndex" />
					<form:hidden path="pageSize" id="pageSize" />
					<div class="form-group">
						<label for="name" class="col-xs-1 control-label">姓名：</label>
						<div class="col-xs-1" style="min-width:150px">
							<form:input path="name" id="name" cssClass="form-control" />
						</div>
						<label for="position" class="col-xs-1 control-label">生日月份：</label>
						<div class="col-xs-1" style="min-width:130px">
							<form:select path="position" id="position" cssClass="form-control select2">
								<form:option value="">请选择</form:option>
								<form:option value="01">一月份</form:option>
								<form:option value="02">二月份</form:option>
								<form:option value="03">三月份</form:option>
								<form:option value="04">四月份</form:option>
								<form:option value="05">五月份</form:option>
								<form:option value="06">六月份</form:option>
								<form:option value="07">七月份</form:option>
								<form:option value="08">八月份</form:option>
								<form:option value="09">九月份</form:option>
								<form:option value="10">十月份</form:option>							
								<form:option value="11">十一月份</form:option>
								<form:option value="12">十二月份</form:option>
							</form:select>
						</div>
						<div class="col-xs-6">
							<input type="button" class="btn btn-primary" onclick="page()" value="查询">
							<shiro:hasAnyPermissions name="system:add,system:update">
								<input type="button" id="btnAdd" class="btn btn-success" onclick="window.location.href='${ctx}/api/v1/person/0'" value="添加">
								<input type="button" id="btnUpdate" class="btn btn-purple" value="修改">
							</shiro:hasAnyPermissions>
							<shiro:hasPermission name="system:delete">
								<input type="button" id="btnDel" class="btn btn-danger" value="删除">
							</shiro:hasPermission>
						</div>
					</div>
				</form:form>
				<table class="table table-bordered table-hover table-striped">
					<thead>
						<tr>
							<th style="width:5px">
								<input type="checkbox" id="parentCheckbox">
							</th>
							<th>姓名</th>
							<th>性别</th>
							<th>年龄</th>
							<th>出生日期</th>
							<th>电话</th>
							<th>生肖</th>
							<th>星座</th>
							<th>描述</th>
							<th>状态</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${page.data}" var="person">
							<tr>
								<td>
									<input type="checkbox" value="${person.id}" name="child_items">
								</td>
								<td>${person.name}</td>
								<td>${person.sex}</td>
								<td>${person.age}</td>
								<td>
									<fmt:formatDate value="${person.birthday}" pattern="yyyy-MM-dd" />
								</td>
								<td>${person.phone}</td>
								<td>${person.zodiac}</td>
								<td>${person.constellations}</td>
								<td>${person.remark}</td>
								<td>${person.status==1?'正常':'无效'}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="form-group" style="margin-top: -20px">
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
				window.location.href = "${ctx}/api/v1/person/"+id;
			}
		});
    
	  	//暂停 
	    $('#btnZT,#btnHF,#btnZXYC').click(function() {
	    	var node_count = $("[name=child_items]:checked").length;
			if(node_count <= 0){
				$alert("请选择一行!",'提示');
				return ;
			}else if(node_count > 1){
				$alert("不能选择多行!",'提示');
				return ;
			}else{
				var url = '${ctx}/api/v1/person';
				var czUrl = '';
				if(this.id == 'btnZT'){
					czUrl = url+'/stopSchedule';
				}else if(this.id == 'btnHF'){
					czUrl = url+'/startSchedule';
				}else if(this.id == 'btnZXYC'){
					czUrl = url+'/runOnce';
				}
				var id = $("[name=child_items]:checked")[0].value;
				$.ajax({
	    			type: 'get',
	    			url: czUrl,
	    			data: {
	    				id: id
    				},
	    			success:function(data){
	    				if(data.code == 0){
	    					$.jBox.tip("操作成功", '提示');
	    					setTimeout(function(){
		    					window.location.href = url;
	    					}, 1000);
	    				}else{
	    					$alert(data.message,'错误提示');
	    				}
	    			}
	    		});
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
							var url = '${ctx}/api/v1/person';
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
			$("#seachForm").attr("action","${ctx}/api/v1/person");
			$("#seachForm").submit();
		}

    </script>
</body>
</html>


