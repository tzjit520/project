<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>多数据源测试</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">多数据源测试</h1><hr/>
			</div>
			<div class="panel-body">
				<h1>
					<small>default数据源</small>
				</h1>
				<table class="table table-bordered table-hover table-striped">
					<thead>
						<tr>
							<th>姓名</th>
							<th>年龄</th>
							<th>出生日期</th>
							<th>简介</th>
							<th>创建人</th>
							<th>创建时间</th>
							<th>描述</th>
							<th>状态</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listUser_db1}" var="user">
							<tr>
								<td>${user.name}</td>
								<td>${user.age}</td>
								<td>
									<fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd" />
								</td>
								<td>${user.info}</td>
								<td>${fns:getUserById(user.createBy).name}</td>
								<td>
									<fmt:formatDate value="${user.createDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								<td>${user.remark}</td>
								<td class="${user.status==1?'success':'danger'}">${user.status==1?'正常':'无效'}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<hr />

				<h1>
					<small>mysql数据源</small>
				</h1>
				<table class="table table-bordered table-hover table-striped">
					<thead>
						<tr>
							<th>姓名</th>
							<th>年龄</th>
							<th>出生日期</th>
							<th>简介</th>
							<th>创建人</th>
							<th>创建时间</th>
							<th>描述</th>
							<th>状态</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${listUser_db2}" var="user">
							<tr>
								<td>${user.name}</td>
								<td>${user.age}</td>
								<td>
									<fmt:formatDate value="${user.birthday}" pattern="yyyy-MM-dd" />
								</td>
								<td>${user.info}</td>
								<td>${fns:getUserById(user.createBy).name}</td>
								<td>
									<fmt:formatDate value="${user.createDate}" pattern="yyyy-MM-dd HH:mm:ss" />
								</td>
								<td>${user.remark}</td>
								<td class="${user.status==1?'success':'danger'}">${user.status==1?'正常':'无效'}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>

	<script type="text/javascript">
		
	</script>
</body>
</html>


