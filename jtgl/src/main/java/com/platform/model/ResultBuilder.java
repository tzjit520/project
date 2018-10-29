package com.platform.model;

public class ResultBuilder<T> {
	
	private Integer code = 0;
	private String message = "OK";
	private T data;

	public ResultBuilder<T> code(Integer code) {
		this.code = code;
		return this;
	}

	public ResultBuilder<T> message(String message) {
		this.message = message;
		return this;
	}
	
	public ResultBuilder<T> message(Integer code,String message) {
		this.code = code;
		this.message = message;
		return this;
	}

	public ResultBuilder<T> data(T data) {
		this.data = data;
		return this;
	}
	
	public ResultBuilder<T> init(Integer code,String message,T data) {
		this.code = code;
		this.message = message;
		this.data = data;
		return this;
	}

	public Result<T> build() {
		return new Result<T>(this.code, this.message, this.data);
	}
}
