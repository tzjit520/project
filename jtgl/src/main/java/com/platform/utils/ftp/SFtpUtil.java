/*package com.dj.sys.utils.ftp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.Properties;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.Session;

*//**
 * SFTP文件上传、下载
 * 
 * 注意：使用该功能需要JDK1.7以上
 *//*
public class SFtpUtil
{
	// 创建JSch(Java Secure Channel)对象
	private static JSch jsch = new JSch();
	// 建立连接超时时间
	private static int timeout = 5000;
	
	*//**
	 * SFTP下载文件
	 * 
	 * @param ip
	 * @param port
	 * @param user
	 * @param password
	 * @param remoteDir
	 * @param fileName
	 * @param localDir
	 * @throws Exception
	 *//*
	public static void downloadFile(String ip, int port, String user, String password, String remoteDir, String fileName, String localDir) throws Exception
	{
		Session sshSession = null;
		ChannelSftp sftp = null;
		FileOutputStream fos = null;
		try
		{
			jsch.getSession(user, ip, port);
			sshSession = jsch.getSession(user, ip, port);
			sshSession.setPassword(password);
			Properties sshConfig = new Properties();
			sshConfig.put("StrictHostKeyChecking", "no");
			sshSession.setConfig(sshConfig);
			// 设置超时时间
			sshSession.setTimeout(timeout);
			// 建立SSH连接
			sshSession.connect();
			// 打开SFTP通道
			sftp = (ChannelSftp) sshSession.openChannel("sftp");
			// 建立连接
			sftp.connect();
			// 切换工作目录
			sftp.cd(remoteDir);
			// 检查指定的本地目录是否存在
			File dir = new File(localDir);
			if (!dir.exists())
			{
				dir.mkdir();
			}
			// 从FTP获取文件
			fos = new FileOutputStream(localDir + File.separator + fileName);
			// 下载文件
			sftp.get(fileName, fos);
		}
		catch (Exception e)
		{
			throw e;
		}
		finally
		{
			if (fos != null)
			{
				fos.close();
			}
			if (sftp != null)
			{
				sftp.disconnect();
			}
			if (sshSession != null)
			{
				sshSession.disconnect();
			}
		}
	}
	
	*//**
	 * SFTP上传文件
	 * 
	 * @param ip
	 * @param user
	 * @param password
	 * @param remoteDir
	 * @param localDir
	 * @param fileName
	 * @throws Exception
	 *//*
	public static void uploadFile(String ip, int port, String user, String password, String remoteDir, String localDir, String fileName) throws Exception
	{
		Session sshSession = null;
		ChannelSftp sftp = null;
		FileInputStream fis = null;
		try
		{
			// 本地文件
			fis = new FileInputStream(new File(localDir + File.separator + fileName));
			
			jsch.getSession(user, ip, port);
			sshSession = jsch.getSession(user, ip, port);
			sshSession.setPassword(password);
			Properties sshConfig = new Properties();
			sshConfig.put("StrictHostKeyChecking", "no");
			sshSession.setConfig(sshConfig);
			// 设置超时时间
			sshSession.setTimeout(timeout);
			// 建立SSH连接
			sshSession.connect();
			// 打开SFTP通道
			sftp = (ChannelSftp) sshSession.openChannel("sftp");
			// 建立连接
			sftp.connect();
			// 切换工作目录
			sftp.cd(remoteDir);
			// 上传文件
			sftp.put(fis, fileName);
		}
		catch (Exception e)
		{
			throw e;
		}
		finally
		{
			if (fis != null)
			{
				fis.close();
			}
			if (sftp != null)
			{
				sftp.disconnect();
			}
			if (sshSession != null)
			{
				sshSession.disconnect();
			}
		}
	}
}
*/