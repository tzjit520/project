<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<%@ attribute name="id" type="java.lang.String" required="true" description="编号"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="输入框名称"%>
<%@ attribute name="value" type="java.lang.String" required="true" description="输入框值"%>
<img id="${id}Icon" src="${ctxStatic}/${value}" style="display:${empty value?'none':''}"/>&nbsp;
<label id="${id}IconLabel">${not empty value?'':'无'}</label>
<input id="${id}" name="${name}" type="hidden" value="${value}"/>
<a id="${id}Button" href="javascript:" class="btn btn-dark">选择</a>&nbsp;&nbsp;

<script type="text/javascript">
	$("#${id}Button").click(function(){
		$.jBox.open("iframe:${ctx}/api/v1/icon?value="+$("#${id}").val(), "选择图标", 850, $(top.document).height()-380, {
            buttons:{"确定":"ok", "清除":"clear", "关闭":true}, submit:function(v, h, f){
                if (v=="ok"){
                	var icon = h.find("iframe")[0].contentWindow.$("#icon").val();
                	$("#${id}Icon").attr("src", '${ctxStatic}/${filePath}/'+icon);
                	$("#${id}Icon").show();
                	$("#${id}IconLabel").text('');
                }else if (v=="clear"){
                	$("#${id}Icon").hide();
                	$("#${id}IconLabel").text("无");
	                $("#${id}").val("");
                }
            }, loaded:function(h){
                $(".jbox-content", top.document).css("overflow-y","hidden");
            }
        });
	});
</script>