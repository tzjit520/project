package com.jtgl.mail.service;

import java.util.Date;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.jtgl.mail.mapper.MailMapper;
import com.jtgl.mail.model.Mail;
import com.jtgl.person.model.Person;
import com.jtgl.person.service.PersonService;
import com.platform.page.PageModel;
import com.platform.service.BaseService;
import com.platform.system.user.model.SysUser;
import com.platform.utils.UserUtils;
import com.platform.utils.email.MailUtils;


@Service
public class MailService extends BaseService<MailMapper, Mail> {

	protected Logger logger = LoggerFactory.getLogger(getClass());
		
	@Autowired
	private PersonService personService;
	
	@Transactional(readOnly = true)
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public PageModel<Mail> selectByPage(Mail vo) {
		PageHelper.startPage(vo.getPageIndex(), vo.getPageSize(),vo.getOrderBy());
		List<Mail> results = this.selectByProperties(vo);

		PageModel<Mail> page = new PageModel<Mail>();
		Page pageList = (Page) results;
		page.setPageIndex(pageList.getPageNum());
		page.setPageSize(pageList.getPageSize());
		page.setTotal(pageList.getTotal());
		page.setData(pageList.getResult());
		page.setPageCount(pageList.getPages());
		return page;
	}
	
	/**
	 * 发送邮箱
	 */
	@Transactional
	public void saveEmail(Mail mail){
		//发送人
		SysUser user = UserUtils.getUser();
		mail.setFromUserId(user.getId());
		mail.setEmailType(2);//已发送
		mail.setMark(0);//0普通邮箱，1星标邮箱
		//保存邮件
		super.save(mail);
		//根据选中的用户Ids查询用户信息
		Person person = new Person();
		person.setIds(mail.getToUserId());
		List<Person> listpPerson = personService.selectByProperties(person);
		for (Person p : listpPerson) {
			Mail mail_ = new Mail();
			mail_.setFromUserId(user.getId());//发件人
			mail_.setTitle(mail.getTitle());//主题
			mail_.setContent(mail.getContent());//内容
			mail_.setToUserId(p.getId()+"");//收件人
			mail_.setEmailType(1);//收件箱
			int sendStatus = 0;//发送状态。0失败，1成功
			String remark = "";//描述
			//获取邮箱
			String emailTo = p.getMail();
			if(StringUtils.isNotEmpty(emailTo)){
				//验证邮箱
				String check = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
				Pattern regex = Pattern.compile(check);
				Matcher matcher = regex.matcher(emailTo);
				//合法邮箱
				if(matcher.matches()){
					//发送邮件
					boolean bool = MailUtils.sendEmail(emailTo, mail.getTitle(), mail.getContentHtml());
					if(bool){//发送成功
						mail_.setSendTime(new Date());
						remark = "邮箱发送成功!";
						sendStatus = 1;// 发送状态
					}else{
						remark = "调用sendEmail失败!";
					}
				}else{
					remark = "不是合法的邮箱!";
				}
			}else {
				remark = "邮箱为空!";
			}
			mail_.setSendStatus(sendStatus);//发送状态。0失败，1成功
			mail_.setIsRead(0);//读取状态。0未读，1已读
			mail_.setMark(0);//0普通邮箱，1星标邮箱
			mail_.setRemark(remark);
			//保存邮件
			super.save(mail_);
		}
	}
}
