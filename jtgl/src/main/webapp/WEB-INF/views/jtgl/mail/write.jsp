<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
	<title>发邮件</title>
	<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
        <div class="outlet">
	        <form:form modelAttribute="mail" action="${ctx}/api/v1/mail" onsubmit="return submitForm();" method="post" id="emailForm" name="emailForm" role="form" cssClass="form-horizontal group-border hover-stripped">
	        	<div class="form-group">
	                <div class="col-xs-12">
	                	<select class="form-control select2" name="toUserId" multiple>
	                        <optgroup label="人员">
		                		<c:forEach items="${listUser}" var="user">
		                			<option value="${user.id}">${user.name}</option>
		                		</c:forEach>
	                        </optgroup>
	                    </select>
	                </div>
	        	</div>
	        	<div class="form-group">
	                <div class="col-xs-12">
	                    <form:input path="title" id="title" cssClass="form-control" placeholder="主题 "/>
	                </div>
	        	</div>
	        	<div class="form-group">
	                <div class="col-xs-12">
	                	<input type="hidden" name="content" id="content"/>
	                	<textarea name="contentHtml" id="email-text" class="form-control tinymce" rows="18" placeholder="主要内容 "></textarea>
	                </div>
	        	</div>
	        	<div class="form-group">
	        		<div class="col-xs-offset-1">
	                    <input type="submit" value="发送" class="btn btn-primary ml15"/>
	                    <input type="button" value="返回" onclick="history.go(-1)" class="btn btn-info ml15"/>
	                </div>
	        	</div>
	        </form:form>
	    </div>
    </div>
 	<div class="clearfix"></div>
    
    <script type="text/javascript">
	  	//表单提交
	    function submitForm(){
	  		//带html标签的内容
	  		var c = tinymce.activeEditor.getContent();
	  		//不带html标签的内容
	  		var activeEditor = tinymce.activeEditor;
	  		var editBody = activeEditor.getBody();
	  		activeEditor.selection.select(editBody);
	  		var text = activeEditor.selection.getContent( { 'format' : 'text' } );
	  		if(text == "" || text == null){
	  			$alert("主要内容不能为空");
	  			return false;
	  		}
	  		$("#content").val(text);
	  		$("[type=submit]").attr("disabled", true);
	    	return true;
	    }

    	$(function(){
    		
    		tinymce.init({
    		    selector: ".tinymce",
    		    menubar : false,
    		    plugins: []
    		});
    		
    		$("#emailForm").validate({
	    		ignore: null,
	    		ignore: 'input[type="hidden"]',
	    		errorPlacement: function(error, element) {
	    			error.insertAfter(element);
	    		}, 
	    		errorClass: 'help-block',
	    		rules: {
	    			title: {
	    				required: true
	    			},
	    			toUserId: {
	    				required: true
	    			}
	    		},
	    		messages: {
	    			title: {
	    				required: "主题不能为空"
	    			},
	    			toUserId: {
	    				required: "收件人不能为空"
	    			}
	    		},
	    		highlight: function(element) {
	    			$(element).addClass("validator_error");
	    	    },
	    	    unhighlight: function(element,errorClass) {
	    	    	$(element).addClass("validator_success");
	    		}
	    	});
    	})
    </script>
</body>
</html>
