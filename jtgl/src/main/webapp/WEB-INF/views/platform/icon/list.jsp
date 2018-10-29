<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
<title>图标</title>
<%@ include file="/templates/include.jsp"%>
<style type="text/css">
	.active {
		color: #1E90FF
	}
	span:hover {
		color: #1E90FF
	}
</style>
</head>

<body>
	<div class="content-wrapper">
		<div class="outlet">
			<div class="panel-body icon-page">
				<div class="icon-search">
					<form>
						<input type="text" class="form-control" name="search" placeholder="搜索图标...">
					</form>
				</div>
				<div id="ecoico">
					<div class="page-header">
						<h4>常用图标</h4>
					</div>
					<c:forEach items="${icons}" var="css">
						<div class="col-lg-4 col-md-4 col-sm-4 col-xs-5">
							<i class="${css}">
								<c:choose>
									<c:when test="${value eq css}">
										<span id="${css}" class="active" onclick="selectIcon('${css}')">${css}</span>
									</c:when>
									<c:otherwise>
										<span id="${css}" onclick="selectIcon('${css}')">${css}</span>
									</c:otherwise>
								</c:choose>
							</i>
						</div>
					</c:forEach>
					<input type="hidden" id="iconText" value="${value}">
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>
	<script type="text/javascript">
	 	if ($('.icon-search input').length) {
	        $('.icon-search input').val('').quicksearch('#ecoico .col-lg-3', {
	        	'removeDiacritics': true,
	        });
	    } 
	 	
	 	function selectIcon(value){
	 		$("span").removeClass("active");
	 		$("#"+value).addClass("active");
	 		$("#iconText").val(value);
	 	}
 	</script>
</body>
</html>


