package com.platform.utils;

import java.io.*;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

/**
 * 对文件或文件夹进行压缩和解压
 *
 */
public class ZipUtil {
	/** 得到当前系统的分隔符 */
	// private static String separator = System.getProperty("file.separator");

	public static void main(String[] args) {
		File[] srcFiles = { new File("F:\\message.sql"), new File("F:\\SqlSessionFactoryBean.java"),
				new File("F:\\email.sql") };
		File zipFile = new File("E:\\ZipFile.zip");
		// 调用压缩方法
		zipFiles(srcFiles, zipFile);
	}

	public static void zipFiles(File[] srcFiles, File zipFile) {
		// 判断压缩后的文件存在不，不存在则创建
		if (!zipFile.exists()) {
			try {
				zipFile.createNewFile();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		// 创建 FileOutputStream 对象
		FileOutputStream fileOutputStream = null;
		// 创建 ZipOutputStream
		ZipOutputStream zipOutputStream = null;
		// 创建 FileInputStream 对象
		FileInputStream fileInputStream = null;

		try {
			// 实例化 FileOutputStream 对象
			fileOutputStream = new FileOutputStream(zipFile);
			// 实例化 ZipOutputStream 对象
			zipOutputStream = new ZipOutputStream(fileOutputStream);
			// 创建 ZipEntry 对象
			ZipEntry zipEntry = null;
			// 遍历源文件数组
			for (int i = 0; i < srcFiles.length; i++) {
				// 将源文件数组中的当前文件读入 FileInputStream 流中
				fileInputStream = new FileInputStream(srcFiles[i]);
				// 实例化 ZipEntry 对象，源文件数组中的当前文件
				zipEntry = new ZipEntry(srcFiles[i].getName());
				zipOutputStream.putNextEntry(zipEntry);
				// 该变量记录每次真正读的字节个数
				int len;
				// 定义每次读取的字节数组
				byte[] buffer = new byte[1024];
				while ((len = fileInputStream.read(buffer)) > 0) {
					zipOutputStream.write(buffer, 0, len);
				}
			}
			zipOutputStream.closeEntry();
			zipOutputStream.close();
			fileInputStream.close();
			fileOutputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 添加到压缩文件中
	 */
	public static void directoryZip(ZipOutputStream out, File f, String base)
			throws Exception {
		// 如果传入的是目录
		if (f.isDirectory()) {
			File[] fl = f.listFiles();
			// 创建压缩的子目录
			out.putNextEntry(new ZipEntry(base + "/"));
			if (base.length() == 0) {
				base = "";
			} else {
				base = base + "/";
			}
			for (int i = 0; i < fl.length; i++) {
				directoryZip(out, fl[i], base + fl[i].getName());
			}
		} else {
			// 把压缩文件加入rar中
			out.putNextEntry(new ZipEntry(base));
			FileInputStream in = new FileInputStream(f);
			byte[] bb = new byte[10240];
			int aa = 0;
			while ((aa = in.read(bb)) != -1) {
				out.write(bb, 0, aa);
			}
			in.close();
		}
	}

	/**
	 * 压缩文件
	 */
	public static void fileZip(ZipOutputStream zos, File file) throws Exception {
		if (file.isFile()) {
			zos.putNextEntry(new ZipEntry(file.getName()));
			FileInputStream fis = new FileInputStream(file);
			byte[] bb = new byte[10240];
			int aa = 0;
			while ((aa = fis.read(bb)) != -1) {
				zos.write(bb, 0, aa);
			}
			fis.close();
			System.out.println(file.getName());
		} else {
			directoryZip(zos, file, "");
		}
	}

	/**
	 * 解压缩文件
	 */
	public static void fileUnZip(ZipInputStream zis, File file)
			throws Exception {
		ZipEntry zip = zis.getNextEntry();
		if (zip == null)
			return;
		String name = zip.getName();
		File f = new File(file.getAbsolutePath() + "/" + name);
		if (zip.isDirectory()) {
			f.mkdirs();
			fileUnZip(zis, file);
		} else {
			f.createNewFile();
			FileOutputStream fos = new FileOutputStream(f);
			byte b[] = new byte[10240];
			int aa = 0;
			while ((aa = zis.read(b)) != -1) {
				fos.write(b, 0, aa);
			}
			fos.close();
			fileUnZip(zis, file);
		}
	}
	
	/**
	 * 根据filePath创建相应的目录
	 */
	public static File mkdirFiles(String filePath) throws IOException {
		File file = new File(filePath);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
		file.createNewFile();

		return file;
	}

	public static File mkDir(String filePath) throws IOException {
		File file = new File(filePath);
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}
		file.mkdirs();

		return file;
	}

	/**
	 * 对zipBeforeFile目录下的文件压缩，保存为指定的文件zipAfterFile
	 * 
	 * @param zipBeforeFile
	 *            压缩之前的文件
	 * @param zipAfterFile
	 *            压缩之后的文件
	 */
	public static void zip(String zipBeforeFile, String zipAfterFile) {
		try {

			ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(
					mkdirFiles(zipAfterFile)));
			fileZip(zos, new File(zipBeforeFile));
			zos.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 复制文件
	public static void copyFile(File sourceFile, File targetFile)
			throws IOException {
		// 新建文件输入流并对它进行缓冲
		FileInputStream input = new FileInputStream(sourceFile);
		BufferedInputStream inBuff = new BufferedInputStream(input);

		// 新建文件输出流并对它进行缓冲
		FileOutputStream output = new FileOutputStream(targetFile);
		BufferedOutputStream outBuff = new BufferedOutputStream(output);

		// 缓冲数组
		byte[] b = new byte[1024 * 5];
		int len;
		while ((len = inBuff.read(b)) != -1) {
			outBuff.write(b, 0, len);
		}
		// 刷新此缓冲的输出流
		outBuff.flush();

		// 关闭流
		inBuff.close();
		outBuff.close();
		output.close();
		input.close();
	}

	/**
	 * 删除文件夹及文件
	 */
	public static boolean delAllFile(String path) {
		boolean flag = false;
		File file = new File(path);
		if (!file.exists()) {
			return flag;
		}
		if (!file.isDirectory()) {
			return flag;
		}
		String[] tempList = file.list();
		File temp = null;
		for (int i = 0; i < tempList.length; i++) {
			if (path.endsWith(File.separator)) {
				temp = new File(path + tempList[i]);
			} else {
				temp = new File(path + File.separator + tempList[i]);
			}
			if (temp.isFile()) {
				temp.delete();
			}
			if (temp.isDirectory()) {
				delAllFile(path + "/" + tempList[i]);// 先删除文件夹里面的文件
				delFolder(path + "/" + tempList[i]);// 再删除空文件夹
				flag = true;
			}
		}
		return flag;
	}

	// 删除文件夹
	// param folderPath 文件夹完整绝对路径
	public static void delFolder(String folderPath) {
		try {
			delAllFile(folderPath); // 删除完里面所有内容
			String filePath = folderPath;
			filePath = filePath.toString();
			File myFilePath = new File(filePath);
			myFilePath.delete(); // 删除空文件夹
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public static void copyDirectiory(String sourceDir,String targetDir) throws IOException{
        
        //新建目标目录
        
        (new File(targetDir)).mkdirs();
        
        //获取源文件夹当下的文件或目录
        File[] file=(new File(sourceDir)).listFiles();
        
        for (int i = 0; i < file.length; i++) {
            if(file[i].isFile()){
                //源文件
                File sourceFile=file[i];
                    //目标文件
                File targetFile=new File(new File(targetDir).getAbsolutePath()+File.separator+file[i].getName());
                copyFile(sourceFile, targetFile);
            }
            
            if(file[i].isDirectory()){
                //准备复制的源文件夹
            	String dir1 = "";
            	if(sourceDir.endsWith("/")) {
            		dir1=sourceDir+file[i].getName();
            	}
            	else {
            		dir1=sourceDir+"/"+file[i].getName();
            	}
            	String dir2 = "";
                //准备复制的目标文件夹
            	if(targetDir.endsWith("/")) {
            		dir2=targetDir+file[i].getName();
            	}
            	else {
            		dir2=targetDir+"/"+file[i].getName();
            	}
                copyDirectiory(dir1, dir2);
            }
        }
        
    }

	/**
	 * 解压缩文件unZipBeforeFile保存在unZipAfterFile目录下
	 * 
	 * @param unZipBeforeFile
	 *            解压之前的文件
	 * @param unZipAfterFile
	 *            解压之后的文件
	 */
	public static void unZip(String unZipBeforeFile, String unZipAfterFile) {
		try {
			ZipInputStream zis = new ZipInputStream(new FileInputStream(
					unZipBeforeFile));
			File f = new File(unZipAfterFile);
			f.mkdirs();
			fileUnZip(zis, f);
			zis.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
