package com.platform.task.util;

import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.commons.lang3.StringUtils;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobExecutionContext;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.matchers.GroupMatcher;
import org.quartz.impl.triggers.CronTriggerImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.ApplicationContext;

import com.platform.common.constants.CommonConstants;
import com.platform.common.exception.SystemServiceException;
import com.platform.system.log.model.SysLog;
import com.platform.system.log.service.SysLogService;
import com.platform.task.model.SysScheduleJob;

public class ScheduleJobUtils {
    private static final Logger logger = LoggerFactory.getLogger(ScheduleJobUtils.class);

    private final static String JOB_NAME_PREFIX = "TASK_";

    /**
     * 启动Scheduler
     *
     * @param scheduler
     */
    public static void startScheduler(Scheduler scheduler) {
        try {
            if (!scheduler.isStarted()) {
                scheduler.start();
            }
        } catch (SchedulerException e) {
            throw new SystemServiceException("启动Scheduler出现异常", e);
        }
    }

    /**
     * 关闭Scheduler
     *
     * @param scheduler
     */
    public static void stopScheduler(Scheduler scheduler) {
        try {
            if (!scheduler.isShutdown()) {
                scheduler.standby();
            }
        } catch (SchedulerException e) {
            throw new SystemServiceException("停止Scheduler出现异常", e);
        }
    }

    /**
     * 获取JobKey
     *
     * @param jobId
     * @return
     */
    public static JobKey getJobKey(Integer jobId) {
        return JobKey.jobKey(JOB_NAME_PREFIX + jobId);
    }

    /**
     * 获取TriggerKey
     *
     * @param jobId
     * @return
     */
    public static TriggerKey getTriggerKey(Integer jobId) {
        return TriggerKey.triggerKey(JOB_NAME_PREFIX + jobId);
    }

    /**
     * 获取表达式触发器
     *
     * @param scheduler
     * @param jobId
     * @return
     */
    public static CronTrigger getCronTrigger(Scheduler scheduler, Integer jobId) {
        try {
            return (CronTrigger) scheduler.getTrigger(getTriggerKey(jobId));
        } catch (SchedulerException e) {
            throw new SystemServiceException("获取定时任务CronTrigger出现异常", e);
        }
    }

    /**
     * 返回指定任务的状态
     *
     * @param scheduler
     * @param job
     * @return
     */
    public static int getJobStatus(Scheduler scheduler, SysScheduleJob job) {
        TriggerKey triggerKey = getTriggerKey(job.getId());
        try {
            Trigger.TriggerState triggerState = scheduler.getTriggerState(triggerKey);
            return triggerState.ordinal();
        } catch (SchedulerException e) {
            throw new SystemServiceException("获取指定任务的状态出现异常", e);
        }
    }

    /**
     * 暂停任务
     *
     * @param scheduler
     * @param jobId
     */
    public static void pauseJob(Scheduler scheduler, Integer jobId) {
        try {
            scheduler.pauseJob(getJobKey(jobId));
        } catch (SchedulerException e) {
            throw new SystemServiceException("暂停定时任务失败", e);
        }
    }

    /**
     * 恢复任务
     *
     * @param scheduler
     * @param jobId
     */
    public static void resumeJob(Scheduler scheduler, Integer jobId) {
        try {
            scheduler.resumeJob(getJobKey(jobId));
        } catch (SchedulerException e) {
            throw new SystemServiceException("恢复定时任务失败", e);
        }
    }

    /**
     * 立即执行一次任务
     *
     * @param scheduler
     * @param jobId
     */
    public static void runJobOnce(Scheduler scheduler, Integer jobId) {
        try {
            scheduler.triggerJob(getJobKey(jobId));
        } catch (SchedulerException e) {
            throw new SystemServiceException("立即执行定时任务失败", e);
        }
    }

    /**
     * 判断cron时间表达式是否正确
     *
     * @param cronExpression
     * @return
     */
    public static boolean isValidCronExpression(final String cronExpression) {
        CronTriggerImpl trigger = new CronTriggerImpl();
        try {
            trigger.setCronExpression(cronExpression);
            Date date = trigger.computeFirstFireTime(null);
            return date != null && date.after(new Date());
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * 创建定时任务
     *
     * @param scheduler
     * @param job
     */
    @SuppressWarnings("unchecked")
	public static void createJob(Scheduler scheduler, SysScheduleJob job, ApplicationContext applicationContext) {
        try {
            JobKey jobKey = getJobKey(job.getId());
            // 判断创建的任务是否允许并发执行
            @SuppressWarnings("rawtypes")
			Class clazz = job.getConcurrent() == 1 ? ConcurrentJobFactory.class : NoncurrentJobFactory.class;
            // 构建job信息
            JobDetail jobDetail = JobBuilder.newJob(clazz).withIdentity(jobKey).build();
            jobDetail.getJobDataMap().put(job.getClass().getName(), job);
//            jobDetail.getJobDataMap().put("applicationContextKey", applicationContext);
            // 表达式调度构建器
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());
            // 根据cronExpression表达式构建trigger
            TriggerKey triggerKey = getTriggerKey(job.getId());
            CronTrigger trigger = TriggerBuilder.newTrigger().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();

            // 如下一段为循环执行的定时器写法
            // Date triggerDate = Calendar.getInstance().getTime();
            // SimpleScheduleBuilder scheduleBuilder = SimpleScheduleBuilder.simpleSchedule().withIntervalInSeconds(2).repeatForever();
            // TriggerKey triggerKey = getTriggerKey(job.getId());
            // TriggerBuilder<Trigger> triggerBuilder  = TriggerBuilder.newTrigger().withIdentity(triggerKey);
            // Trigger trigger = triggerBuilder.startAt(triggerDate).withSchedule(scheduleBuilder).build();

            // 可以设置参数
            //trigger.getJobDataMap().put("key", "value");
            // 根据trigger设置job执行
            scheduler.scheduleJob(jobDetail, trigger);
            // 暂停任务
            if (job.getStatus() == Trigger.TriggerState.PAUSED.ordinal()) {
                pauseJob(scheduler, job.getId());
            }
        } catch (SchedulerException e) {
            throw new SystemServiceException("创建定时任务失败", e);
        }
    }

    /**
     * 删除定时任务
     *
     * @param scheduler
     * @param jobId
     */
    public static void deleteJob(Scheduler scheduler, Integer jobId) {
        try {
            // 删除任务后，其所对应的trigger也会被删除
            scheduler.deleteJob(getJobKey(jobId));
        } catch (SchedulerException e) {
            throw new SystemServiceException("删除定时任务失败", e);
        }
    }

    /**
     * 更新定时任务
     *
     * @param scheduler
     * @param job
     */
    public static void updateJob(Scheduler scheduler, SysScheduleJob job) {
        try {
            // 根据triggerKey获取trigger
            TriggerKey triggerKey = getTriggerKey(job.getId());
            CronTrigger trigger = (CronTrigger) scheduler.getTrigger(triggerKey);
            if (trigger == null) {
                return;
            }
            // 新的表达式调度构建器
            CronScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(job.getCronExpression());
            // 根据新的cronExpression表达式重新构建trigger
            trigger = trigger.getTriggerBuilder().withIdentity(triggerKey).withSchedule(scheduleBuilder).build();
            // 可以修改参数
            //trigger.getJobDataMap().put("key", "value");
            trigger.getJobDataMap().put(job.getClass().getName(), job);
            // 根据新的trigger重新设置job执行
            scheduler.rescheduleJob(triggerKey, trigger);
            // 暂停任务
            if (job.getStatus() == Trigger.TriggerState.PAUSED.ordinal()) {
                pauseJob(scheduler, job.getId());
            }
        } catch (SchedulerException e) {
            throw new SystemServiceException("更新定时任务失败", e);
        }
    }

    /**
     * 获取所有计划中的任务
     *
     * @param scheduler
     * @return
     */
    public static List<SysScheduleJob> getAllScheduleJobs(Scheduler scheduler) {
        List<SysScheduleJob> jobList = new ArrayList<SysScheduleJob>();
        GroupMatcher<JobKey> matcher = GroupMatcher.anyJobGroup();
        try {
            Set<JobKey> jobKeys = scheduler.getJobKeys(matcher);
            for (JobKey jobKey : jobKeys) {
                Integer jobId = Integer.parseInt(jobKey.getName().replace(JOB_NAME_PREFIX, ""));
                List<? extends Trigger> triggers = scheduler.getTriggersOfJob(jobKey);
                for (Trigger trigger : triggers) {
                    Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());
                    SysScheduleJob job = new SysScheduleJob();
                    job.setId(jobId);
                    job.setStatus(triggerState.ordinal());
                    if (trigger instanceof CronTrigger) {
                        String cronExpression = ((CronTrigger) trigger).getCronExpression();
                        job.setCronExpression(cronExpression);
                    }
                    jobList.add(job);
                }
            }
        } catch (SchedulerException e) {
            throw new SystemServiceException("获取所有计划中的任务失败", e);
        }
        return jobList;
    }

    /**
     * 获取所有运行中的任务
     *
     * @param scheduler
     * @return
     */
    public static List<SysScheduleJob> getAllRunningJobs(Scheduler scheduler) {
        List<SysScheduleJob> jobList = new ArrayList<SysScheduleJob>();
        try {
            List<JobExecutionContext> executingJobs = scheduler.getCurrentlyExecutingJobs();
            for (JobExecutionContext executingJob : executingJobs) {
                JobDetail jobDetail = executingJob.getJobDetail();
                JobKey jobKey = jobDetail.getKey();
                Trigger trigger = executingJob.getTrigger();
                Trigger.TriggerState triggerState = scheduler.getTriggerState(trigger.getKey());

                Integer jobId = Integer.parseInt(jobKey.getName().replace(JOB_NAME_PREFIX, ""));
                SysScheduleJob job = new SysScheduleJob();
                job.setId(jobId);
                job.setStatus(triggerState.ordinal());
                if (trigger instanceof CronTrigger) {
                    String cronExpression = ((CronTrigger) trigger).getCronExpression();
                    job.setCronExpression(cronExpression);
                }
                jobList.add(job);
            }
        } catch (SchedulerException e) {
            throw new SystemServiceException("获取所有运行中的任务失败", e);
        }
        return jobList;
    }


    /**
     * 调用真正的任务
     *
     * @param appContext
     * @param job
     */
    public static void invokMethod(ApplicationContext appContext, SysScheduleJob job) {
        SysLogService logService = (SysLogService) appContext.getBean("sysLogService");
        SysLog sysLog = new SysLog();
        sysLog.setType("SCHEDULE");
        sysLog.setCreateDate(new Date());
        sysLog.setOperate(job.getJobName());
        String moduleName = job.getBeanName() != null ? job.getBeanName() : job.getClassName();
        sysLog.setModule(moduleName);
        sysLog.setMethod(job.getMethodName());
        // 任务开始时间
        long start = System.currentTimeMillis();
        // 准备开始执行任务
        Object target = null;
        if (StringUtils.isNoneBlank(job.getBeanName())) {
            // 根据Spring Bean名称查找bean
            target = appContext.getBean(job.getBeanName());
        } else if (StringUtils.isNoneBlank(job.getClassName())) {
            // 根据完整的类名来加载执行类
            try {
                target = Class.forName(job.getClassName()).newInstance();
            } catch (Exception e) {
                logger.error(e.getMessage(), e);
            }
        }
        if (target == null) {
            sysLog.setLevel(CommonConstants.LOG_LEVEL_ERROR);
            logger.error("任务[" + job.getId() + "]启动失败，请检查执行类是否配置正确！");
        } else {
            Method method = null;
            try {
                method = target.getClass().getDeclaredMethod(job.getMethodName());
            } catch (NoSuchMethodException e) {
                sysLog.setLevel(CommonConstants.LOG_LEVEL_ERROR);
                logger.error("任务[" + job.getId() + "]启动失败，请检查执行类的方法名是否设置正确！");
            } catch (SecurityException e) {
                logger.error(e.getMessage(), e);
            }
            if (method != null) {
                try {
                    // 方法调用
                    method.invoke(target);
                    // 日志
                    long times = System.currentTimeMillis() - start;
                    sysLog.setRequestTime(times);
                    sysLog.setLevel(CommonConstants.LOG_LEVEL_INFO);
                    logger.info("任务[" + job.getId() + "]执行完毕，总共耗时：" + times + "毫秒");
                } catch (Exception e) {
                    logger.error(e.getMessage(), e);
                    // 日志
                    long times = System.currentTimeMillis() - start;
                    sysLog.setRequestTime(times);
                    sysLog.setLevel(CommonConstants.LOG_LEVEL_ERROR);
                    logger.error("任务[" + job.getId() + "]执行失败，总共耗时：" + times + "毫秒");
                }
            }
        }
        // 记录日志
        logService.save(sysLog);
    }
}
