package com.platform.utils;

import java.io.IOException;
import java.security.MessageDigest;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.shiro.crypto.hash.SimpleHash;


/**
 * 加密/转码 工具类
 */
public class EncoderUtil {

	public final static String ENCODE_MD5_32 = "MD5";
	public final static String ENCODE_MD5_16 = "md5";
	public final static String ENCODE_SHA1 = "SHA1";
	public final static String ENCODE_DESEDE = "DESede";

	/**
	 * 进行多种类型的加密
	 * 
	 * @param content
	 * @param type
	 * @return
	 */
	public static String encode(String content, String type) {
		if (type == null || "".equals(type)) {
			return type;
		}
		switch (type) {
		case ENCODE_MD5_32:
			return encodeByMd5(content, "UTF-8", 32);
		case ENCODE_MD5_16:
			return encodeByMd5(content, "UTF-8", 16);
		case ENCODE_SHA1:
			return encodeBySHA1(content);
		case ENCODE_DESEDE:
			return encrypt(content);
		}
		return "";
	}

	/**
	 * 返回md5加密字段
	 * 
	 * @param plainText
	 *            加密字段
	 * @param code
	 *            加密编码, 默认UTF-8
	 * @param length
	 *            返回的长度 16/32
	 * @return
	 */
	public static String encodeByMd5(String plainText, String code, int length) {
		if (length == 16)
			return encodeByMd5(plainText, code).substring(8, 24);
		else if (length == 32)
			return encodeByMd5(plainText, code);
		else
			return "";
	}

	/**
	 * MD5加密 32位
	 * 
	 * @param str
	 * @param code
	 *            编码格式 默认UTF-8
	 * @return
	 */
	public static String encodeByMd5(String str, String code) {
		if (code == null || "".equals(code)) {
			code = "UTF-8";
		}
		MessageDigest messageDigest = null;
		try {
			messageDigest = MessageDigest.getInstance("MD5");
			messageDigest.reset();
			messageDigest.update(str.getBytes(code));
		} catch (Exception e) {
			e.printStackTrace();
		}

		byte[] byteArray = messageDigest.digest();
		StringBuffer md5StrBuff = new StringBuffer();
		for (int i = 0; i < byteArray.length; i++) {
			if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)
				md5StrBuff.append("0").append(
						Integer.toHexString(0xFF & byteArray[i]));
			else
				md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
		}
		return md5StrBuff.toString().toUpperCase();
	}

	/**
	 * SHA1加密
	 * 
	 * @param decript
	 * @return
	 */
	public static String encodeBySHA1(String decript) {
		try {
			MessageDigest digest = java.security.MessageDigest
					.getInstance("SHA-1");
			digest.update(decript.getBytes());
			byte messageDigest[] = digest.digest();
			// Create Hex String
			StringBuffer hexString = new StringBuffer();
			// 字节数组转换为 十六进制 数
			for (int i = 0; i < messageDigest.length; i++) {
				String shaHex = Integer.toHexString(messageDigest[i] & 0xFF);
				if (shaHex.length() < 2) {
					hexString.append(0);
				}
				hexString.append(shaHex);
			}
			return hexString.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	/**
	 * 对参数升序排列,生成 ke1=value1&key2=value2 形式的字符串
	 * 
	 * @param <T>
	 * @param serviceParams
	 * @return
	 */
	public static <T> String dataDecrypt(Map<String, T> serviceParams) {
		StringBuilder sb = new StringBuilder();
		Object[] keys = serviceParams.keySet().toArray();
		Arrays.sort(keys);
		for (Object key : keys) {
			sb.append(key).append("=").append(serviceParams.get(key))
					.append("&");
		}
		sb.delete(sb.length() - 1, sb.length());
		return sb.toString();
	}

	/**
	 * 对参数升序排列,生成 ke1value1key2value2 形式的字符串
	 * 
	 * @param <T>
	 * @param serviceParams
	 * @return
	 */
	public static <T> String dataDecrypt1(Map<String, T> serviceParams) {
		StringBuilder sb = new StringBuilder();
		Object[] keys = serviceParams.keySet().toArray();
		Arrays.sort(keys);
		for (Object key : keys) {
			sb.append(key).append(serviceParams.get(key));
		}
		return sb.toString();
	}

	// 可逆的加密算法
	public static String KL(String inStr) {
		// String s = new String(inStr);
		char[] a = inStr.toCharArray();
		for (int i = 0; i < a.length; i++) {
			a[i] = (char) (a[i] ^ 't');
		}
		String s = new String(a);
		return s;
	}

	// 加密后解密
	public static String JM(String inStr) {
		char[] a = inStr.toCharArray();
		for (int i = 0; i < a.length; i++) {
			a[i] = (char) (a[i] ^ 't');
		}
		String k = new String(a);
		return k;
	}

	// ===============================3DES加密解密======================================================================
	// 24字节的密钥
	private static final byte[] keyBytes = { 0x55, 0x22, 0x4F, 0x58,
			(byte) 0x88, 0x16, 0x42, 0x38, 0x28, 0x45, 0x79, 0x51, (byte) 0xFB,
			(byte) 0xED, 0x55, 0x56, 0x77, 0x29, 0x74, (byte) 0x98, 0x55, 0x40,
			0x36, (byte) 0xF2 };

	/**
	 * 加密方法
	 * 
	 * @param src
	 *            被加密的字符串
	 * @return
	 */
	public static String encrypt(String src) {
		try {
			// 生成密钥
			SecretKey deskey = new SecretKeySpec(keyBytes, ENCODE_DESEDE);

			// 加密
			Cipher c1 = Cipher.getInstance(ENCODE_DESEDE);
			c1.init(Cipher.ENCRYPT_MODE, deskey);
			return bytes2HexString(c1.doFinal(src.getBytes("UTF-8")));
		} catch (java.security.NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		} catch (javax.crypto.NoSuchPaddingException e2) {
			e2.printStackTrace();
		} catch (java.lang.Exception e3) {
			e3.printStackTrace();
		}
		return null;
	}

	/**
	 * 解密
	 * 
	 * @param decryptStr
	 *            待解密的字符串
	 * @return 解密后的明文
	 */
	public static String decrypt(String decryptStr) {
		try {
			byte[] decryptBytes = hexStringToBytes(decryptStr);
			// 生成密钥
			SecretKey deskey = new SecretKeySpec(keyBytes, ENCODE_DESEDE);

			// 解密
			Cipher c1 = Cipher.getInstance(ENCODE_DESEDE);
			c1.init(Cipher.DECRYPT_MODE, deskey);
			return new String(c1.doFinal(decryptBytes), "UTF-8");
		} catch (java.security.NoSuchAlgorithmException e1) {
			e1.printStackTrace();
		} catch (javax.crypto.NoSuchPaddingException e2) {
			e2.printStackTrace();
		} catch (java.lang.Exception e3) {
			e3.printStackTrace();
		}
		return null;
	}

	/**
	 * 转换成十六进制字符串
	 *
	 * @param b
	 * @return
	 * @author SHANHY
	 * @date 2015-8-18
	 */
	private static String bytes2HexString(byte[] b) {
		String hs = "";
		String stmp = "";

		for (int n = 0; n < b.length; n++) {
			stmp = (java.lang.Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1)
				hs = hs + "0" + stmp;
			else
				hs = hs + stmp;
			if (n < b.length - 1)
				hs = hs + "";
		}
		return hs.toUpperCase();
	}

	@SuppressWarnings("static-access")
	private static byte[] hexStringToBytes(String hexString) {
		if (hexString == null || hexString.equals("")) {
			return null;
		}

		String hexTemp = new String();

		int length = hexString.length() / 2;
		char[] hexChars = hexString.toCharArray();
		byte[] bytes = new byte[length];
		String hexDigits = "0123456789ABCDEF";
		for (int i = 0; i < length; i++) {
			int pos = i * 2; // 两个字符对应一个byte
			int h = hexDigits.indexOf(hexTemp.valueOf(hexChars[pos])
					.toUpperCase().charAt(0)) << 4; // 注1
			int l = hexDigits.indexOf(hexTemp.valueOf(hexChars[pos + 1])
					.toUpperCase().charAt(0)); // 注2
			if (h == -1 || l == -1) { // 非16进制字符
				return null;
			}
			bytes[i] = (byte) (h | l);
		}
		return bytes;
	}

	/**
	 * 获取加密字符
	 * @param algorithmName 加密类型   MD5/SHA-1
	 * @param source 需要加密的内容
	 * @param salt 盐值
	 * @param iterations 散列次数(循环加密多少次)
	 */
	public static String getEncodeCharter(String algorithmName, Object source, Object salt, int iterations) {
		String encodeCharterstr = new SimpleHash(algorithmName, source, salt, iterations).toString();
		return encodeCharterstr;
	}
	
	// 测试主函数
	public static void main(String args[]) throws IOException {
		String str = new String("111111");
		System.out.println("原始：" + str);
		
		String encodeCharterMD5 = getEncodeCharter("MD5", str, "admin", 2);
		System.out.println(encodeCharterMD5);
		String encodeCharterSHA = getEncodeCharter("SHA-1", str, "admin", 2);
		System.out.println(encodeCharterSHA);
		
		System.out.println("32位MD5后再加密：" + KL(encode(str, ENCODE_MD5_32)));
		System.out.println("解密为32位MD5后的：" + JM(KL(encode(str, ENCODE_MD5_32))));
		System.out.println("=========================");

		System.out.println("32位MD5加密后：" + encode(str, ENCODE_MD5_32));
		System.out.println("16位MD5加密后：" + encode(str, ENCODE_MD5_16));
		System.out.println("SHA1加密后：" + encode(str, ENCODE_SHA1));

		System.out.println("=========================");
		System.out.println("3DES加密前的字符串:" + str);
		String desStr = encode(str, ENCODE_DESEDE);
		System.out.println("3DES加密后的字符串:" + desStr);
		System.out.println("3DES解密后的字符串:" + decrypt(desStr));

		System.out.println("=========================");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("y", 6);
		map.put("c", 4);
		map.put("a", 8);
		map.put("j", 1);
		System.out.println("对参数升序排列,生成 ke1value1key2value2 形式的字符串："
				+ dataDecrypt1(map));
		System.out.println("对参数升序排列,生成 ke1=value1&key2=value2 形式的字符串:"
				+ dataDecrypt(map));

	}

}
