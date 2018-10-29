package com.jtgl.socket.interceptor;

import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;

import com.platform.system.user.model.SysUser;
import com.platform.system.user.service.SysUserService;
import com.platform.utils.SpringUtil;


@Component
public class HandshakeInterceptor extends HttpSessionHandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response, 
			WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {
		if (request instanceof ServletServerHttpRequest) {
			ServletServerHttpRequest serverHttpRequest = (ServletServerHttpRequest) request;
            String userId = serverHttpRequest.getServletRequest().getParameter("userId");
            if(StringUtils.isNotBlank(userId)){
            	//获取当前用户信息
            	SysUserService userService = (SysUserService)SpringUtil.getBean("sysUserService");
            	SysUser user = userService.selectById(Integer.valueOf(userId));
            	attributes.put("user", user);
            }
		}
		//解决The extension [x-webkit-deflate-frame] is not supported问题
		if(request.getHeaders().containsKey("Sec-WebSocket-Extensions")) {
			request.getHeaders().set("Sec-WebSocket-Extensions", "permessage-deflate");
        }
		return super.beforeHandshake(request, response, wsHandler, attributes);
	}

	@Override
	public void afterHandshake(ServerHttpRequest request,
			ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception ex) {
		super.afterHandshake(request, response, wsHandler, ex);
	}

}
