package com.platform.common.enums;

public enum ErrorEnum {

	OK(0, null),

	NOT_AUTHORIZED(-0x1901001, "鉴权错误"),

	REQUEST_FORBIDDEN(-0x1901003,"禁止访问"),

	PARAMETER_ERROR(-0x1901000, "参数不合法"),

	USER_NOT_EXISTS_ERROR(-0x1901201, "用户不存在"),

	USER_EXISTS_ERROR(-0x1901202, "用户已存在"),

	SERVICE_ERROR(-0x1901500, "服务异常"),
	
	HTTP_CONNECT_ERROR(-0x1902500, "HTTP连接失败");

	public Integer status;

	public String message;

	private ErrorEnum(Integer status, String message) {

		this.status = status;
		this.message = message;
	}
	

}
