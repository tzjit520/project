<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
	<title>404</title>
	<%@ include file="/templates/include.jsp"%>
</head>

<body class="error-page">
    <div class="container animated fadeInDown">
        <h1 class="error-number">404</h1>
        <h1 class="text-center mb25">您想要的资源飞出地球外了 ...</h1>
        <p class="text-center s24">去看看其他精彩内容吧.</p>
        <div class="text-center mt25">
            <div class="btn-group">
                <a href="javascript: history.go(-1)" class="btn btn-default btn-lg"><i class="en-arrow-left8"></i>  返回上一页</a>
                <a href="index.html" class="btn btn-default btn-lg"><i class="im-home"></i> 主页</a>
                <a href="#" class="btn btn-default btn-lg"><i class="en-mail"></i> 邮件反馈</a>
            </div>
        </div>
    </div>
</body>
</html>


