package com.platform.jobs;

import java.util.List;

import com.jtgl.test.model.TestUser;
import com.jtgl.test.service.TestUserService;
import com.platform.system.log.mapper.SysLogMapper;
import com.platform.utils.SpringUtil;

/**
 * 定期清理日志
 */
public class SysLogCleaner {

	private Integer logDays = 2;//日志保留的天数

	private String SYSTEM = "SYSTEM";
	private String SCHEDULE = "SCHEDULE";
	
	/**
	 * 定期清除系统参数中指定的日志保留天数之前的系统日志。若未指定参数，则取默认值90
	 */
	public void cleanLogs(){
		// 要清理的日志类型
		String[] logTypes = {SYSTEM, SCHEDULE};
		// 系统参数表中配置的日志保留天数*24得到小时数
		int reserverHours = logDays*24;
		SysLogMapper mapper = (SysLogMapper) SpringUtil.getBean("sysLogMapper");
		// 清理日志
		int count = mapper.cleanLogs(logTypes, reserverHours);
		System.out.println("成功清理"+count+"条日志");
	}
	
	public void testSchedule(){
		TestUserService testUserService = (TestUserService) SpringUtil.getBean("testUserService");
		List<TestUser> listUser = testUserService.selectByProperties(new TestUser());
		for (TestUser testUser : listUser) {
			System.out.println("姓名："+testUser.getName()+"--年龄："+testUser.getAge());
		}
	}
}
