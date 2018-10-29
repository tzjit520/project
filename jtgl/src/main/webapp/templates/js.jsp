<%@ page language="java" pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" %>

<!-- 进度条插件 -->
<%-- <script src="<%=request.getContextPath()%>/static/assets/plugins/core/pace/pace.min.js"></script> --%>
<script src="<%=request.getContextPath()%>/static/jquery/jquery-1.8.3.min.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/js/jquery-ui.js"></script>

<script src="<%=request.getContextPath()%>/static/plugin/bootstrap/js/bootstrap.js"></script>
<script src="<%=request.getContextPath()%>/static/plugin/bootstrap/js/bootstrap_page.js"></script>
<script src="<%=request.getContextPath()%>/static/plugin/bootstrap/js/moment-with-locales.js"></script>
<script src="<%=request.getContextPath()%>/static/plugin/bootstrap/js/bootstrap-datetimepicker.js"></script>
<script src="<%=request.getContextPath()%>/static/plugin/bootstrap/js/bootstrap-filestyle/bootstrap-filestyle.js"></script>

<script src="<%=request.getContextPath()%>/static/assets/js/jRespond.min.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/plugins/core/slimscroll/jquery.slimscroll.min.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/plugins/core/slimscroll/jquery.slimscroll.horizontal.min.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/plugins/forms/autosize/jquery.autosize.js"></script>
<!-- quickSearch 是一个jQuery驱动的快速搜索插件,Ajax显示搜索结果 -->
<script src="<%=request.getContextPath()%>/static/assets/plugins/core/quicksearch/jquery.quicksearch.js"></script>
<!-- Bootbox.js是一个小型的JavaScript库，基于Bootstrap模态框开发，用于创建可编程的对话框 -->
<script src="<%=request.getContextPath()%>/static/assets/plugins/ui/bootbox/bootbox.js"></script>

<script src="<%=request.getContextPath()%>/static/assets/plugins/forms/icheck/jquery.icheck.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/plugins/forms/checkall/jquery.CheckAll.js"></script>
<!-- 一个jquery开发的标签功能加强插件，可以生成或删除标签，还能对输入重复标签进行检查，和JQuery autocomplete插件配合实现自动完成功能 -->
<script src="<%=request.getContextPath()%>/static/assets/plugins/forms/tags/jquery.tagsinput.min.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/plugins/ui/weather/skyicons.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/plugins/misc/highlight/highlight.pack.js"></script>
<!-- 轻量级jquery数字动画插件。该数字动画插件可以在页面滚动时,将指定的数字从0开始计数增加动画 -->
<script src="<%=request.getContextPath()%>/static/assets/plugins/misc/countTo/jquery.countTo.js"></script>
<!-- Gritter 是一个小型的 jQuery 消息通知插件 -->
<script src="<%=request.getContextPath()%>/static/assets/plugins/ui/notify/jquery.gritter.js"></script>
<!-- 复选框开关样式 -->
<script src="<%=request.getContextPath()%>/static/assets/plugins/forms/switch/jquery.onoff.js"></script>
<!-- 富文本编辑器 -->
<script src="<%=request.getContextPath()%>/static/assets/plugins/forms/tinymce/tinymce.min.js"></script>

<script src="<%=request.getContextPath()%>/static/assets/plugins/forms/validation/jquery.validate.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/plugins/forms/validation/additional-methods.min.js"></script>

<script src="<%=request.getContextPath()%>/static/assets/plugins/forms/select2/select2.min.js"></script>

<script src="<%=request.getContextPath()%>/static/plugin/jBox/jquery.jBox-2.3.js"></script>
<script src="<%=request.getContextPath()%>/static/plugin/jBox/jquery-migrate-1.2.1.min.js"></script>
<script src="<%=request.getContextPath()%>/static/plugin/jBox/i18n/jquery.jBox-zh-CN.js"></script>
		
<script src="<%=request.getContextPath()%>/static/assets/plugins/file/jquery.ui.widget.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/plugins/file/jquery.iframe-transport.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/plugins/file/jquery.fileupload.js"></script>
<!-- 下面2个js是有依赖的，缺少的话acceptFileTypes，maxFileSize 不会进行验证 -->
<script src="<%=request.getContextPath()%>/static/assets/plugins/file/jquery.fileupload-process.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/plugins/file/jquery.fileupload-validate.js"></script>

<!-- jquery treeTable -->
<script src="<%=request.getContextPath()%>/static/plugin/treeTable/jquery.treeTable.min.js"></script>

<script src="<%=request.getContextPath()%>/static/assets/js/jquery.sprFlat.js"></script>
<script src="<%=request.getContextPath()%>/static/assets/js/app.js"></script>

<!-- 省市下拉框数据 -->
<script type="text/javascript" src="<%=request.getContextPath()%>/static/system/district/district.js"></script>

<script type="text/javascript">
	var commonService = {};
		
	commonService.get = function(url, params){
		return "get";
	}
	
	commonService.deleteByIds = function(url, params){
		url = url + (url.indexOf("?")>-1?"&":"?")+"_method=DELETE"
		params ? params : {};
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
					$.ajax({
		    			type: 'post',
		    			url: url,
		    			data: params,
		    			success:function(data){
		    				if(data.code == 0){
		    					$.jBox.tip("删除成功");
		    					setTimeout(function(){
			    					window.location.href = url;
		    					}, 1000);
		    				}else{
		    					$alert(data.message,'错误提示');
		    				}
		    			}
		    		});
		    	}
		    }
		});
	}
</script>
