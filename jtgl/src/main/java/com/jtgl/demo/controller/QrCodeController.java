package com.jtgl.demo.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.utils.qrcode.QRCodeUtil;

/**
 * 二维码
 */
@Controller
@RequestMapping("/api/v1/qrCode")
public class QrCodeController extends BaseController {
	
	@Value("${uploadPath}")
    private String uploadPath;
	
	//生成二维码
	@RequestMapping(method = RequestMethod.POST)
	public @ResponseBody Result<String> generateQrCode(String conText, String imgPath, Model model, HttpServletRequest request) throws Exception {
		String name = "";
		String qrPath = uploadPath + "qrCode";
		if(StringUtils.isNotEmpty(imgPath)){
			//生成带logo 的二维码
			name = QRCodeUtil.encode(conText, uploadPath+imgPath, qrPath, true);
		}else{
			//生成不带logo 的二维码
			name = QRCodeUtil.encode(conText, "", qrPath, true);
		}
		String qrCodeUrlString = "/qrCode/"+ name;
		return new ResultBuilder<String>().data(qrCodeUrlString).build();
	}
}
