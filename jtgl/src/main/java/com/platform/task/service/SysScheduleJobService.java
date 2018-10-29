package com.platform.task.service;

import java.util.List;

import javax.annotation.PostConstruct;

import org.quartz.CronTrigger;
import org.quartz.Scheduler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.task.mapper.SysScheduleJobMapper;
import com.platform.task.model.SysScheduleJob;
import com.platform.task.util.ScheduleJobUtils;
import com.platform.utils.SpringUtil;


@Service
public class SysScheduleJobService extends BaseService<SysScheduleJobMapper, SysScheduleJob> {

    protected Logger logger = LoggerFactory.getLogger(getClass());

    @Autowired
    private Scheduler scheduler;

    /**
     * 项目启动时，加载定时任务，初始化定时器
     */
    @PostConstruct
    public void init() {
        // 从数据库加载任务信息
        List<SysScheduleJob> scheduleJobList = this.getMapper().selectRunTaskJob();
        for (SysScheduleJob job : scheduleJobList) {
            //logger.debug("job info: " + job.toString());
            CronTrigger cronTrigger = ScheduleJobUtils.getCronTrigger(scheduler, job.getId());
            // 如果不存在，则创建
            if (cronTrigger == null) {
                ScheduleJobUtils.createJob(scheduler, job, SpringUtil.getApplicationContext());
            } else {
                ScheduleJobUtils.updateJob(scheduler, job);
            }
        }
        // 默认开始调度任务
        ScheduleJobUtils.startScheduler(scheduler);
    }

    // 该方法用于定时任务测试
    public void test() {
        logger.debug("---------------------schedule job service test---------------------");
    }

    /**
     * 立即执行一次任务
     *
     * @param jobId
     */
    public void runJobOnce(int jobId) {
        ScheduleJobUtils.runJobOnce(scheduler, jobId);
    }

    //修改任务状态
    public int updateJobStatus(Integer status, long id){
        return mapper.updateJobStatus(status,id);
    }

    @Transactional(readOnly = true)
    @SuppressWarnings({"rawtypes", "unchecked"})
    public PageModel<SysScheduleJob> selectByPage(SysScheduleJob vo) {
        PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(), vo.getOrderBy());
        List<SysScheduleJob> results = this.selectByProperties(vo);

        PageModel<SysScheduleJob> page = new PageModel<SysScheduleJob>();
        Page pageList = (Page) results;
        page.setPageIndex(pageList.getPageNum());
        page.setPageSize(pageList.getPageSize());
        page.setTotal(pageList.getTotal());
        page.setData(pageList.getResult());
        page.setPageCount(pageList.getPages());
        return page;
    }


}
