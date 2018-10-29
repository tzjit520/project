<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>401</title>
	<%@ include file="/templates/include.jsp"%>
</head>

<body class="error-page">
    <div class="container animated fadeInDown">
        <h1 class="error-number">401</h1>
        <h1 class="text-center mb25">当前请求需要认证...</h1>
        <p class="text-center s24">你需要先登录才能看到这个页面.</p>
        <div class="text-center mt25">
            <div class="btn-group">
                <a href="javascript: history.go(-1)" class="btn btn-default btn-lg"><i class="en-arrow-left8"></i>  去登陆</a>
                <a href="index.html" class="btn btn-default btn-lg"><i class="im-home"></i> 主页</a>
            </div>
        </div>
    </div>
</body>
</html>


