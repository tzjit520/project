<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
	<title>邮箱</title>
	<%@ include file="/templates/include.jsp"%>
</head>

<body>
	<div class="content-wrapper">
        <div class="outlet">
        	<form action="" class="form-horizontal group-border hover-stripped" method="get" role="form" id="seachForm" style="margin-bottom:10px;">
        		<div class="form-group">
       				<div class="col-xs-2">
       					<input name="name" id="name" class="form-control input-xlarge" placeholder="Search for email ..."/>
       				</div>
        		</div>
        	</form>     
	        <table class="table table-striped table-hover table-fixed-layout non-responsive">
	            <tbody>
	            	<c:forEach items="${page.data}" var="mail">
	                <tr>
	                    <td class="email-select input-mini">
	                        <label class="checkbox">
	                            <input class="check" type="checkbox" value="${mail.id}">
	                        </label>
	                    </td>
	                    <td class="email-star input-mini"><i class="${mail.mark==1?'im-star3 s20':'im-star s20'}"></i>
	                    </td>
	                    <td class="email-subject"><a href="email-read.html">${mail.title}</a>
	                    </td>
	                    <td class="email-intro">
	                        <a href="email-read.html">
	                            <span class="label label-teal mr10">内容</span> ${mail.content}
	                            <!-- <span class="text-muted small ml10"></span> -->
	                        </a>
	                    </td>
	                    <td class="email-date text-right"><fmt:formatDate value="${mail.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	                </tr>
	            	</c:forEach>
	            </tbody>
	        </table>
        </div>
    </div>
 	<div class="clearfix"></div>
    
    <script type="text/javascript">
	    $(function(){
	    	function tableHighlight () {
	    	    var table = $('.table');
	    	    var chboxes = table.find('input.check');

	    	    chboxes.on('ifChecked ifUnchecked', function(event) {        
	    	        if (event.type == 'ifChecked') {
	    	            $(this).closest('tr').addClass('highlight');
	    	        } else {
	    	            $(this).closest('tr').removeClass('highlight');
	    	        }
	    	    });
	    	}

	    	tableHighlight();
			
			var emailTable = $('.table');
			var emailStar = emailTable.find('td.email-star>i');

			//setup the star in click
			emailStar.click(function() {
				if($(this).hasClass('im-star')) {
					$(this).removeClass('im-star s20').addClass('im-star3 s20');
					//make callback here

				} else {
					$(this).removeClass('im-star3 s20').addClass('im-star s20');
					//make callback here
				}
			});
		})
		
    </script>
</body>
</html>
