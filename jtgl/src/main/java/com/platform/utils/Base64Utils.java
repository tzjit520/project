package com.platform.utils;

import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.UUID;

/**
 * Base64编码和解码   JDK8
 */
public class Base64Utils {
	public static void main(String args[]) {
		try {
			System.out.println("============Encoder编码和 Decoder解码========================");
			String str = "123456";
			System.out.println("原字符串：" + str);
			// 编码 Encoder
			String base64encodedString = Base64.getEncoder().encodeToString(str.getBytes("utf-8"));
			System.out.println("Encoder编码之后字符串：" + base64encodedString);
			// 解码 Decoder
			byte[] base64decodedBytes = Base64.getDecoder().decode(base64encodedString);
			System.out.println("Decoder解码之后字符串：" + new String(base64decodedBytes, "utf-8"));
			
			System.out.println();
			System.out.println("============UrlEncoder编码和UrlDecoder解码========================");
			System.out.println("原字符串Str："+ str);
			// UrlEncoder编码
			String base64UrlEncodedString = Base64.getUrlEncoder().encodeToString(str.getBytes("utf-8"));
			System.out.println("UrlEncoder编码之后字符串Str："+ base64UrlEncodedString);

			// UrlDecoded解码 
			byte[] base64UrlDecodedBytes = Base64.getUrlDecoder().decode(base64UrlEncodedString);
			System.out.println("UrlDecoder解码之后字符串Str：" + new String(base64UrlDecodedBytes, "utf-8"));

			System.out.println();
			System.out.println("============MimeEncoder编码和MimeDecoder解码========================");
			
			String uuid = UUID.randomUUID().toString();
			System.out.println("原UUID："+ uuid);
			// MimeEncoder编码
			String mimeEncodedString = Base64.getMimeEncoder().encodeToString(uuid.toString().getBytes("utf-8"));
			System.out.println("MimeEncoder编码之后UUID："+ mimeEncodedString);
			// MimeDecoder解码
			byte[] mimeDecodeString = Base64.getMimeDecoder().decode(mimeEncodedString);
			System.out.println("MimeDecoder解码之后UUID："+ new String(mimeDecodeString, "utf-8"));
			
		} catch (UnsupportedEncodingException e) {
			System.out.println("Error :" + e.getMessage());
		}
	}
}
