package com.platform.service;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.platform.anotation.EntityAnotation;
import com.platform.mapper.BaseMapper;
import com.platform.model.BaseEntity;

/**
 * 
 * @author
 *
 * @param <T>
 */
public abstract class BaseService<D extends BaseMapper<T>, T extends BaseEntity<T>>{

	protected Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	protected D mapper;

	public D getMapper() {
		return mapper;
	}
	
	@Transactional(readOnly = true)
	public List<T> selectByProperties(T entity) {
		return mapper.selectByProperties(entity);
	}

	@Transactional(readOnly = true)
	public List<T> selectByUnique(T entity){
		return mapper.selectByUnique(entity);
	}
	
    @Transactional(readOnly = true)
    public List<T> selectByTree(T entity) {
        return mapper.selectByTree(entity);
    }

	@Transactional(readOnly = true)
	public T selectById(Integer key) {
		return mapper.selectByPrimaryKey(key);
	}

	public int save(T entity) {
		entity.preInsert();
		return mapper.insert(entity);
	}
	
	public int saveNotNull(T entity) {
		entity.preInsert();
		return mapper.insertSelective(entity);
	}

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public int delete(Integer key) {
		// 获取实体类的是否逻辑删除注解，如是逻辑删除，则调用logicalDeleteByPrimaryKey方法
		Type superType = getClass().getGenericSuperclass();
	    ParameterizedType parameterized = (ParameterizedType) superType;
	    // 数据访问Service实现BaseService时，在其类定义中声明了两个泛型类，第一个是Mapper，第二个是Entity
	    Type entityType = parameterized.getActualTypeArguments()[1];
	    Class entityClass = null;
		try {
			entityClass = Class.forName(entityType.getTypeName());
		} catch (ClassNotFoundException e) {
			logger.error(e.getMessage(), e);
		}
		boolean logicalDelete = false;
		try {
			logicalDelete = ((EntityAnotation)entityClass.getAnnotation(EntityAnotation.class)).logicalDelete();
		} catch (Exception e) {
		}
		if (logicalDelete) {
			return mapper.logicalDeleteByPrimaryKey(key);
		} else {
			return mapper.deleteByPrimaryKey(key);
		}
	}

	public int update(T entity) {
		entity.preUpdate();
		return mapper.updateByPrimaryKey(entity);
	}

	public int updateNotNull(T entity) {
		entity.preUpdate();
		return mapper.updateByPrimaryKeySelective(entity);
	}
	
	public void saveOrUpdate(T entity) {
		if (entity.getId()!=null&&entity.getId().intValue()!=0){
			entity.preInsert();
			mapper.insertSelective(entity);
		}else{
			entity.preUpdate();
			mapper.updateByPrimaryKeySelective(entity);
		}
	} 
}
