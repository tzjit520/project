package com.platform.task.model;

import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@EntityAnotation(logicalDelete = true)
public class SysScheduleJob extends BaseEntity<SysScheduleJob> {

	private static final long serialVersionUID = 5065128880402148502L;

	// status 1表示正常，2表示暂停
	private String jobName; // 任务名称
	private String beanName; // bean名称
	private String className; // class名称
	private  String methodName;//方法名称
	private String cronExpression; // cron表达式
	private Integer concurrent; // 是否并发执行：1表示是，0表示否

	public void setMethodName(String methodName) {
		this.methodName = methodName;
	}

	public String getMethodName() {
		return methodName;
	}

	public String getJobName() {
		return jobName;
	}
	
	public void setJobName(String jobName) {
		this.jobName = jobName;
	}
	
	public String getBeanName() {
		return beanName;
	}
	
	public void setBeanName(String beanName) {
		this.beanName = beanName;
	}
	
	public String getClassName() {
		return className;
	}
	
	public void setClassName(String className) {
		this.className = className;
	}
	
	public String getCronExpression() {
		return cronExpression;
	}
	
	public void setCronExpression(String cronExpression) {
		this.cronExpression = cronExpression;
	}
	
	public Integer getConcurrent() {
		return concurrent;
	}
	
	public void setConcurrent(Integer concurrent) {
		this.concurrent = concurrent;
	}

}
