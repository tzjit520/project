/**
 * <p>Title: ModelStatusEnum.java<／p>
 * <p>Description: <／p>
 * <p>Copyright: Copyright (c) 2015<／p>
 * <p>Company: 沪江网<／p>
 * @author xieming
 * @date 2015年8月31日
 * @version 1.0
 */
package com.platform.common.enums;

public enum ModelStatusEnum {

	ACTIVE(true),DELETE(false);
	
	private boolean status;

	ModelStatusEnum(boolean status){
		this.status = status;
	}

	/**
	 * @return the status
	 */
	public boolean getStatus() {
		return status;
	}

}
