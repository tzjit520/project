package com.platform.utils;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class LocationUtil {
	
	private static String baiDuKey;
	
	@Value("${baidu.app.key}")
	public void setBaiDuKey(String baiDuKey) {
		LocationUtil.baiDuKey = baiDuKey;
	}

	/**
	* 返回输入地址的经纬度坐标 key lng(经度),lat(纬度)
	*/
	public static Map<String, String> getLatitude(String address, String city) {
		try {
			// 将地址转换成utf-8的16进制
//			address = URLEncoder.encode(address, "UTF-8");
//			city = URLEncoder.encode(city, "UTF-8");
			// 如果有代理，要设置代理，没代理可注释
			// System.setProperty("http.proxyHost","192.168.172.23");
			// System.setProperty("http.proxyPort","3209");

			URL resjson = new URL("http://api.map.baidu.com/geocoder/v2/?address="+ address + "&output=json&ak=" + baiDuKey+"&city="+city);
			BufferedReader in = new BufferedReader(new InputStreamReader(resjson.openStream()));
			String res;
			StringBuilder sb = new StringBuilder("");
			while ((res = in.readLine()) != null) {
				sb.append(res.trim());
			}
			in.close();
			String str = sb.toString();
			System.out.println("return json:" + str);
			if(str!=null&&!str.equals("")){
				Map<String, String> map = null;
				int lngStart = str.indexOf("lng\":");
				int lngEnd = str.indexOf(",\"lat");
				int latEnd = str.indexOf("},\"precise");
				if (lngStart > 0 && lngEnd > 0 && latEnd > 0) {
					String lng = str.substring(lngStart + 5, lngEnd);
					String lat = str.substring(lngEnd + 7, latEnd);
					map = new HashMap<String, String>();
					map.put("lng", lng);
					map.put("lat", lat);
					return map;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public static void main(String args[]) {
		LocationUtil.baiDuKey = "x2SVorYNX5WcawbfUnpOyPpK";
		Map<String, String> map = LocationUtil.getLatitude("广东省深圳市福田区百花四路长安花园C座裙楼二楼201","深圳市");
		if (null != map) {
			System.out.println(map.get("lng"));
			System.out.println(map.get("lat"));
		}
	}
}