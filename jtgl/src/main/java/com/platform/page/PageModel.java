package com.platform.page;

import java.io.Serializable;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonView;
import com.platform.model.JsonViewFilter;


/**
 * 分页基础类
 *
 * @param <T>
 */
public class PageModel<T> implements Serializable{

	private static final long serialVersionUID = -8566397778746220879L;

	private static final int DEFAULT_PAGE_INDEX = 1;
	
	private static final int DEFAULT_PAGE_SIZE = 10;

	@JsonView(JsonViewFilter.Base.class)
	private List<T> data;
	
	@JsonView(JsonViewFilter.Base.class)
	private Integer pageIndex = DEFAULT_PAGE_INDEX;

	@JsonView(JsonViewFilter.Base.class)
	private Integer pageSize = DEFAULT_PAGE_SIZE;

	@JsonView(JsonViewFilter.Base.class)
	private Long total;
	
	@JsonView(JsonViewFilter.Base.class)
	private Integer pageCount;

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

	public Integer getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(Integer pageIndex) {
		this.pageIndex = pageIndex;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Long getTotal() {
		return total;
	}

	public void setTotal(Long total) {
		this.total = total;
	}

	public Integer getPageCount() {
		return pageCount;
	}

	public void setPageCount(Integer pageCount) {
		this.pageCount = pageCount;
	}
}