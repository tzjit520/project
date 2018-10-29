package com.platform.anotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Retention(RetentionPolicy.RUNTIME)  
@Target(ElementType.TYPE) 
public @interface EntityAnotation {
	
	/**
	 * 是否逻辑删除，默认为false
	 * @return true表示逻辑删除，false表示物理删除
	 */
	boolean logicalDelete() default false;  
}
