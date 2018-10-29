package com.platform.system.session.controller;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.platform.common.constants.SessionConstants;
import com.platform.controller.BaseController;
import com.platform.model.Result;
import com.platform.model.ResultBuilder;
import com.platform.system.session.service.SessionService;

/**
 * 用户会话管理
 */
@Controller
@RequestMapping("/api/v1/session")
public class SessionController extends BaseController {
	
	@Autowired
	private SessionService serssionService;
	
	/**
	 * 按条件查询
	 */
	@RequiresPermissions("session:view")
	@RequestMapping(method = RequestMethod.GET)
	public String list(Integer offset, Integer limit, String sort, String keyword, Model model) throws Exception {

		// 获取符合查询条件的、活动的sessions
		List<Map<String, Object>> resultList = serssionService.getActiveSessions(keyword);
		model.addAttribute("resultList", resultList);
		return "platform/session/list";
	}

	/**
	 * 踢出指定用户
	 */
	@RequiresPermissions("session:delete")
	@RequestMapping(method = RequestMethod.DELETE)
	public @ResponseBody Result<String> forceLogout(@RequestParam String ids) {
		if (ids != null) {
			String[] idArray = ids.trim().split(",");
			for (int i=0; i<idArray.length; i++) {
				String sessionId = idArray[i];
				Session session = sessionDAO.readSession(sessionId);
				if (session != null) {
					// 该方式直接删除用户session且不提示用户是被强制下线
					// sessionDAO.delete(session);
					// 采用以下方式可以实现对用户进行提示，需要【com.platform.shiro.ForceLogoutFilter】配合实现
					session.setAttribute(SessionConstants.SESSION_FORCE_LOGOUT_KEY, Boolean.TRUE);
				}
			}
		}
		return new ResultBuilder<String>().data("").build();
	}
}
