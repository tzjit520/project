package com.platform.page;

import java.beans.Transient;
import java.io.Serializable;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * 分页查询基础类
 *
 */
public class PageSearchModel implements Serializable {

	private static final long serialVersionUID = 2728283541336158590L;

	private static final int DEFAULT_PAGE_INDEX = 1;

	private static final int DEFAULT_PAGE_SIZE = 10;

	private Integer pageIndex = DEFAULT_PAGE_INDEX;

	private Integer pageSize = DEFAULT_PAGE_SIZE;

	private String orderBy;

	@Transient
	@JsonIgnore
	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	@Transient
	@JsonIgnore
	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	@Transient
	@JsonIgnore
	public String getOrderBy() {
		String ret = orderBy;
		if (ret != null) {
			ret = ret.replace("updateDate", "update_date");
			ret = ret.replace("updateUser", "update_user");
			ret = ret.replace("createDate", "create_date");
			ret = ret.replace("createUser", "create_user");
			ret = ret.replace("orderNo", "order_no");
		}
		return ret;
	}

	public void setOrderBy(String orderBy) {
		this.orderBy = orderBy;
	}
	/**
	 * 计算分页总数?
	 * @param total  
	 * @return
	 */
	@Transient
	@JsonIgnore
	public int getPageCount(int total) {
		if (total <= 0) {
			return 0;
		}
		int count = 0;
		if (total % pageSize == 0) {
			count = total / pageSize;
		} else {
			count = total / pageSize + 1;
		}

		return count;
	}
}