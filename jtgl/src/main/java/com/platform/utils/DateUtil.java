package com.platform.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang3.time.DateFormatUtils;

/**
 * 日期工具类
 */
public class DateUtil {

	private final SimpleDateFormat format;

	public DateUtil(SimpleDateFormat format) {
		this.format = format;
	}

	public SimpleDateFormat getFormat() {
		return format;
	}

	// 紧凑型日期格式，也就是纯数字类型yyyyMMdd
	public static final DateUtil COMPAT = new DateUtil(new SimpleDateFormat("yyyyMMdd"));

	// 常用日期格式，yyyy-MM-dd
	public static final DateUtil COMMON = new DateUtil(new SimpleDateFormat("yyyy-MM-dd"));
	public static final DateUtil MONTH = new DateUtil(new SimpleDateFormat("yyyy-MM-dd"));
	public static final DateUtil COMMON_FULL = new DateUtil(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
	public static final DateUtil COMMON_MIN = new DateUtil(new SimpleDateFormat("yyyy-MM-dd HH:mm"));

	// 使用斜线分隔的，西方多采用，yyyy/MM/dd
	public static final DateUtil SLASH = new DateUtil(new SimpleDateFormat("yyyy/MM/dd"));

	// 中文日期格式常用，yyyy年MM月dd日
	public static final DateUtil CHINESE = new DateUtil(new SimpleDateFormat("yyyy年MM月dd日"));
	public static final DateUtil CHINESE_FULL = new DateUtil(new SimpleDateFormat("yyyy年MM月dd日 HH时mm分ss秒"));

	/**
	 * 日期获取字符串
	 */
	public String getDateText(Date date) {
		return getFormat().format(date);
	}

	/**
	 * 字符串获取日期
	 *
	 * @throws ParseException
	 */
	public Date getTextDate(String text) throws ParseException {
		return getFormat().parse(text);
	}

	/**
	 * 日期获取字符串
	 */
	public static String getDateText(Date date, String format) {
		return new SimpleDateFormat(format).format(date);
	}

	/**
	 * 字符串获取日期
	 *
	 * @throws ParseException
	 */
	public static Date getTextDate(String dateText, String format) throws ParseException {
		return new SimpleDateFormat(format).parse(dateText);
	}

	/**
	 * 根据日期，返回其星期数，周一为1，周日为7
	 *
	 * @param date
	 * @return
	 */
	public static int getWeekDay(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int w = calendar.get(Calendar.DAY_OF_WEEK);
		int ret;
		if (w == Calendar.SUNDAY)
			ret = 7;
		else
			ret = w - 1;
		return ret;
	}
	
	/**
	 * 得到当前日期字符串 格式（yyyy-MM-dd） pattern可以为："yyyy-MM-dd" "HH:mm:ss" "E"
	 */
	public static String getDate(String pattern) {
		return DateFormatUtils.format(new Date(), pattern);
	}
	
	/**
	 * 设置指定日期的小时和分钟的值
	 * @param date 需要设置的日期对象
	 * @param hour 小时
	 * @param second  分钟
	 * @return
	 */
	public static Date setHourAndSecond(Date date,int hour,int second){
		Calendar beginCal2 = Calendar.getInstance();
		beginCal2.setTime(date);
		beginCal2.set(Calendar.HOUR_OF_DAY, hour);
		beginCal2.set(Calendar.SECOND, second);
		return beginCal2.getTime();
	}

	public static String getFormatMonth(int month) {
		return month < 10 ? "0" + month : String.valueOf(month);
	}

	public static Calendar getLastYearByCalendar(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH, month - 1);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		calendar.add(Calendar.YEAR, -1);
		return calendar;
	}

	public static Calendar getLastMonthByCalendar(int year, int month) {
		Calendar calendar = Calendar.getInstance();
		calendar.clear();
		calendar.set(Calendar.YEAR, year);
		calendar.set(Calendar.MONTH, month - 1);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		calendar.add(Calendar.MONTH, -1);
		return calendar;
	}
	
	/**
	 * 验证时间字符串格式数据是否准确
	 * @param date
	 * @return
	 */
	public static boolean isDate(String date)    
    {    
        /**  
         * 判断日期格式和范围  
         */    
        String rexp = "^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))";    
            
        Pattern pat = Pattern.compile(rexp);      
            
        Matcher mat = pat.matcher(date);      
            
        boolean dateType = mat.matches();    

        return dateType;    
    } 

	public static Date parseStringToDate(String value, String pattern) {
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		try {
			return format.parse(value);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}

	public static String formatDateToString(Date value, String pattern) {
		SimpleDateFormat format = new SimpleDateFormat(pattern);
		return format.format(value);
	}

	/**
	 * 计算两个日期之间相差的天数
	 *
	 * @param smdate
	 *            较小的时间
	 * @param bdate
	 *            较大的时间
	 * @return 相差天数
	 * @throws ParseException
	 */
	public static int daysBetween(Date smdate, Date bdate) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		smdate = sdf.parse(sdf.format(smdate));
		bdate = sdf.parse(sdf.format(bdate));
		Calendar cal = Calendar.getInstance();
		cal.setTime(smdate);
		long time1 = cal.getTimeInMillis();
		cal.setTime(bdate);
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 3600 * 24);

		return Integer.parseInt(String.valueOf(between_days));
	}

	/**
	 * 判断某一时间是否在一个区间内
	 * 
	 * @param sourceTime
	 *            时间区间,半闭合,如[10:00-20:00)
	 * @param curTime
	 *            需要判断的时间 如10:00
	 * @return 
	 * @throws IllegalArgumentException
	 */
	public static boolean isInTime(String sourceTime, String curTime) {
	    if (sourceTime == null || !sourceTime.contains("-") || !sourceTime.contains(":")) {
	        throw new IllegalArgumentException("Illegal Argument arg:" + sourceTime);
	    }
	    if (curTime == null || !curTime.contains(":")) {
	        throw new IllegalArgumentException("Illegal Argument arg:" + curTime);
	    }
	    String[] args = sourceTime.split("-");
	    SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
	    try {
	        long now = sdf.parse(curTime).getTime();
	        long start = sdf.parse(args[0]).getTime();
	        long end = sdf.parse(args[1]).getTime();
	        if (args[1].equals("00:00")) {
	            args[1] = "24:00";
	        }
	        if (end < start) {
	            if (now >= end && now < start) {
	                return false;
	            } else {
	                return true;
	            }
	        } 
	        else {
	            if (now >= start && now < end) {
	                return true;
	            } else {
	                return false;
	            }
	        }
	    } catch (ParseException e) {
	        e.printStackTrace();
	        throw new IllegalArgumentException("Illegal Argument arg:" + sourceTime);
	    }
	 
	}
}
