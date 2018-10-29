package ${package}.model;

<#if (columns?exists) && (columns?size>0)>
<#list columns as column>
	<#if (column.default == "false")>
		<#if (column.attrType == "java.util.Date")>
import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
		</#if>
	</#if>
</#list>
</#if>
import com.platform.anotation.EntityAnotation;
import com.platform.model.BaseEntity;

// 默认为逻辑删除
@SuppressWarnings("serial")
@EntityAnotation(logicalDelete = true)
public class ${ClassName} extends BaseEntity<${ClassName}> {

<#if (columns?exists) && (columns?size>0)>
<#list columns as column>
	<#if (column.default == "false")>
		<#if (column.attrType == "java.util.Date")>
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	@JsonFormat(pattern = "yyyy-MM-dd")
		</#if>
	private ${column.attrType} ${column.attrName}; // ${column.comment}
	</#if>
</#list>

<#list columns as column>
	<#if (column.default == "false")>
	public ${column.attrType} get${column.AttrName}() {
		return ${column.attrName};
	}
	
	public void set${column.AttrName}(${column.attrType} ${column.attrName}) {
		this.${column.attrName} = ${column.attrName};
	}
	
	</#if>
</#list>
</#if>
}
