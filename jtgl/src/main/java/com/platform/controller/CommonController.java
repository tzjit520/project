package com.platform.controller;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.Producer;
import com.platform.utils.LoggerUtils;
import com.platform.utils.VerifyCodeUtils;
import com.platform.utils.vcode.Captcha;
import com.platform.utils.vcode.GifCaptcha;
import com.platform.utils.vcode.SpecCaptcha;

@Controller
@RequestMapping("/")
public class CommonController extends BaseController{

	@RequestMapping(method = RequestMethod.GET)
	public String loginInfo(Model model) {
		return "home";
	}
	
	@Autowired
	private Producer kaptchaProducerl;
	
	/**
	 * Captcha生成验证码
	 */
	@RequestMapping(value="getValidateCode", method=RequestMethod.GET)
	public void getValidateCode(HttpServletResponse response, HttpServletRequest request) throws IOException{
		//shiro session
		Session session = SecurityUtils.getSubject().getSession(); 
        response.setDateHeader("Expires", 0);  
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");  
        response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
        response.setHeader("Pragma", "no-cache");  
        response.setContentType("image/jpeg");  
        String capText = kaptchaProducerl.createText();  
        session.setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);  
        System.out.println("******************验证码是: " + capText + "******************");  
        BufferedImage bi = kaptchaProducerl.createImage(capText);  
        ServletOutputStream out = response.getOutputStream();  
        ImageIO.write(bi, "jpg", out);  
        try {  
            out.flush();  
        } finally {  
            out.close();  
        }  
	}
	
	/**
	 * 自定义验证码
	 */
	@RequestMapping(value="getCode", method=RequestMethod.GET)
	public void getCode(HttpServletResponse response, HttpServletRequest request) throws IOException{
		int width = 60;  
        int height = 32;  
        //create the image  
        BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);  
        Graphics g = image.getGraphics();  
        // set the background color  
        g.setColor(new Color(0xDCDCDC));  
        g.fillRect(0, 0, width, height);  
        // draw the border  
        g.setColor(Color.black);  
        g.drawRect(0, 0, width - 1, height - 1);  
        // create a random instance to generate the codes  
        Random rdm = new Random();  
        String hash1 = Integer.toHexString(rdm.nextInt());  
        System.out.print(hash1);  
        // make some confusion  
        for (int i = 0; i < 50; i++) {  
            int x = rdm.nextInt(width);  
            int y = rdm.nextInt(height);  
            g.drawOval(x, y, 0, 0);  
        }  
        // generate a random code  
        String capstr = hash1.substring(0, 4);  
        HttpSession session = request.getSession(true);  
        //将生成的验证码存入session  
        session.setAttribute("validateCode", capstr);  
        g.setColor(new Color(0, 100, 0));  
        g.setFont(new Font("Candara", Font.BOLD, 24));  
        g.drawString(capstr, 8, 24);  
        g.dispose();  
        //输出图片  
        response.setContentType("image/jpeg");  
        OutputStream strm = response.getOutputStream();  
        ImageIO.write(image, "jpeg", strm);  
        strm.close();   
	}
	
	/**
	 * 获取验证码（Gif版本）
	 * @param response
	 */
	@RequestMapping(value="getGifCode", method=RequestMethod.GET)
	public void getGifCode(HttpServletResponse response, HttpServletRequest request){
		try {
			response.setHeader("Pragma", "No-cache");  
	        response.setHeader("Cache-Control", "no-cache");  
	        response.setDateHeader("Expires", 0);  
	        response.setContentType("image/gif");  
	        /**
	         * gif格式动画验证码
	         * 宽，高，位数。
	         */
	        Captcha captcha = new GifCaptcha(146,42,4);
	        //存入Shiro会话session  
	        HttpSession session = request.getSession(true);  
	        //输出
	        ServletOutputStream out = response.getOutputStream();
	        captcha.out(response.getOutputStream());
	        //存入Session
	        session.setAttribute("_code", captcha.text().toLowerCase());  
	        System.out.println("gif验证码："+captcha.text().toLowerCase());
	        out.flush();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("获取验证码异常：%s"+e.getMessage());
		}
	}
	
	/**
	 * 获取验证码（jpg版本）
	 * @param response
	 */
	@RequestMapping(value="getJPGCode", method=RequestMethod.GET)
	public void getJPGCode(HttpServletResponse response, HttpServletRequest request){
		try {
			response.setHeader("Pragma", "No-cache");  
			response.setHeader("Cache-Control", "no-cache");  
			response.setDateHeader("Expires", 0);  
			response.setContentType("image/jpg");  
			/**
			 * jgp格式验证码
			 * 宽，高，位数。
			 */
			Captcha captcha = new SpecCaptcha(146,33,4);
			//存入Shiro会话session  
			HttpSession session = request.getSession(true);  
			//输出
			ServletOutputStream out = response.getOutputStream();
			captcha.out(response.getOutputStream());
			//存入Session
			session.setAttribute("_code", captcha.text().toLowerCase());  
			System.out.println("验证码："+captcha.text().toLowerCase());
	        out.flush();
		} catch (Exception e) {
			logger.error("获取验证码异常：%s"+e.getMessage());
		}
	}
	
	/**
	 * 获取验证码
	 * @param response
	 */
	@RequestMapping(value="getVCode", method=RequestMethod.GET)
	public void getVCode(HttpServletResponse response, HttpServletRequest request){
		try {
			response.setHeader("Pragma", "No-cache");  
	        response.setHeader("Cache-Control", "no-cache");  
	        response.setDateHeader("Expires", 0);  
	        response.setContentType("image/jpg");  
	        
	        //生成随机字串  
	        String verifyCode = VerifyCodeUtils.generateVerifyCode(4);  
	        System.out.println("验证码："+verifyCode);
	        //存入Shiro会话session  
	        HttpSession session = request.getSession(true);  
			session.setAttribute("_code", verifyCode);  
	        //TokenManager.setVal2Session(VerifyCodeUtils.V_CODE, verifyCode.toLowerCase());  
	        //生成图片  
	        int w = 146, h = 40;  
	        VerifyCodeUtils.outputImage(w, h, response.getOutputStream(), verifyCode); 
		} catch (Exception e) {
			LoggerUtils.fmtError(getClass(),e, "获取验证码异常：%s",e.getMessage());
		}
	}
	
}
