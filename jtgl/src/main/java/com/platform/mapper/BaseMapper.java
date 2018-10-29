package com.platform.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BaseMapper<T>{
	
	List<T> selectByProperties(T record);

    List<T> selectByUnique(T record);

    List<T> selectByTree(T record);

    List<T> selectByIds(@Param("keyList") List<Integer> keyList);

    int logicalDeleteByPrimaryKey(Integer id);
    
	int deleteByPrimaryKey(Integer id);

    int insert(T record);

    int insertSelective(T record);

    T selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(T record);

    int updateByPrimaryKey(T record);
    
}
