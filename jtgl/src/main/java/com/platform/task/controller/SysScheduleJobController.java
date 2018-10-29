package com.platform.task.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.quartz.Scheduler;
import org.quartz.Trigger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.page.PageModel;
import com.platform.task.model.SysScheduleJob;
import com.platform.task.service.SysScheduleJobService;
import com.platform.task.util.ScheduleJobUtils;
import com.platform.utils.SpringUtil;

@Controller
@RequestMapping("/api/v1/task")
public class SysScheduleJobController extends BaseController {
	
	@Autowired
	private SysScheduleJobService sysSchedulejobService;

	@Autowired
	private Scheduler scheduler;

    // 根据属性分页查询数据
	@RequiresPermissions("schedule:view")
	@RequestMapping(method = RequestMethod.GET)
	public String findByPage(SysScheduleJob sysScheduleJob, Model model) throws Exception {
		PageModel<SysScheduleJob> page = sysSchedulejobService.selectByPage(sysScheduleJob);
		model.addAttribute("scheduleJob", sysScheduleJob);
		model.addAttribute("page", page);
		return "platform/task/list";
	}

	// 根据ID查询数据
	@RequiresPermissions("schedule:view")
	@RequestMapping(value="{id}", method = RequestMethod.GET)
	public String findById(@PathVariable Integer id, Model model) throws Exception {
		SysScheduleJob scheduleJob = new SysScheduleJob();
		if(id != null && id.intValue() != 0){
			scheduleJob = sysSchedulejobService.selectById(id);
		}
		model.addAttribute("scheduleJob", scheduleJob);
		return "platform/task/save";
	}

	// 保存数据
	@RequiresPermissions("schedule:add")
	@RequestMapping(method = RequestMethod.POST)
	public String save(SysScheduleJob sysSchedulejob) {
		sysSchedulejobService.save(sysSchedulejob);
		// 如果任务的状态为正常，还需将任务加入到schedule中
		ScheduleJobUtils.createJob(scheduler, sysSchedulejob, SpringUtil.getApplicationContext());
		return "redirect:/api/v1/task";
	}
	
	// 更新数据
	@RequiresPermissions("schedule:update")
	@RequestMapping(method = RequestMethod.PUT)
	public String update(SysScheduleJob sysSchedulejob) {
		// 获取任务原有状态
		//int jobStatus = sysSchedulejobService.selectById(sysSchedulejob.getId()).getStatus();
		sysSchedulejobService.updateNotNull(sysSchedulejob);

		// 更新任务
        ScheduleJobUtils.updateJob(scheduler, sysSchedulejob);
        return "redirect:/api/v1/task";
	}

    // 批量删除数据
	@RequiresPermissions("schedule:delete")
    @RequestMapping(method = RequestMethod.DELETE)
    public @ResponseBody Result<String> batchDelete(SysScheduleJob sysSchedulejob) {
        String ids = sysSchedulejob.getIds();
        for(String id : ids.split(",")) {
            sysSchedulejobService.delete(Integer.parseInt(id));
        }
        return new ResultBuilder<String>().data("").build();
    }

	// 恢复定时任务
	@RequiresPermissions("schedule:update")
	@RequestMapping(value="startSchedule",method = RequestMethod.GET)
	public @ResponseBody Result<String> start(Integer id) throws Exception {
		ScheduleJobUtils.resumeJob(scheduler, id);
		Integer jobStatus= Trigger.TriggerState.NORMAL.ordinal();
		sysSchedulejobService.updateJobStatus(jobStatus,id);
		return new ResultBuilder<String>().data("").build();
	}

	// 暂停定时任务
	@RequiresPermissions("schedule:update")
	@RequestMapping(value="stopSchedule",method = RequestMethod.GET)
	public @ResponseBody Result<String> stop(Integer id) throws Exception {
		ScheduleJobUtils.pauseJob(scheduler, id);
		Integer jobStatus= Trigger.TriggerState.PAUSED.ordinal();
		sysSchedulejobService.updateJobStatus(jobStatus, id);
		return new ResultBuilder<String>().data("").build();
	}

	//立刻执行一次
	@RequiresPermissions("schedule:update")
	@RequestMapping(value = "runOnce", method = RequestMethod.GET)
	public @ResponseBody Result<String> runOnce(Integer id) throws Exception {
		sysSchedulejobService.runJobOnce(id);
		return new ResultBuilder<String>().data("").build();
	}

}
