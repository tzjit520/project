package com.platform.utils.sms;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import com.platform.utils.EncoderUtil;
import com.platform.utils.HttpRequest;

@Component("smsAccessService")
public class SmsAccessService {
	
	private final static Logger logger = LoggerFactory.getLogger(SmsAccessService.class);

	private String http = "http";

	private String host = "www.10690221.com";

	//private int port = 80;

	private String uid = "80794";

	private String businessCode="shjs";

	private String userPassword = "shjs33";

	private String path = "/hy/";

	public void postMsg(String phones, String msg) {
		try {
			if (StringUtils.isEmpty(phones)) {
				logger.error("需要发送的号码为空");
				return;
			}
//			URI uri = new URIBuilder().setScheme(http).setHost(host).setPath(path).setParameter("uid", uid)
//					.setParameter("auth", EncoderByMd5.encodeByMd5(businessCode + userPassword)).setParameter("mobile", phones.toString()).setParameter("expid", "0")
//					.setParameter("msg", java.net.URLEncoder.encode(msg, "gbk")).build();
//		
			String urlNameString = http+"://"+host+"/"+path+"?uid="+uid+"&auth="+EncoderUtil.encodeByMd5(businessCode + userPassword, "UTF-8")+"&mobile="+phones+"&expid=0";
			urlNameString += "&msg="+ java.net.URLEncoder.encode(msg, "gbk");

			HttpRequest.sendGet(urlNameString);
	
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}

	}
}
