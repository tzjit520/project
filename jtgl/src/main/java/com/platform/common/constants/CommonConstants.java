package com.platform.common.constants;


public class CommonConstants {

	public static final String SESSION_FORCE_LOGOUT_KEY = "force_logout";
	
	public static final String DEFAULT_LOGIN_FAIL_KEY_NAME = "shiroLoginFailure";
	
	public static final String TOK_ACCESS_TOKEN = "tok_access_token";

	public static final String ADMIN_TOKEN_CACHE_NAME = "adminTokenCache";

	public static final String APP_TOKEN_CACHE_NAME = "appTokenCache";

	public static final String LOV_CACHE_NAME = "lovCache";

	
	// 日志类型，一般指模块名，在框架中暂时只使用了SYSTEM一个类型
	// 业务应用有需要，可在业务类的常量中自行定义，通常使用大写字符串
	public static final String LOG_TYPE_SYSTEM = "SYSTEM";
	
	// 日志登记
	public static final String LOG_LEVEL_DEBUG = "DEBUG";
	public static final String LOG_LEVEL_INFO = "INFO";
	public static final String LOG_LEVEL_WARN = "WARN";
	public static final String LOG_LEVEL_ERROR = "ERROR";
	public static final String LOG_LEVEL_FATAL = "FATAL";
	
	public static final String KAPTCHA_CACHE = "kaptchaCache";
}
