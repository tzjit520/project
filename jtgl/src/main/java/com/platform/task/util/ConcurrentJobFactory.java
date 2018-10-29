package com.platform.task.util;

import org.quartz.Job;
import org.quartz.JobDataMap;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.platform.task.model.SysScheduleJob;
import com.platform.utils.SpringUtil;


/**
 * 允许并发执行的任务
 */
public class ConcurrentJobFactory implements Job {
    @Override
    public void execute(JobExecutionContext jobContext) throws JobExecutionException {
        JobDataMap jobDataMap = jobContext.getMergedJobDataMap();
        SysScheduleJob job = (SysScheduleJob) jobDataMap.get(SysScheduleJob.class.getName());
        if (SpringUtil.getApplicationContext() != null) {
            ScheduleJobUtils.invokMethod(SpringUtil.getApplicationContext(), job);
        }
    }
}
