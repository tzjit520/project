//获取项目名称
var pathName=window.document.location.pathname;
var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
var array = new Array();
$(function(){
	$.ajax({
		type: 'get',
		url: projectName+"/api/v1/message/all",
		data: {},
		async: false,
		success:function(result){
			if(result.code == 0){
				array = result.data;
			}
		 }
	});
	
	if(array.length == 1){
		$("<li class='line-limit-length'>"+ array[0].title + "：" + array[0].content +"</li>").appendTo($("#announce"));
	}else if(array.length > 1){
		announceArray();
		announceNoticeList();
	}
	
})
    
/***
 * 循环跳动
 */
function announceArray(){
	if(array.length > 0){
		for(var i = 0; i < array.length; i++){
			$("<li class='line-limit-length'>"+ array[i].title +"："+ array[i].content +"</li>").appendTo($("#announce"));
		}
	}else{
		$("<li>暂无消息!</li>").appendTo($("#announce"));
	}
}

/** 消息长度控制 */
function announceLength(array,i){
	var c = ""; var t = ""; var content = "";
	if(i != null && i != "" && i != "undefined"){
		c = array[i].content ;
		t = array[i].title;
	}else{
		c = array[0].content ;
		t = array[0].title;
	}
	if(c.length > 30){
		var j = t.length +1 ;
		for(var k = 0 ; k < c.length ; k++){
			if(j==50){
				content = content + c[k]+"...";
				break;
			}else{
				content = content + c[k];
			}
			j++;
		}
		return content;
	}
	return c;
}

/***
 * 消息滚动
 */
function announceNoticeList(){
	//滚动公告
    var $noticeList = $(".notice-list");
    var $noticeItems = $noticeList.children();
    var noticeIndex = 0;
    $noticeItems.css("position", "absolute").slice(1).remove();

    function noticeList() {
    	$noticeItems.eq(noticeIndex).animate({
    		top: "-100%"
    	}, 400, function() {
    		$(this).remove();
    	});
    	noticeIndex = noticeIndex >= $noticeItems.length - 1 ? 0 : noticeIndex + 1;
    	$noticeItems.eq(noticeIndex).css("top", "100%").appendTo($noticeList).animate({
    		top: 0
    	}, 400);
    };
    $noticeList.hover(function() {
        clearInterval(this.timer);
    }, function() {
        this.timer = setInterval(noticeList, 5e3);
    }).triggerHandler("mouseleave");
}
