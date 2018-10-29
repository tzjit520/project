package com.platform.utils.email;

import java.io.IOException;
import java.util.Properties;

import javax.mail.internet.InternetAddress;

/**
 * 邮箱Utils
 */
public class MailUtils {
	
	static Properties properties = null;   //可以帮助读取和处理资源文件中的信息
	
	static {   //加载JDBCUtil类的时候调用
		properties = new Properties();
		try {
			properties.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("system-config.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public static boolean sendEmail(String mailTo, String subject, String content){
		InternetAddress mailfrom;
		InternetAddress mailto;
		try {
			mailfrom = new InternetAddress(properties.getProperty("mailfrom"), "谭志杰");
			mailto = new InternetAddress(mailTo);
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
		boolean htmlContent = true;
		String username = properties.getProperty("username");
		String password = properties.getProperty("password");
		String protocol = properties.getProperty("protocol"); // default: smtp
		String smtpHost = properties.getProperty("smtpHost");
		int smtpPort = new Integer(properties.getProperty("smtpPort")).intValue(); // default: 25
		long timeoutInMills = new Long(properties.getProperty("timeoutInMills")).longValue(); // default: 5000L
		ConnectionParams connectionParams = new ConnectionParams();
		connectionParams.setConnectTimeout(timeoutInMills)
		        .setSocketTimeout(timeoutInMills).setDebug(true)
		        .setProtocol(protocol)
		        .setHost(smtpHost)
		        .setPort(smtpPort)
		        .setNeedAuth(true)
		        .setEnvelopeFrom(username)
		        .setPassword(password);
		// if connection need keep alive after sent, you can set:
		// connectionParams.setKeepAlive(true);

		// if you need a connection pool, there present a class: ConnectionFactory,
		// which implements org.apache.commons.pool.PoolableObjectFactory

		SendJob job = new SendJob(new Connection(connectionParams));
		job.setSubject(subject).setMailFrom(mailfrom).addMailTo(mailto)
		        .setMailContent(content).setHtmlContent(htmlContent);

		boolean success = job.send();
		return success;
	}
	
	/***
	 * 邮箱测试
	 */
	public static void main(String[] args) throws Exception {
		String subject = "家庭信息";
		String content = "<p>打算的撒</p><p>的萨达十大</p>";
		String mailTo = "530839007@qq.com";
		boolean bool = MailUtils.sendEmail(mailTo, subject, content);
		System.out.println(bool);
	}

}
