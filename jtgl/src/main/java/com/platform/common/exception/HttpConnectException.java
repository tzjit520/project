package com.platform.common.exception;

import com.platform.common.enums.ErrorEnum;

public class HttpConnectException extends CommonException {

	private static final long serialVersionUID = 6454070676644086607L;

	public HttpConnectException() {
		this(ErrorEnum.HTTP_CONNECT_ERROR);
	}

	public HttpConnectException(ErrorEnum errorEnum) {
		this(errorEnum.status, errorEnum.message);
	}
	
	public HttpConnectException(Throwable e) {
		this(ErrorEnum.HTTP_CONNECT_ERROR.status, ErrorEnum.HTTP_CONNECT_ERROR.message, e);
	}
	
	public HttpConnectException(int code, String message) {
		super(code, message);
	}
	
	public HttpConnectException(int code, String message, Throwable e) {
		super(code, message, e);
	}

}
