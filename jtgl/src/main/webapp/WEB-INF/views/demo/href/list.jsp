<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>DEMO</title>
<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="col-xs-12 heading">
				<h1 class="page-header">DEMO样例</h1>
			</div>
			<div class="col-xs-12">
				<div class="panel panel-default toggle">
					<div class="panel-heading">
						<h3 class="panel-title">聊天</h3>
					</div>
					<div class="panel-body">
						<form class="form-horizontal group-border" role="form">
							<div class="form-group">
								<label class="col-md-2 control-label">
									<a href="${ctx}/api/v1/demo/tzj" target="homepage">谭志杰</a>
								</label>
								<label class="col-md-2 control-label">
									<a href="${ctx}/api/v1/demo/liulu" target="homepage">刘露</a>
								</label>
								<label class="col-md-2 control-label">
									<a href="${ctx}/api/v1/demo/thj" target="homepage">谭慧娟</a>
								</label>
							</div>
							<div class="form-group">
								<shiro:hasRole name="user">
									<label class="col-md-2 control-label">拥有[user]角色</label>
								</shiro:hasRole>
								<shiro:hasRole name="admin">
									<label class="col-md-2 control-label">拥有[admin]角色</label>
								</shiro:hasRole>
							</div>
							<div class="form-group">
								<table class="table table-bordered">
									<c:forEach items="${fns:getMenus()}" var="menu">
										<tr>
											<td style="width: 100px">${menu.name}${menu.depth}</td>
										</tr>
										<c:if test="${fn:length(menu.childrenMenus) > 0}">
											<c:forEach items="${menu.childrenMenus}" var="childMenu">
												<tr>
													<td></td>
													<td style="width: 100px">${childMenu.name}${childMenu.depth}</td>
												</tr>
												<c:if test="${fn:length(childMenu.childrenMenus) > 0}">
													<c:forEach items="${childMenu.childrenMenus}" var="cMenu">
														<tr>
															<td></td>
															<td></td>
															<td>${cMenu.name}${cMenu.depth}</td>
														</tr>
													</c:forEach>
												</c:if>
											</c:forEach>
										</c:if>
									</c:forEach>
								</table>
							</div>
							<div class="form-group">
								<label class="col-md-2 control-label">
									<c:set value="1" var="cc" />
									<c:if test="${cc != 0 }">
										<c:forEach items="${childMenu.childrenMenus}" var="cMenu" varStatus="dindex">
	                         			${cMenu.name}${cMenu.depth}
	                         			<c:if test="${dindex ==5 }">
												<c:set value="0" var="cc" />
											</c:if>
										</c:forEach>
									</c:if>
								</label>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>

	<script type="text/javascript">
		
	</script>
</body>
</html>


