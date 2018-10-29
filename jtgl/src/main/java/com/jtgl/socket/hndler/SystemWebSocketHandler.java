/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.jtgl.socket.hndler;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.alibaba.fastjson.JSONObject;
import com.platform.system.user.model.SysUser;
import com.platform.system.user.service.SysUserService;

@Component
public class SystemWebSocketHandler implements WebSocketHandler {

	private static final Map<String, WebSocketSession> users;//所有连接的用户
    static {
        users = new HashMap<String, WebSocketSession>();
    }
    @Autowired
	private SysUserService userService;
    
	/**
     * 连接成功时候，会触发页面上onopen方法
     */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        System.out.println("连接成功....");
        //用户ID
        SysUser user = (SysUser)session.getAttributes().get("user");
        if(user != null){
        	System.out.println(user.getName()+"上线啦！！！");
        	users.put(user.getId()+"", session);
        	System.out.println("当前在线用户数量:"+ users.size());
        	//这块会实现自己业务，比如，当用户登录后，会把离线消息推送给用户
        	session.sendMessage(new TextMessage("成功建立socket连接"));
        }
    }

    /**
     * js调用websocket.send时候，会调用该方法
     */
	@Override
    public void handleMessage(WebSocketSession session, WebSocketMessage<?> wsm) throws Exception {
    	JSONObject jsonObj = (JSONObject) JSONObject.parse(wsm.getPayload().toString());
    	String userId = jsonObj.getString("userId");
    	String toUserId = jsonObj.getString("toUserId");
    	String content = jsonObj.getString("content");
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	//获取当前用户信息
    	SysUser user = userService.selectById(Integer.valueOf(userId));
    	TextMessage message = new TextMessage(user.getName() +" "+sdf.format(new Date())+":"+content);
    	sendMessageToUser(toUserId, message);
        //System.out.println(session.getHandshakeHeaders().getFirst("Cookie"));
    }

    /**
     * 连接出错处理，主要是关闭出错会话的连接，和删除在Map集合中的记录
     */
    @Override
    public void handleTransportError(WebSocketSession session, Throwable thrwbl) throws Exception {
        if(session.isOpen()){
        	session.close();
        }
        System.out.println("websocket connection closed......");
    }

    /**
     * 连接已关闭，移除在Map集合中的记录
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus cs) throws Exception {
    	
    	String username= (String) session.getAttributes().get("WEBSOCKET_USERNAME");
        System.out.println("用户"+username+"已退出！");
        users.remove(session);
        System.out.println("剩余在线用户"+users.size());
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }
    
    /**
     * 发送信息给指定用户
     * @param clientId
     * @param message
     * @return
     */
    public boolean sendMessageToUser(String clientId, TextMessage message) {
    	WebSocketSession session = users.get(clientId);
        if (session == null) {
        	return false;
        }
        System.out.println("sendMessage:" + session);
        if (!session.isOpen()) {
        	return false;
        }
        try {
            session.sendMessage(message);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
    
    /**
     * 给所有在线用户发送消息
     * @param message
     * @return
     */
    public boolean sendMessageToAllUsers(TextMessage message) {
    	//是否全部发送成功
        boolean allSendSuccess = true;
        Set<String> clientIds = users.keySet();
        WebSocketSession session = null;
        for (String clientId : clientIds) {
            try {
                session = users.get(clientId);
                if (session.isOpen()) {
                    session.sendMessage(message);
                }
            } catch (IOException e) {
                e.printStackTrace();
                allSendSuccess = false;
            }
        }
        return  allSendSuccess;
    }
    
}
