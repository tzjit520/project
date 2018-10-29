/*package com.platform.utils.ftp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;

*//**
 * FTP文件上传、下载
 *//*
public class FtpUtil
{
	private static FTPClient ftpClient = new FTPClient();
	static
	{
		// 设置编码为“GBK”，默认为“iso-8859-1”
		ftpClient.setControlEncoding("GBK");
	}

	*//**
	 * FTP下载文件
	 * 
	 * @param ip
	 * @param user
	 * @param password
	 * @param remoteDir
	 * @param fileName
	 * @param localDir
	 * @throws Exception
	 *//*
	public static void downloadFile(String ip, String user, String password, String remoteDir, String fileName, String localDir) throws Exception
	{
		int reply;
		FileOutputStream fos = null;
		try
		{
			// 连接FTP服务器
			ftpClient.connect(ip, 21);
			// 登录FTP服务器
			ftpClient.login(user, password);
			// 判断登录是否成功
			reply = ftpClient.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply))
			{
				throw new Exception(ftpClient.getReplyString());
			}
			// 设置文件传输模式为二进制模式
			ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
			// 切换FTP工作目录
			ftpClient.changeWorkingDirectory(remoteDir);
			// 判断切换工作目录是否成功
			reply = ftpClient.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply))
			{
				throw new Exception(ftpClient.getReplyString());
			}
			// 列出当前工作目录下的所有文件
			boolean fileExist = false;
			FTPFile[] ftpFiles = ftpClient.listFiles();
			for (FTPFile ftpFile : ftpFiles)
			{
				if (ftpFile.getName().equals(fileName))
				{
					fileExist = true;
					// 检查指定的本地目录是否存在
					File dir = new File(localDir);
					if (!dir.exists())
					{
						dir.mkdir();
					}
					// 从FTP获取文件
					fos = new FileOutputStream(localDir + File.separator + fileName);
					ftpClient.retrieveFile(ftpFile.getName(), fos);
					break;
				}
			}
			if (!fileExist)
			{
				throw new Exception("未在FTP服务器上发现指定文件：" + fileName);
			}
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
			if (ftpClient.isConnected())
			{
				ftpClient.disconnect();
			}
		}
	}
	
	*//**
	 * FTP上传文件
	 * 
	 * @param ip
	 * @param user
	 * @param password
	 * @param remoteDir
	 * @param localDir
	 * @param fileName
	 *//*
	public static void uploadFile(String ip, String user, String password, String remoteDir, String localDir, String fileName) throws Exception
	{
		int reply;
		FileInputStream fis = null;
		try
		{
			// 本地文件
			fis = new FileInputStream(new File(localDir + File.separator + fileName));
			// 连接FTP服务器
			ftpClient.connect(ip, 21);
			// 登录FTP服务器
			ftpClient.login(user, password);
			// 判断登录是否成功
			reply = ftpClient.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply))
			{
				throw new Exception(ftpClient.getReplyString());
			}
			// 设置文件传输模式为二进制模式
			ftpClient.setFileType(FTPClient.BINARY_FILE_TYPE);
			// 切换FTP工作目录
			ftpClient.changeWorkingDirectory(remoteDir);
			// 判断切换工作目录是否成功
			reply = ftpClient.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply))
			{
				throw new Exception(ftpClient.getReplyString());
			}
			// 上传文件，注意需先转换编码
			ftpClient.storeFile(fileName, fis);
			// 判断是否上传成功
			reply = ftpClient.getReplyCode();
			if (!FTPReply.isPositiveCompletion(reply))
			{
				throw new Exception(ftpClient.getReplyString());
			}
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
			if (ftpClient.isConnected())
			{
				ftpClient.disconnect();
			}
		}
	}
}
*/