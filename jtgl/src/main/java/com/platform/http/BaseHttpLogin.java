package com.platform.http;

public abstract class BaseHttpLogin {

	/**
	 * 登录
	 * @return 返回登陆后获取的cookies等数据
	 */
	public abstract RequestContext login();
	
}
