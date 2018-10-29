<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">

<mapper namespace="${package}.mapper.${ClassName}Mapper">

	<resultMap id="BaseResultMap" type="${package}.model.${ClassName}">
	<#if (columns?exists) && (columns?size>0)>
	<#list columns as column>
    	<#if column.columnName == 'id'>
			<id column="${column.columnName}" jdbcType="${column.myBatisDataType}" property="${column.attrName}" />
		<#else>
        	<result column="${column.columnName}" jdbcType="${column.myBatisDataType}" property="${column.attrName}" />
		</#if>
	</#list>
	</#if>
  	</resultMap>
  
  	<sql id="Base_Column_List">			
    <#if (columns?exists) && (columns?size>0)>
    	<#assign count = columns?size/>
		<#list columns as column>
		<#assign count = count - 1/>
		${column.columnName}<#if (count) gt 0>,</#if>
		</#list>
	</#if>
  	</sql>
  	
  	<sql id="Base_Column_List_Alias">			
    <#if (columns?exists) && (columns?size>0)>
    	<#assign count = columns?size/>
		<#list columns as column>
		<#assign count = count - 1/>
		${className}.${column.columnName}<#if (count) gt 0>,</#if>
		</#list>
	</#if>
  	</sql>
  
 	 <!-- 根据主键查询记录 -->
    <select id="selectByPrimaryKey" parameterType="java.lang.Integer" resultMap="BaseResultMap">
    	select 
    		<include refid="Base_Column_List" /> 
    	from 
    		${tableName}
    	where 
    		id = ${r"#{id, jdbcType=INTEGER}"}
  	</select>
  	
  	<!-- 
  		根据条件查询记录
  		TODO 此处条件将所有属性都作为条件进行了添加，需根据实际情况进行调整	
  	-->
  	<select id="selectByProperties" parameterType="${package}.model.${ClassName}" resultMap="BaseResultMap">
   		select 
   			<include refid="Base_Column_List_Alias" />	
   		from 
   			${tableName} ${className}
    	where 
    		1 = 1 and ${className}.deleted = 0
		<#if (columns?exists) && (columns?size>0)>
		<#list columns as column>
			<if test="${column.attrName} != null">
				<#if (column.attrType == 'String')>
				AND ${className}.${column.columnName} like CONCAT('%',${r"#{"}${column.attrName}${r"}"},'%')
				<#else>
				AND ${className}.${column.columnName} = ${r"#{"}${column.attrName}${r"}"}
				</#if>
			</if>
		</#list>
		</#if>
  	</select>
  
  	<!-- 
  		检查数据唯一性
  		TODO 此处条件固定写为根据name判断，需根据实际情况进行调整
  	-->
  	<select id="selectByUnique" parameterType="${package}.model.${ClassName}" resultMap="BaseResultMap">
    	select 
    		<include refid="Base_Column_List" />
		from 
			${tableName} ${className}
    	where 
    		1 = 1 and deleted = 0
    	<if test="name != null">
        	AND name = ${r"#{name}"}
    	</if>
  	</select>
  	
  	<!-- 删除数据，物理删除和逻辑删除  -->
  	<delete id="deleteByPrimaryKey" parameterType="java.lang.Integer">
	    delete from ${tableName} where id = ${r"#{id, jdbcType=INTEGER}"}
  	</delete>
  	
  	<update id="logicalDeleteByPrimaryKey" parameterType="java.lang.Integer">
	    update ${tableName} set deleted = 1 where id = ${r"#{id, jdbcType=INTEGER}"}
  	</update>
  
  	<!-- 保存数据  -->
  	<insert id="insert" parameterType="${package}.model.${ClassName}">
  		<selectKey keyProperty="id" order="AFTER" resultType="java.lang.Integer">
      		SELECT LAST_INSERT_ID()
    	</selectKey>
    	insert into ${tableName} (
    	<#if (columns?exists) && (columns?size>0)>
		<#assign count = columns?size/>
		<#list columns as column>
			<#assign count = count - 1/>
			${column.columnName}<#if (count) gt 0>,</#if>
		</#list>
		</#if>
		)
		values (
		<#if (columns?exists) && (columns?size>0)>
		<#assign count = columns?size/>
		<#list columns as column>
			<#assign count = count - 1/>
			${r"#{"}${column.attrName}${r", jdbcType="}${column.myBatisDataType}${r"}"}<#if (count) gt 0>,</#if>
		</#list>
		</#if>
		)
  	</insert>
  	
  	<insert id="insertSelective" parameterType="${package}.model.${ClassName}">
  		<selectKey keyProperty="id" order="AFTER" resultType="java.lang.Integer">
      		SELECT LAST_INSERT_ID()
    	</selectKey>
    	insert into ${tableName}
    	<trim prefix="(" suffix=")" suffixOverrides=",">
    		<#if (columns?exists) && (columns?size>0)>
				<#assign count = columns?size/>
				<#list columns as column>
					<#assign count = count - 1/>
					<if test="${column.attrName} != null">${column.columnName}, </if>
				</#list>
			</#if>
    	</trim>
    	<trim prefix="values (" suffix=")" suffixOverrides=",">
    		<#if (columns?exists) && (columns?size>0)>
				<#assign count = columns?size/>
				<#list columns as column>
					<#assign count = count - 1/>
					<if test="${column.attrName} != null">${r"#{"}${column.attrName}${r", jdbcType="}${column.myBatisDataType}${r"}"}, </if>
				</#list>
			</#if>
    	</trim>
  	</insert>
  	
  	<!-- 更新数据  -->
  	<update id="updateByPrimaryKeySelective" parameterType="${package}.model.${ClassName}">
    	update ${tableName}
		<set>
    <#if (columns?exists) && (columns?size>0)>
	<#assign count = columns?size/>
	<#list columns as column>
		<#assign count = count - 1/>
		<#if (column.attrName)?? && column.attrName != 'id'>
        	<if test="${column.attrName} != null">${column.columnName} = ${r"#{"}${column.attrName}${r", jdbcType="}${column.myBatisDataType}${r"}"}, </if>
		</#if>
	</#list>
	</#if>
	    </set>
    	where id = ${r"#{id, jdbcType=INTEGER}"}
 	</update>
 	
  	<update id="updateByPrimaryKey" parameterType="${package}.model.${ClassName}">
    	update ${tableName}
    	<set>
		<#if (columns?exists) && (columns?size>0)>
		<#assign count = columns?size/>
		<#list columns as column>
			<#assign count = count - 1/>
	    <#if (column.attrName)?? && column.attrName != 'id'>${column.columnName} = ${r"#{"}${column.attrName}${r", jdbcType="}${column.myBatisDataType}${r"}"}<#if (count) gt 0>,</#if></#if>
		</#list>
		</#if>
		</set>
    	where id = ${r"#{id, jdbcType=INTEGER}"}
  </update>

</mapper>
