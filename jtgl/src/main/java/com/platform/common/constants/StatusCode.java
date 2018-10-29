package com.platform.common.constants;

public class StatusCode {
	
	//60分钟过期
	public static final int ACCESS_TOKEN_EXPIRE_TIME = 60;
	
	public static final int SMS_CODE_EXPIRE_TIME = 3;
	
	public static final int COMMON_STATUS_INITIAL = -1;	// 用户初始状态
	
	public static final int COMMON_STATUS_ACTIVE = 1; // 用户启用状态

	public static final int COMMON_STATUS_INACTIVE = 0;	// 用户停用状态

	public static final int COMMON_STATUS_LOCK = 2;	// 用户锁定状态

	public static final int RESULT_STATUS_SUCCESS = 0;
	
	//数据是否逻辑删除
	/**
	 * 正常数据
	 */
	public static final int COMMON_DELETE_NORMAL = 0;
	/**
	 * 已被逻辑删除
	 */
	public static final int COMMON_DELETE_DELETED = 1;
	
	//错误码
	public static final int USER_PASSWORD_INVALID = 5000;

	public static final String USER_PASSWORD_INVALID_MSG = "用户名或密码错误!";
	
	public static final int USER_ORIGION_PASSWORD_INVALID = 5001;

	public static final String USER_ORIGION_PASSWORD_INVALID_MSG = "原密码错误!";

	public static final int ACCESS_TOKEN_INVALID = 6000;
	
	public static final String ACCESS_TOKEN_INVALID_MSG = "权限过期或无效!";
	
	public static final int SMS_CODE_INVALID = 6001;
	
	public static final String SMS_CODE_INVALID_MSG = "验证码过期或无效!";

	public static final int SESSION_TIMEOUT = 6002;

	public static final String SESSION_TIMEOUT_MSG = "会话已失效，请重新登录!";

	public static final int FORCE_LOGOUT = 6003;

	public static final String FORCE_LOGOUT_MSG = "您已被管理员强制下线!";

	public static final int LIMIT_LOGOUT = 6004;

	public static final String LIMIT_LOGOUT_MSG = "该账户已在其他地方登陆,会话已失效!";

	public static final int MAX_RETRY = 6005;

	public static final String MAX_RETRY_MSG = "尝试登陆次数过多,账户将锁定1分钟!";

	public static final int USER_LOCK = 6006;

	public static final String USER_LOCK_MSG = "用户已被锁定,请联系管理员!";

	public static final int USER_INITIAL = 6007;

	public static final String USER_INITIAL_MSG = "初始用户,请先修改初始密码!";

	public static final int PASSWORD_EXPIRED = 6008;

	public static final String PASSWORD_EXPIRED_MSG = "密码已过期，请先修改密码!";

	public static final int IP_ACCESS_DENIED = 6009;

	public static final String IP_ACCESS_DENIED_MSG = "当前IP地址禁止访问!";

	public static final int USER_WILL_LOCK = 6010;

	public static final String USER_WILL_LOCK_MSG = "用户登录已失败3次，失败5次将被锁定!";
	
	public static final int GENERATOR_CODE_ERROR = 6050;

	public static final String GENERATOR_CODE_ERROR_MSG = "生成代码失败!";
}
