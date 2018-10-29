package com.platform.common.exception;

import com.platform.common.enums.ErrorEnum;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;

/**
 * 系统服务异常异常
 */
public class SystemServiceException extends CommonException {
    private static final long serialVersionUID = 1L;
    private static Logger logger = LoggerFactory.getLogger(SystemServiceException.class);

    public SystemServiceException(String message) {
        super(ErrorEnum.SERVICE_ERROR.status, message);
    }

    public SystemServiceException(String message, Throwable e) {
        super(ErrorEnum.SERVICE_ERROR.status, message, e);
        logger.error(message, e);
    }

    public SystemServiceException(int code, String message) {
        super(code, message);
        logger.error(message);
    }

    public SystemServiceException(int code, String message, Throwable e) {
        super(code, message, e);
        logger.error(message, e);
    }

}
