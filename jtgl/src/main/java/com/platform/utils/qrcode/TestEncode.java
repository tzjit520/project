package com.platform.utils.qrcode;

import java.io.File;
import java.io.IOException;
import java.util.Hashtable;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;

/***
 * 生成二维码
 */
public class TestEncode {

	@SuppressWarnings({ "unchecked", "rawtypes" })
	public static void main(String[] args) throws WriterException, IOException {
		try {
			//生成方式1
			String content = "你好";
			int width = 600;
			int height = 600;
			String format = "png";
			Hashtable hints= new Hashtable();
			hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
			BitMatrix bitMatrix = new MultiFormatWriter().encode(content, BarcodeFormat.QR_CODE, width, height,hints);
			File outputFile = new File("E://new.png");
			MatrixToImageWriter.writeToFile(bitMatrix, format, outputFile);
			
			//生成方式2
			//生成带logo 的二维码
			content = "这是二维码内容";
			QRCodeUtil.encode(content, "E:/ddd.jpg", "E:/qr", true);
			//生成不带logo 的二维码
			QRCodeUtil.encode(content,"","d:/",true);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

       
	}

}
