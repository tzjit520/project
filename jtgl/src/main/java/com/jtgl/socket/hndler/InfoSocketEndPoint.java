package com.jtgl.socket.hndler;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.alibaba.fastjson.JSONObject;
import com.platform.system.user.model.SysUser;

@Component
public class InfoSocketEndPoint extends TextWebSocketHandler {
	//在线用户列表
    private static final Map<Integer, WebSocketSession> users;
    //用户标识
    private static final String USER = "user";

    static {
        users = new HashMap<Integer, WebSocketSession>();
    }
    
    /**
     * 连接成功时候，会触发页面上onopen方法
     */
	@Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("连接成功....");
        //获取用户
        SysUser user = getUser(session);
        if(user != null){
        	users.put(user.getId(), session);
        	System.out.println(user.getName()+"上线啦！！！");
        	System.out.println("当前在线用户数量:"+ users.size());
        	//这块会实现自己业务，比如，当用户登录后，会把离线消息推送给用户
        	session.sendMessage(new TextMessage("成功建立socket连接"));
        }
    }

	/**
     * js调用websocket.send时候，会调用该方法
     */
    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message) {
    	JSONObject jsonObj = (JSONObject) JSONObject.parse(message.getPayload().toString());
    	//Integer userId = jsonObj.getInteger("userId");
    	Integer toUserId = jsonObj.getInteger("toUserId");
    	//String content = jsonObj.getString("content");
    	//SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	
    	sendMessageToUser(toUserId, message);
    }

    /**
     * 发送信息给指定用户
     * @param clientId
     * @param message
     * @return
     */
    public boolean sendMessageToUser(Integer userId, TextMessage message) {
    	WebSocketSession session = users.get(userId);
        if (session == null) {
        	return false;
        }
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
        Set<Integer> userIds = users.keySet();
        WebSocketSession session = null;
        for (Integer userId : userIds) {
            try {
                session = users.get(userId);
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

    /**
     * 连接出错处理，主要是关闭出错会话的连接，和删除在Map集合中的记录
     */
    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        if (session.isOpen()) {
            session.close();
        }
        SysUser user = getUser(session);
        if(user != null){
        	//移除用户
        	users.remove(user.getId());
        }
        System.out.println("连接出错");
    }

    /**
     * 连接已关闭，移除在Map集合中的记录
     */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus cs) throws Exception {
    	
    	SysUser user = getUser(session);
    	if(user != null){
    		//移除用户
        	users.remove(user.getId());
        	System.out.println("用户"+user.getName()+"已退出！");
        	System.out.println("剩余在线用户"+users.size());
        }
    }

    @Override
    public boolean supportsPartialMessages() {
        return false;
    }

    /**
     * 获取用户
     * @param session
     * @return
     */
    private SysUser getUser(WebSocketSession session) {
        try {
        	SysUser user = (SysUser) session.getAttributes().get(USER);
            return user;
        } catch (Exception e) {
            return null;
        }
    }
}
