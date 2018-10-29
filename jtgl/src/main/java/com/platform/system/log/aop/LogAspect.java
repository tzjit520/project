package com.platform.system.log.aop;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.alibaba.fastjson.JSON;
import com.platform.common.constants.CommonConstants;
import com.platform.system.log.model.SysLog;
import com.platform.system.log.service.SysLogService;
import com.platform.system.user.model.SysUser;
import com.platform.utils.HttpUtil;
import com.platform.utils.UserUtils;

@Aspect
public class LogAspect{
	
	private Logger logger = Logger.getLogger(getClass());
    
    @Value("${controller.log}")
    private boolean islog = false;

    private ThreadLocal<SysLog> tlocal = new ThreadLocal<SysLog>();

    @Pointcut("execution(public * com..controller..*.*(..))")
	public void inController(){};
	
	@Pointcut("inController()")
	public void logPointcut(){};

    @Autowired
    private SysLogService logService;

    /**
	 * 方法调用前，记录调用开始时间等日志信息
	 */
    @Before("logPointcut()")
    public void doBefore(JoinPoint joinPoint) throws Throwable {
    	if (islog) {
    		//请求时间
	        long beginTime = System.currentTimeMillis();

	        // 接收到请求，记录请求内容
	        ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
	        HttpServletRequest request = attributes.getRequest();
	
	        //验证码不需要记录日志，方法当中尽量避免加入httpServletRequest，暂时没有做处理，需要request
	        if(request.getRequestURL().toString().contains("getValidateCode")) {
	            return;
	        }
	        SysLog log = new SysLog();
	        SysUser user = UserUtils.getUser();
	        if(user != null) {
	            log.setCreateBy(user.getId());
	            log.setRemoteIp(HttpUtil.getIpAddr(request));
	        }
	        log.setRequestUri(request.getRequestURL().toString());
	        log.setMethod(request.getMethod());
	        log.setLevel(CommonConstants.LOG_LEVEL_INFO);
	        log.setType(CommonConstants.LOG_TYPE_SYSTEM);
	        log.setOperate("方法调用");
	        //日志信息
	        String signatureStr = joinPoint.getSignature().toString();
	        String moduleName = signatureStr.substring(signatureStr.indexOf(" ")+1);
	        log.setModule(moduleName);
	        log.setRequestTime(beginTime);
	        // 由于RequestData数据太多，暂不写入日志表，根据需要可以打开
	        //log.setRequestData(params);
	        tlocal.set(log);
    	}
    }

    /**
     * 方法调用成功后，计算调用时间并记录日志
     * @param response
     * @throws Throwable
     */
    @AfterReturning(returning = "response", pointcut = "logPointcut()")
    public void doAfterReturning(Object response) throws Throwable {
    	SysLog log = tlocal.get();
    	tlocal.remove();
    	if (islog) {
	        if(log != null) {
	        	// 由于responseData数据太多，暂不写入日志表，根据需要可以打开
	        	// 异常信息也没有写入日志表
	        	//log.setResponseData(str);
	            long beginTime = log.getRequestTime();
	            long currentTime = System.currentTimeMillis();
	            long requestTime = currentTime - beginTime;
	            log.setRequestTime(requestTime);
	            logService.save(log);
	            // 处理完请求，返回内容
	            logger.debug(JSON.toJSONString(log));
	        }
    	}
    }
	
    /**
	 * 方法调用异常后，计算调用时间并记录日志
	 */
	@AfterThrowing(value="logPointcut()", throwing="ex")
	public void afterThrowingAdvice(Exception ex) {
		SysLog log = tlocal.get();
		tlocal.remove();
		if (islog) {
			//调用失败，记录时间
			long beginTime = log.getRequestTime();
            long currentTime = System.currentTimeMillis();
            long requestTime = currentTime - beginTime;
			// 异常信息
			Throwable t = this.parseException(ex);
			StringBuffer exceptionBuf = new StringBuffer(t.toString());
			StackTraceElement[] ste = t.getStackTrace();
			if (ste != null && ste.length > 0) {
				exceptionBuf.append(", at ").append(ste[0].toString());
			}
			log.setRequestTime(requestTime);
			String exceptions = exceptionBuf.toString();
			log.setException(exceptions);
			logService.save(log);
			
		}
	}
	
	/**
	 * 解析异常，获取引发异常的源头
	 * @param e
	 * @return
	 */
	private Throwable parseException(Throwable e) {
		int breakCount = 0;
		Throwable t = e;
		while (t.getCause() != null) {
			if (t.equals(t.getCause())) {
				break;
			}
			t = t.getCause();
			breakCount++;
			if (breakCount > 200) {
				break;
			}
		}
		return t;
	}
}
