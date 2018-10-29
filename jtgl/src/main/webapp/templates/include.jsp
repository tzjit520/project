<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>
<!-- base标签为页面上所有链接规定默认地址或默认目标，链接包括<a>、<img>、<link>、<form>标签中的URL -->
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";
%>
<base href="<%=basePath%>" target="_self"/>

<%@include file="meta.jsp" %>
<%@include file="css.jsp" %>
<%@include file="js.jsp" %>
