package com.platform.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import com.common.StatusCode;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.platform.page.PageSearchModel;
import com.platform.system.user.model.SysUser;
import com.platform.utils.UserUtils;

/**
 * 数据Entity
 */
public abstract class BaseEntity<T> extends PageSearchModel {

	private static final long serialVersionUID = -6976354975455184339L;
	//主键
	protected Integer id; 				
	//备注
	//@Length(min = 0, max = 500)
	protected String remark; 		
	//创建人
	protected Integer createBy; 		
	//创建日期
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	protected Date createDate; 		
	//更新人
	protected Integer updateBy; 		
	//更新日期
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	protected Date updateDate;
	//状态，1表示启用，0表示停用
	protected Integer status; 		
	//是否删除标记，0表示正常，1表示已删除
	private Integer deleted; 		
	//查询开始日期
	private String queryBeginDate; 	
	//查询结束日期
	private String queryEndDate; 	
	//分组
	private String groupBy;
	
	// 用于批量删除参数
	protected String ids;
	
	/**
	 * 插入之前执行方法，需要手动调用 	 
	 */
	public void preInsert() {
		
		try {
			SysUser user = UserUtils.getUser();
			if (user != null) {
				this.updateBy = user.getId();
				this.createBy = user.getId();
			}
		} catch (Exception e) {

		}
		this.updateDate = new Date();
		this.createDate = this.updateDate;
		if (this.status == null) {
			this.status = StatusCode.COMMON_STATUS_ACTIVE;
		}
		if (this.deleted == null) {
			this.deleted = StatusCode.COMMON_DELETE_NORMAL;
		}
	}

	/**
	 * 更新之前执行方法，需要手动调调用 
	 */
	public void preUpdate() {
		try {
			SysUser user = UserUtils.getUser();
			if (user != null) {
				this.updateBy = user.getId();
			}
		} catch (Exception e) {

		}
		this.updateDate = new Date();
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getCreateBy() {
		return createBy;
	}

	public void setCreateBy(Integer createBy) {
		this.createBy = createBy;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Integer getUpdateBy() {
		return updateBy;
	}

	public void setUpdateBy(Integer updateBy) {
		this.updateBy = updateBy;
	}

	public Date getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getDeleted() {
		return deleted;
	}

	public void setDeleted(Integer deleted) {
		this.deleted = deleted;
	}

	public String getQueryBeginDate() {
		return queryBeginDate;
	}

	public void setQueryBeginDate(String queryBeginDate) {
		this.queryBeginDate = queryBeginDate;
	}

	public String getQueryEndDate() {
		return queryEndDate;
	}

	public void setQueryEndDate(String queryEndDate) {
		/*if(StringUtil.isNotEmpty(queryEndDate)){
			//精确查询结束时间
			if(queryEndDate.indexOf("23:59:59") < 0){
				queryEndDate += " 23:59:59";
			}
			this.queryEndDate = queryEndDate;
		}*/
		this.queryEndDate = queryEndDate;
	}

	public String getGroupBy() {
		return groupBy;
	}

	public void setGroupBy(String groupBy) {
		this.groupBy = groupBy;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

}
