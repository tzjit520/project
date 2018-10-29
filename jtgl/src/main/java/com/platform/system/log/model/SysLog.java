package com.platform.system.log.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

@EntityAnotation(logicalDelete = false)
public class SysLog extends BaseEntity<SysLog> {

	private static final long serialVersionUID = 5396090586788268828L;

	private String type;				// 日志类型，一般指模块名，在框架中暂时只使用了SYSTEM一个类型,业务应用有需要，可在业务类的常量中自行定义，通常使用大写字符串
    private String remoteIp;			// 访问地址
    private String requestUri;			// 请求URI
    private String method;				// 操作方式，put，get，delete等
    private String module;				// 模块-指类名及方法
    private String operate;				// 操作
    private String level;				// 日志等级：DEBUG、INFO、WARN、ERROR、FATAL
    private String requestData;			// 方法调用请求参数
    private Long requestTime;			// 方法调用时间开销
    private String responseData;		// 方法调用回应数据
    private String exception;			// 异常信息

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getRemoteIp() {
        return remoteIp;
    }

    public void setRemoteIp(String remoteIp) {
        this.remoteIp = remoteIp;
    }

    public String getRequestUri() {
        return requestUri;
    }

    public void setRequestUri(String requestUri) {
        this.requestUri = requestUri;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module;
    }

    public String getOperate() {
        return operate;
    }

    public void setOperate(String operate) {
        this.operate = operate;
    }

    public String getRequestData() {
        return requestData;
    }

    public void setRequestData(String requestData) {
        this.requestData = requestData;
    }

    public String getResponseData() {
        return responseData;
    }

    public void setResponseData(String responseData) {
        this.responseData = responseData;
    }

    public String getException() {
        return exception;
    }

    public void setException(String exception) {
        this.exception = exception;
    }

    public Long getRequestTime() {
        return requestTime;
    }

    public void setRequestTime(Long requestTime) {
        this.requestTime = requestTime;
    }

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}
    
}