package com.platform.utils.qrcode;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

import net.glxn.qrgen.core.image.ImageType;
import net.glxn.qrgen.core.vcard.VCard;
import net.glxn.qrgen.javase.QRCode;

/**
 * 生成二维码以及二维码名片
 */
public class QrGenCode {
	
	public static void main(String[] args) {
        try {
        	String contents = "https://www.baidu.com";
        	// 生成二维码    以字节数组流返回
        	ByteArrayOutputStream bout = getByteArrayenCode(contents);
        	OutputStream out = new FileOutputStream(new File("E://upload/vcode/byte_qr_code.png"));
        	bout.writeTo(out);
        	out.flush();
        	out.close();
        	
        	BitMatrix bitMatrix = getBitMatrixCode(contents);
        	File outputFile = new File("E://upload/vcode/bit_qr_code.png");
			MatrixToImageWriter.writeToFile(bitMatrix, "jpg", outputFile);
			
        	// 生成二维码    以File返回
        	File file = getFileCode(contents);
            InputStream is = new FileInputStream(file);
			//先定义一个字节数组存放数据
			byte[] b = new byte[1024];//把所有的数据读取到这个字节当中
			//声明一个int存储每次读取到的数据
			int i = 0;
			//定义一个记录索引的变量
			int index = 0;
			//循环读取每个数据
			while((i = is.read()) != -1){//把读取的数据放到i中
				b[index]=(byte) i;
				index++;
			}
			OutputStream out1 = new FileOutputStream(new File("E://upload/vcode/file_qr_code.png"));
			out1.write(b);
            out1.flush();
            out1.close();
            is.close();

            //生成二维码名片
            VCard vCard = new VCard();
            vCard.setName("谭志杰");
            vCard.setTitle("private7685");
            vCard.setAddress("上海市浦东新区浦东南路");
            vCard.setCompany("上海聚数信息科技有限公司");
            vCard.setPhoneNumber("16602130404");
            vCard.setEmail("tzjit520@163.com");
            vCard.setWebsite("www.baidu.com");
            ByteArrayOutputStream bout1 = createQrCodeVCard(vCard);
            OutputStream out2 = new FileOutputStream(new File("E://upload/vcode/v_code.png"));
            bout1.writeTo(out2);
        	out2.flush();
        	out2.close();
        } catch (FileNotFoundException e){
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (WriterException e) {
        	e.printStackTrace();
        }
	}
	
	/**
	 * 生成名片
	 */
	private static ByteArrayOutputStream createQrCodeVCard(VCard vCard) {
        ByteArrayOutputStream bout = QRCode.from(vCard)
            .withCharset("utf-8")
            .withSize(200, 200)
            .to(ImageType.PNG)
            .stream();
        return bout;
	}
	
	/**
	 * 生成二维码    以字节数组流返回
	 * @param contents 二维码内容
	 */
	private static ByteArrayOutputStream getByteArrayenCode(String contents) {
		// 以字节数组流返回
		ByteArrayOutputStream bout = net.glxn.qrgen.javase.QRCode.from(contents)
            .withSize(150, 150)
            .to(ImageType.PNG)
            .withErrorCorrection(ErrorCorrectionLevel.M) //分为四个等级：L/M/Q/H, 等级越高，容错率越高，识别速度降低。例如一个角被损坏，容错率高的也许能够识别出来。通常为H
            .withCharset("utf-8")
            .stream();
	    return bout;
	}
	
	/**
	 * 生成二维码    以File返回
	 * @param contents 二维码内容
	 */
	private static File getFileCode(String contents) {
		// 以File返回
		File file = QRCode.from(contents)
			.withSize(150, 150)
			.to(ImageType.PNG)
			.file();
	    return file;
	}
	
	/**
	 * 生成二维码    添加额外参数
	 * @param contents 二维码内容
	 * @return 二维码的描述对象 BitMatrix
	 * @throws WriterException 编码时出错
	 */
	private static BitMatrix getBitMatrixCode(String contents) throws WriterException {
		//额外参数
		HashMap<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
		//四种容错级别可以选择：L（Low）：7%的字码可被修正 、M（Medium）：15%的字码可被修正 、 Q（Quartile）：25%的字码可被修正 、 H（High）：30%的字码可被修正
		hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.M);
		hints.put(EncodeHintType.CHARACTER_SET, "utf-8");//
		hints.put(EncodeHintType.MARGIN, 4);//每个版本增加的行列数
		hints.put(EncodeHintType.QR_VERSION, 4);//版本1-9(S) 10-26(M) 26-40(L)
	    return new QRCodeWriter().encode(contents, BarcodeFormat.QR_CODE, 150, 150, hints);
	}
}
