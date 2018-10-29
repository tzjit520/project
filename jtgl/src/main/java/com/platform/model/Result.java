package com.platform.model;

import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonView;

public class Result<T> implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -5321325700529744542L;

	@JsonView(JsonViewFilter.Base.class)
	private Integer code = 0;

	@JsonView(JsonViewFilter.Base.class)
	private String message = "OK";

	@JsonView(JsonViewFilter.Base.class)
	private T data = null;

	public Result() {
	}

	public Result(Integer code, String message, T data) {
		this.code = code;
		this.message = message;
		this.data = data;
	}

	public Integer getCode() {
		return this.code;
	}

	public void setCode(Integer code) {
		this.code = code;
	}

	public String getMessage() {
		return this.message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public T getData() {
		return this.data;
	}

	public void setData(T data) {
		this.data = data;
	}
}
