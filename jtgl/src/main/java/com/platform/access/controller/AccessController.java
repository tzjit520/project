package com.platform.access.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.code.kaptcha.Constants;
import com.platform.system.user.model.SysUser;

@Controller  
@RequestMapping("/api/v1/access") 
public class AccessController {

	@RequestMapping(value="login", method = RequestMethod.GET)
	public String loginInfo(Model model) {
		return "platform/access/login";
	}
	
	@RequestMapping(value="login", method = RequestMethod.POST)
	public String login(SysUser user, Model model, HttpServletRequest request){ 
	    String info = loginUser(user, request);  
	    if (!"SUCC".equals(info)) {  
	        model.addAttribute("failMsg", info);  
	        return "platform/access/login";  
	    }else{  
	        return "index";//返回的页面  
	    } 
	}  

	@RequestMapping("/logout")  
	public String logout() throws IOException{  
	    Subject subject = SecurityUtils.getSubject();  
	    if (subject != null) {  
	        try{  
	            subject.logout();  
	        }catch(Exception ex){  
	        }  
	    } 
	    return "platform/access/login";
	}  

	private String loginUser(SysUser user, HttpServletRequest request) {  
        if (isRelogin(user)) 
    		return "SUCC"; // 如果已经登陆，无需重新登录  
        
        return shiroLogin(user, request); // 调用shiro的登陆验证  
	}
	
	private String shiroLogin(SysUser user, HttpServletRequest request) {  
		Session session = SecurityUtils.getSubject().getSession();
		//校验验证码
		String validateCode = (String) session.getAttribute(Constants.KAPTCHA_SESSION_KEY);  
		//校验验证码
        String inputCode = request.getParameter("validateCode");  
		if(validateCode == null || inputCode == null){
			return "";
		}
        if (!validateCode.equalsIgnoreCase(inputCode)){
        	return "验证码不正确";
		}
        // 组装token，包括客户公司名称、简称、客户编号、用户名称；密码  
	    UsernamePasswordToken token = new UsernamePasswordToken(user.getCode(), user.getPassword().toCharArray(), null);   
	    //是否记住我
	    String ckRemember = request.getParameter("remember");  
	    if(ckRemember == null){
	    	token.setRememberMe(false);  
	    }else{
	    	token.setRememberMe(true);  
	    }
	      
	    try {  
	    	// shiro登陆验证  
	        SecurityUtils.getSubject().login(token);  
//	        System.out.println("SESSION ID = " + SecurityUtils.getSubject().getSession().getId()); 
//	        System.out.println("用户名：" + SecurityUtils.getSubject().getPrincipal()); 
//	        System.out.println("HOST：" + SecurityUtils.getSubject().getSession().getHost()); 
//	        System.out.println("TIMEOUT ：" + SecurityUtils.getSubject().getSession().getTimeout()); 
//	        System.out.println("START：" + SecurityUtils.getSubject().getSession().getStartTimestamp()); 
//	        System.out.println("LAST：" + SecurityUtils.getSubject().getSession().getLastAccessTime());
	    } catch (UnknownAccountException ex) {  
	        return "用户不存在或者密码错误！";  
	    } catch (IncorrectCredentialsException ex) {  
	        return "用户不存在或者密码错误！";  
	    } catch (AuthenticationException ex) {  
	        return ex.getMessage(); // 自定义报错信息  
	    } catch (Exception ex) {  
	        ex.printStackTrace();  
	        return "内部错误，请重试！";  
	    }  
	    return "SUCC";  
	}  
	  
	private boolean isRelogin(SysUser user) {  
	    Subject subject = SecurityUtils.getSubject();  
        if (subject.isAuthenticated()) {  
           return true; // 参数未改变，无需重新登录，默认为已经登录成功  
        }  
        return false; // 需要重新登陆  
	} 
	
}
