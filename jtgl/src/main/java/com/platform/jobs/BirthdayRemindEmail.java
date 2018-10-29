package com.platform.jobs;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.common.collect.Lists;
import com.jtgl.person.model.Person;
import com.jtgl.person.service.PersonService;
import com.platform.utils.LunarCalendar;
import com.platform.utils.SpringUtil;
import com.platform.utils.email.MailUtils;

/**
 * 人员生日提醒
 */
public class BirthdayRemindEmail {

    private final Logger logger = LoggerFactory.getLogger(getClass());

    /**
     * 定时发生日提醒邮件
     */
    public void sendBirthEmail() {
    	try {
    		PersonService personService = (PersonService) SpringUtil.getBean("personService");

    		String mailTitle = "家庭成员生日提醒"; // 邮箱标题
    		// 查询所有的人员信息
    		List<Person> listPerson = personService.selectByProperties(new Person());
    		// 获取今天生日的人员信息
    		List<BirthPerson> brithList = getBrithList(listPerson);
    		//发送的邮件内容
    		String sendEmailTemplate = sendEmailTemplate(brithList);
     		if(brithList != null && brithList.size() > 0){
 				//给所有有邮箱的人发送生日提醒邮件
 				List<String> emails = getEmails(listPerson);
 				for (String emailTo : emails) {
 					String remark = "发送成功";//描述
 					//发送邮件
 					boolean bool = MailUtils.sendEmail(emailTo, mailTitle, sendEmailTemplate);
 					if(!bool){//发送失败
 						remark = "发送失败";
 					}
 					System.out.println(remark);;
 				}
 			}
		} catch (Exception e) {
			logger.error("定时器更新年龄报错："+e.getMessage());
		}
    }

    /**
     * 邮件模板
     */
    public String sendEmailTemplate(List<BirthPerson> brithList) {
    	
		//邮箱内容(可拼接HTML标签)
		StringBuilder contentHtml = new StringBuilder();
		String name = "", phone = "", time = "";
		
 		for (BirthPerson birthPerson : brithList) {
 			String pName = birthPerson.getName();
 			String pPhone = birthPerson.getPhone();
 			String pBrith = birthPerson.getBrithDay();
 			
				if(StringUtils.isBlank(name)){
					name = pName;
				}else{
					name = "/"+pName;
				}
				if(StringUtils.isBlank(phone)){
					if(StringUtils.isBlank(pPhone)) {
						pPhone = "暂无";
					}
					phone = pPhone+"("+pName+")";
				}else{
					phone = "/"+pPhone+"("+pName+")";
				}
				if(StringUtils.isBlank(time)){
					time = pBrith+"("+pName+")";
				}else{
					time = "/"+pBrith+"("+pName+")";
				}
		}
 		//将所有明天生日的人员信息进行合并
 		contentHtml.append("<h2><strong>家庭成员【").append(name).append("】</strong>今天生日了</h2>")
     		.append("<h3>电话: ").append(phone).append("</h3>")
     		.append("<h3>生日: ").append(time).append("</h3>")
     		/*.append("<h2>祝福语: ").append("").append("</h2>")*/
     		.append("<h3>祝: 【").append(name).append("】生日快乐").append("</h3>")
     		.append("<h3>收到邮件赶紧去祝福一下吧</h3>")
     		.append("<p><span style='font-size: 12px;'>")
     		.append("此邮件来自家庭管理系统")
     		.append("</span></p>");
 		
    	return contentHtml.toString();
    }
    
    /**
     * 获取今天生日的人员信息
     */
    public List<BirthPerson> getBrithList(List<Person> listPerson) throws ParseException{
    	
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	List<BirthPerson> list = new ArrayList<BirthPerson>();
    	// 存今天
        Calendar cToday = Calendar.getInstance(); 
        // 获取当前时间对应的农历日期
        LunarCalendar lunar = new LunarCalendar(cToday);
        cToday.setTime(sdf.parse(lunar.result())); // 当前时间农历日期
        String nlDate = sdf.format(cToday.getTime());
        //System.out.println("当前农历时间:"+ nlDate);
        
    	for (Person person : listPerson) {
			
			if(person.getBirthday() == null){
				continue;
			}
			// 存生日
	        Calendar cBirth = Calendar.getInstance(); 
	        cBirth.setTime(person.getBirthday()); // 设置生日
	        cBirth.set(Calendar.YEAR, cToday.get(Calendar.YEAR)); // 修改为本年
			int days; 
	        if (cBirth.get(Calendar.DAY_OF_YEAR) < cToday.get(Calendar.DAY_OF_YEAR)) {
	            // 生日已经过了，要算明年的了
	            days = cToday.getActualMaximum(Calendar.DAY_OF_YEAR) - cToday.get(Calendar.DAY_OF_YEAR);
	            days += cBirth.get(Calendar.DAY_OF_YEAR);
	        } else {
	            // 生日还没过
	            days = cBirth.get(Calendar.DAY_OF_YEAR) - cToday.get(Calendar.DAY_OF_YEAR);
	        }
	        // 输出结果
	        if (days == 0) { // 今天生日
	        	BirthPerson bp = new BirthPerson();
	        	bp.setName(person.getName());
	        	bp.setAge(person.getAge());
	        	bp.setPhone(person.getPhone());
	        	bp.setNlDate(nlDate);
	        	//生日的月份
		        int month = cBirth.get(Calendar.MONTH)+1;
		        //生日日期
		        int day = cBirth.get(Calendar.DATE);
		        String time = (month < 10 ? "0"+month : String.valueOf(month)) +"月"+ (day < 10 ? "0"+day : String.valueOf(day)) +"日";
	        	bp.setBrithDay(time);
	        	//根据出生日期  计算年龄
	        	BirthPerson bp1 = getAge(cBirth);
	        	bp.setXsAge(bp1.getXsAge());
	        	bp.setZsAge(bp1.getZsAge());
	        	bp.setDays(bp1.getDays());
	        	bp.setBlessings(getBlessings(bp1.getXsAge()));//祝福语
	        	list.add(bp);
	        } else {
	        	//System.out.println(person.getName()+"距离生日还有:" + days + "天");
	        }
		}
    	return list;
    }
    
    /**
	 * 根据出生日期  计算年龄
	 * @param cBirth 出生日期  为农历    这里都是按照农历日期计算的
	 */
    public BirthPerson getAge(Calendar cBirth) throws ParseException{
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		// 当前时间
        Calendar cToday = Calendar.getInstance(); 
        // 获取当前时间对应的农历日期
        LunarCalendar lunar = new LunarCalendar(cToday);
        cToday.setTime(sdf.parse(lunar.result())); // 当前时间农历日期
        
	    //获取当前的年份
	    int currentYear = cToday.get(Calendar.YEAR);
	    //获取当前的月份(从0开始, 实际显示要加一)  
	    int currentMonth = cToday.get(Calendar.MONTH)+1;  
	    //获取当前的日
	    int currentDay = cToday.get(Calendar.DATE);  
	    
	    //获取出生的年份
	    int brithYear = cBirth.get(Calendar.YEAR);
	    //获取出生的月份(从0开始, 实际显示要加一)  
	    int brithMonth = cBirth.get(Calendar.MONTH)+1;  
	    //获取出生的日
	    int brithDay = cBirth.get(Calendar.DATE);  
	    int xsAge = 0; //虚岁年龄
	    int zsAge = 0; //周岁年龄
	    if(currentYear - brithYear > 0){
	    	//这是虚岁
	    	xsAge = currentYear - brithYear;
	    	//这是周岁
	    	zsAge = (currentYear - brithYear)-1;
	    	//当前月份大于出生的月份   说明已经过了生日了    才加一岁
		    if(currentMonth > brithMonth){
		    	xsAge += 1;
		    	zsAge += 1;
		    }else if(currentMonth == brithMonth){//当前月份等于出生的月份   说明是在本月生日    
		    	//判断当日是否大于出生日    如果大于或等于出生日   则岁数+1
		    	if(currentDay >= brithDay){
		    		xsAge += 1;
			    	zsAge += 1;
		    	}
		    }
	    }
	    
	    //从出生到现在有多少天
	    Long currentTime = cToday.getTimeInMillis();
	    Long brithTime = cBirth.getTimeInMillis();
	    //获取天数
	    Long day = (currentTime - brithTime)/1000/60/60/24;
	    BirthPerson bp = new BirthPerson();
	    bp.setXsAge(xsAge);//虚岁年龄
    	bp.setZsAge(zsAge);//周岁年龄
    	bp.setDays(day);//天数
	    return bp;
    }
    
    /**
     * 获取邮箱
     */
    public List<String> getEmails(List<Person> listPerson){
    	
    	List<String> listEmai = Lists.newArrayList();
    	for (Person person : listPerson) {
    		String emailTo = person.getMail();
    		if(StringUtils.isBlank(emailTo)){
				continue;
			}
    		//验证邮箱
			String check = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
			Pattern regex = Pattern.compile(check);
			Matcher matcher = regex.matcher(emailTo);
			//合法邮箱
			if(matcher.matches()){
				listEmai.add(emailTo);
			}
		}
    	return listEmai;
    }
    
    /**
     * 根据年龄获取祝福语
     * @param age
     */
    public String getBlessings(int age){
    	String blessings;
    	if(age == 1){
    		blessings = "时光荏苒，岁月穿梭，过去的一年是平凡的一年，和平的一年; 而这一年，对你的父母来说却是最不同寻常的一年。因为他们在过去的一年中收获了人生最为宝贵的果实。";
    	}else if(age > 1 && age <= 10){
    		blessings = "可爱的宝宝，愿你一直幸福的成长。";
    	}else if(age > 10 && age <= 14){
    		blessings = "如果是一棵树，"+age+"年它会长成栋梁；如果是一棵草，它已枯萎"+age+" 次；而你是一朵明天的花，"+age+"年正是你含苞最美的时候！";
    	}else if(age > 14 && age <= 16){
    		blessings = age+"岁的花，开满大地； "+age+"岁的歌，委婉动听。每个人都有"+age+"岁，愿你在"+age+"岁的生日的清晨，迈开你的强健的步伐，走向未来！";
    	}else if(age > 16 && age <= 17){
    		blessings = age+"岁，令人炫目的年华，我们告别幼稚，但求纯真不要随之而逝。愿 "+age+"岁的青春，能绘出一幅多彩的油画！";
    	}else if(age == 18){
    		blessings = "18岁，花一般的年龄，梦一样的岁月，愿你好好地把握，好好地珍惜，给自己创造一个无悔的青春，给祖国添一份迷人的春色。友情已化成音符，在今天这个特殊的日子里为你奏响。";
    	}else if(age > 18 && age <= 29){
    		blessings = "春的沟痕蜿蜒在二十岁的土地上，梦的翅膀翱翔在蓝色的天空中，那是一片圣洁的天空，不会飘过一屡烟尘，那是一幅永远年轻壮丽的风景，不会苍老衰败，永远精彩！";
    	}else if(age > 29 && age <= 39){
    		blessings = "在你"+age+"岁生日来临之即，祝事业正当午，身体壮如虎，金钱不胜数，干活不辛苦，悠闲像老鼠，浪漫似乐谱，快乐非你莫属！ ";
    	}else if(age > 39 && age <= 49){
    		blessings = "愿你一直身体好，永远青春不变老，四十岁的年龄，三十岁的心脏，二十岁的形象，十八的心态，永葆青春花期长 ！";
    	}else if(age > 49 && age <= 59){
    		blessings = "正当事业家庭蒸蒸日上，你跨过了不惑之年，从此后，新的天地将会更加美好！";
    	}else if(age > 59 && age <= 69){
    		blessings = "轻松弹指一挥间 ，清晨郊野吸新气，良夜书房读古篇，室内栽花花吐秀，阳台种草草生烟，莫言须发如霜雪，再活人生几十年。";
    	}else if(age > 69 && age <= 79){
    		blessings = "龙耀七旬新纪跨，寿山诗海任飞腾。 龙年贺祖龙，寿比泰山松。 李桃枝叶茂，诗坛不老翁。 七十阳春岂等闲，几多辛苦化甘甜。 曾经沧海横流渡，亦赖家庭内助贤。 连日凝神新墨劲，五更着意旧诗鲜。 如今但祝朝朝舞。";
    	}else if(age > 79 && age <= 89){
    		blessings = "人说七十古来稀。您老八十春常在。岁月老去您的容颜。时光永恒着您的诗心。";
    	}else if(age > 89){
    		blessings = "满脸皱纹，双手粗茧，岁月记载着您的辛劳，人们想念着您的善良；在这个特殊的日子里，祝您福同海阔、寿比南山，愿健康与快乐永远伴随着您！";
    	}else{
    		blessings = "";
    	}
    	return blessings;
    }
    
    public static void main(String[] args) throws ParseException {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	/*DAY_OF_MONTH 当月的第几天，从1开始
    	DAY_OF_WEEK 返回周几 ，返回只是Calendar定义的 SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY.
    	DAY_OF_YEAR 当年的第几天，从1开始*/
        // 存今天
        Calendar cToday = Calendar.getInstance(); 
        cToday.setTime(sdf.parse("2018-05-17")); // 设置生日
        // 获取当前时间对应的农历日期
        LunarCalendar lunar = new LunarCalendar(cToday);
        cToday.setTime(sdf.parse(lunar.result())); // 当前时间农历日期
        System.out.println("当前农历时间:"+ sdf.format(cToday.getTime()));
        
        // 生日日期
        String brithDay = "1992-04-04";
        // 存生日
        Calendar cBirth = Calendar.getInstance(); 
        cBirth.setTime(sdf.parse(brithDay)); // 设置生日
        cBirth.set(Calendar.YEAR, cToday.get(Calendar.YEAR)); // 修改为本年
        
        //生日的月份
        int month = cBirth.get(Calendar.MONTH)+1;
        //生日日期
        int day = cBirth.get(Calendar.DATE);
        String time = (month < 10 ? "0"+month : String.valueOf(month)) +"月"+ (day < 10 ? "0"+day : String.valueOf(day)) +"日";
        System.out.println("生日:"+time);
        
        int days; 
        if (cBirth.get(Calendar.DAY_OF_YEAR) < cToday.get(Calendar.DAY_OF_YEAR)) {
            // 生日已经过了，要算明年的了
            days = cToday.getActualMaximum(Calendar.DAY_OF_YEAR) - cToday.get(Calendar.DAY_OF_YEAR);
            days += cBirth.get(Calendar.DAY_OF_YEAR);
        } else {
            // 生日还没过
            days = cBirth.get(Calendar.DAY_OF_YEAR) - cToday.get(Calendar.DAY_OF_YEAR);
        }
        // 输出结果
        if (days == 0) {
            System.out.println("今天生日");
        }else if (days == 1) {
            System.out.println("明天生日啦");
        }else {
            System.out.println("距离生日还有:" + days + "天");
        }
	}
    
}
