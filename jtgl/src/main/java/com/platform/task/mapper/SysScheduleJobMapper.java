package com.platform.task.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.platform.mapper.BaseMapper;
import com.platform.task.model.SysScheduleJob;

public interface SysScheduleJobMapper extends BaseMapper<SysScheduleJob> {
    //修改任务状态
    int updateJobStatus(@Param("status")Integer status, @Param("id")long id);
    
    //查询状态正在运行的任务
    List<SysScheduleJob> selectRunTaskJob();
}
