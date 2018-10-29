<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/templates/taglibs.jsp"%>
<html>
<head>
	<title>聊天</title>
	<%@ include file="/templates/include.jsp"%>
</head>
<body>
	<div class="content-wrapper">
        <div class="row">
            <div class="col-lg-12 heading">
                <h1 class="page-header">聊天</h1>
            </div>
        </div>
        <div class="outlet">
            <div class="row">
                <div class="panel-body">
                	<table style="min-width:1360px;border-collapse:separate;border-spacing:15px 15px;">
           				<tr>
           					<td class="d_border" colspan="2"></td>
           				</tr>
           				<tr>
           					<td class="d_td"><label for="code" class="control-label">聊天类型：</label></td>
           					<td style="width:245px">
           						<label class="radio-inline" style="margin-left:10px">
		                        	<input type="radio" name="chatType" value="WebSocket" onclick="updateUrl('${ctx}/websck');">WebSocket
	                            </label>
	                            <label class="radio-inline">
	                            	<input type="radio" name="chatType" value="SocketJS" checked="checked" onclick="updateUrl('${ctx}/sockjs/websck');">SocketJS
	                            </label>
           					</td>
           				</tr>
           				<tr>
           					<td class="d_border" colspan="2"></td>
           				</tr>
           				<tr id="sockJsTransportSelect">
           					<td class="d_td"><label for="code" class="control-label">TransPort：</label></td>
           					<td style="width:245px">
           						<select onchange="updateTransport(this.value)" class="form-control select2">
					              	<option value="all">all</option>
					              	<option value="websocket">websocket</option>
					              	<option value="xhr-polling">xhr-polling</option>
					              	<option value="jsonp-polling">jsonp-polling</option>
					              	<option value="xhr-streaming">xhr-streaming</option>
					              	<option value="iframe-eventsource">iframe-eventsource</option>
					              	<option value="iframe-htmlfile">iframe-htmlfile</option>
					            </select>
           					</td>
           				</tr>
           				<tr>
           					<td class="d_border" colspan="2"></td>
           				</tr>
           				<tr>
           					<td class="d_td"></td>
           					<td style="width:245px">
					            <button class="btn btn-primary" id="connect" onclick="connect();">连接</button>
					            <button class="btn btn-dark" id="disconnect" disabled="disabled" onclick="disconnect();">关闭连接</button>
           					</td>
           				</tr>
           				<tr>
           					<td class="d_border" colspan="2"></td>
           				</tr>
           				<tr>
           					<td class="d_td">好友：</td>
           					<td style="width:245px">
           						<select id="friends" class="form-control select2">
					              	<option value="13">刘露</option>
					              	<option value="11">谭志杰</option>
					              	<option value="15">谭慧娟</option>
					            </select>
           					</td>
           				</tr>
           				<tr>
           					<td class="d_border" colspan="2"></td>
           				</tr>
           				<tr>
           					<td class="d_td">消息内容：</td>
           					<td style="width:245px">
           						<textarea id="message" class="form-control"></textarea>
           					</td>
           				</tr>
           				<tr>
           					<td class="d_border" colspan="2"></td>
           				</tr>
           				<tr>
           					<td class="d_td"></td>
           					<td style="width:245px">
           						<button id="send" onclick="sendMessage();" disabled="disabled" class="btn btn-primary">发送</button>
           					</td>
           				</tr>
           				<tr>
           					<td class="d_border" colspan="2"></td>
           				</tr>
           				<tr>
           					<td class="d_td"></td>
           					<td style="width:245px">
           						<div id="console-container">
							        <div id="console"></div>
							    </div>
           					</td>
           				</tr>
       				</table>
                </div>
            </div>
        </div>
    </div>
 	<div class="clearfix"></div>
    <script src="${ctx}/static/plugin/socketjs/sockjs.js"></script>
    <script type="text/javascript">
	    var ws = null;
	    var url = '${ctx}/sockjs/websck';
	    var transports = [];
	    var userId = '${user.id}';//发送人
		
	    
	    function setConnected(connected) {
	        document.getElementById('connect').disabled = connected;
	        document.getElementById('disconnect').disabled = !connected;
	        document.getElementById('send').disabled = !connected;
	    }
	
	    function connect() {
	        if (!url) {
	            return;
	        }
	        //ws = (url.indexOf('sockjs') != -1) ?new SockJS(url, undefined, {protocols_whitelist: transports}) : new WebSocket(url);
	        //if (!'WebSocket' in window) {
	        if(url.indexOf('sockjs') != -1){
	            ws = new SockJS(url+"?userId="+userId);
	        }else {
	            ws= new WebSocket(url+"?userId="+userId);
	        }
            console.log(url);
	        ws.onopen = onOpen;
	        ws.onmessage = onMessage;
	        ws.onclose = onClose;
	    }
	
	    function onOpen(event) {  
	    	$.jBox.tip('连接成功');
            setConnected(true);
	    }  
	  
	    function onMessage(event) {  
	    	//$.jBox.alert('Received:' + event.data, "提示");
            log(event.data);
	    }
	    
	    function onError() {  
	    	$.jBox.error("出错了!!", "提示");
	    } 
	    
	    function onClose(event) {  
	    	setConnected(false);
	    	$.jBox.tip('连接关闭');
            log(event);
	    }  
	    
	    function disconnect() {
	        if (ws != null) {
	            ws.close();
	            ws = null;
	        }
	        setConnected(false);
	    }
	
	    function sendMessage() {
	        if (ws != null) {
	        	//发送时间
	        	var sendTime = formatDateTime();
	        	//发送给某某
	        	var toUserId = $("#friends").val();
	        	//消息内容
	            var content = document.getElementById('message').value;
	        	var msg = "{userId:"+userId+",toUserId:"+toUserId+",sendTime:'"+sendTime+"',content:'"+content+"'}";
	            log('自己: ' + content);
	            ws.send(msg);
	        } else {
	            alert('connection not established, please connect.');
	        }
	    }
	
	    function updateUrl(urlPath) {
	        if (urlPath.indexOf('sockjs') != -1) {
	            url = window.location.protocol + "//" + window.location.host + urlPath;
	            $("#sockJsTransportSelect").show();
	        }else {
       			if (window.location.protocol == 'http:') {
	              	url = 'ws://' + window.location.host + urlPath;
	          	} else {
	              	url = 'wss://' + window.location.host + urlPath;
	          	}
       			$("#sockJsTransportSelect").hide();
	        }
	    }
	
	    function updateTransport(transport) {
	    	//alert(transport);
        	transports = (transport == 'all') ?  [] : [transport];
	    }
	    
	    function reconnect(){  
	        if (websocket != null) {  
	            websocket.close();  
	            websocket = null;  
	        }  
	        if ('WebSocket' in window) {  
	            websocket = new WebSocket("ws://" + url + "/ws");  
	        } else {  
	            websocket = new SockJS("http://" + url + "/sockjs/ws");  
	        }  
	        websocket.onopen = onOpen;  
	        websocket.onmessage = onMessage;  
	        websocket.onerror = onError;  
	        websocket.onclose = onClose;  
	    }  
	    
	    function log(message) {
	        var console = document.getElementById('console');
	        var p = document.createElement('p');
	        p.style.wordWrap = 'break-word';
	        p.appendChild(document.createTextNode(message));
	        console.appendChild(p);
	        while (console.childNodes.length > 25) {
	            console.removeChild(console.firstChild);
	        }
	        console.scrollTop = console.scrollHeight;
	    }
	    
	    function formatDateTime() {    
	        var date = new Date();  
	        var y = date.getFullYear();    
	        var m = date.getMonth() + 1;    
	        m = m < 10 ? ('0' + m) : m;    
	        var d = date.getDate();    
	        d = d < 10 ? ('0' + d) : d;    
	        var h = date.getHours();  
	        h = h < 10 ? ('0' + h) : h;  
	        var minute = date.getMinutes();  
	        var second = date.getSeconds();  
	        minute = minute < 10 ? ('0' + minute) : minute;    
	        second = second < 10 ? ('0' + second) : second;   
	        return y + '-' + m + '-' + d+' '+h+':'+minute+':'+second;    
	    };  
    </script>
</body>
</html>


