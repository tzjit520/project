package com.platform.jobs;

import org.springframework.stereotype.Service;

/**
 * 定期检测/修改用户状态
 */
@Service("userLockStatusCheck")
public class UserLockStatusCheck{

	/**
	 * 1、永久锁定长时间未登录的用户
	 * 2、递减短期锁定用户的锁定天数，若递减为0，则修改为未锁定
	 */
	public void check() {
		/**
		 * 永久锁定长时间未登录的用户
		 */
		// 查询系统参数表中配置的允许账户不活跃天数，超期将被永久锁定
		
		/**
		 * 处理临时锁定的用户：递减锁定天数，若递减为0，则修改为未锁定
		 */
	}
}
