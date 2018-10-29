package com.platform.system.log.service;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.log.mapper.SysLogMapper;
import com.platform.system.log.model.SysLog;
import com.platform.system.user.model.SysUser;
import com.platform.utils.HttpUtil;
import com.platform.utils.UserUtils;

@Service
public class SysLogService extends BaseService<SysLogMapper,SysLog>{
	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<SysLog> selectByPage(SysLog vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<SysLog> results = this.selectByProperties(vo);

		PageModel<SysLog> page = new PageModel<SysLog>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	/**
	 * 记录日志
	 * @param type 日志类型，一般指模块名，在框架中只使用了SYSTEM一个类型
	 *             业务应用有需要，可在业务类的常量中自行定义，通常使用大写字符串
	 * @param level 日志等级：DEBUG、INFO、WARN、ERROR、FATAL
	 * @param module 模块--通常指类及方法
	 * @param requestTime 请求花费时间，单位为毫秒
	 */
	public void log(String type, String level, String module, Long requestTime) {
		this.log(type, level, module, requestTime, null, null, null);
	}
	
	/**
	 * 记录日志
	 * @param type 日志类型，一般指模块名，在框架中只使用了SYSTEM一个类型
	 *             业务应用有需要，可在业务类的常量中自行定义，通常使用大写字符串
	 * @param level 日志等级：DEBUG、INFO、WARN、ERROR、FATAL
	 * @param module 模块--通常指类及方法
	 * @param requestTime 请求花费时间，单位为毫秒
	 * @param requestData 请求数据
	 * @param responseData 响应数据
	 * @param exception 异常信息
	 */
	public void log(String type, String level, String module, Long requestTime, String requestData, String responseData, String exception) {
		SysLog log = new SysLog();
		log.setType(type);
		log.setLevel(level);
		log.setModule(module);
		log.setRequestTime(requestTime);
		log.setRequestData(requestData);
		log.setResponseData(responseData);
		log.setException(exception);
		log.setCreateDate(new Date());
		
		SysUser user = UserUtils.getUser();
        if(user!=null) {
            log.setCreateBy(user.getId());
        }
        
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        if (attributes != null) {
        	HttpServletRequest request = attributes.getRequest();
        	if (attributes != null) { 
        		log.setRequestUri(request.getRequestURL().toString());
                log.setMethod(request.getMethod());
                log.setRemoteIp(HttpUtil.getIpAddr(request));
        	}
        }
        
		log.preInsert();
		this.mapper.insertSelective(log);
	}
	
	/**
	 * 记录日志
	 * @param type 日志类型，一般指模块名，在框架中只使用了SYSTEM一个类型
	 *             业务应用有需要，可在业务类的常量中自行定义，通常使用大写字符串
	 * @param level 日志等级：DEBUG、INFO、WARN、ERROR、FATAL
	 * @param module 模块--通常指类及方法
	 */
	public void log(String type, String level, String module) {
		this.log(type, level, module, null, null, null, null);
	}
	
	/**
	 * 记录日志
	 * @param type 日志类型，一般指模块名，在框架中只使用了SYSTEM一个类型
	 *             业务应用有需要，可在业务类的常量中自行定义，通常使用大写字符串
	 * @param level 日志等级：DEBUG、INFO、WARN、ERROR、FATAL
	 * @param module 模块--通常指类及方法
	 * @param requestData 请求数据
	 * @param responseData 响应数据
	 * @param exception 异常信息
	 */
	public void log(String type, String level, String module, String requestData, String responseData, String exception) {
		this.log(type, level, module, null, requestData, responseData, exception);
	}
	
	/**
	 * 记录日志
	 * @param type 日志类型，一般指模块名，在框架中只使用了SYSTEM一个类型
	 *             业务应用有需要，可在业务类的常量中自行定义，通常使用大写字符串
	 * @param level 日志等级：DEBUG、INFO、WARN、ERROR、FATAL
	 * @param module 模块--通常指类及方法
	 * @param requestData 请求数据
	 */
	public void log(String type, String level, String module, String requestData) {
		this.log(type, level, module, null, requestData, null, null);
	}
	
	/**
	 * 记录日志
	 * @param type 日志类型，一般指模块名，在框架中只使用了SYSTEM一个类型
	 *             业务应用有需要，可在业务类的常量中自行定义，通常使用大写字符串
	 * @param level 日志等级：DEBUG、INFO、WARN、ERROR、FATAL
	 * @param module 模块--通常指类及方法
	 * @param requestTime 请求花费时间，单位为毫秒
	 * @param requestData 请求数据
	 */
	public void log(String type, String level, String module, Long requestTime, String requestData) {
		this.log(type, level, module, requestTime, requestData, null, null);
	}
}
