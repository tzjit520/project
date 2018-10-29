package com.platform.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.lang3.StringUtils;

public class PlatFormDateUtil {
	
	private static final SimpleDateFormat monthFormat = new SimpleDateFormat("yyyy-MM");
	private static final SimpleDateFormat dayFormat = new SimpleDateFormat("yyyy-MM-dd");
		
	/**
	 * 将月份的字符串表示格式化为日期
	 * @param date 格式为yyyy-MM
	 * @return
	 */
	public static String formatDate(Date date, String format) {
		if(date==null){
			return "";
		}
		SimpleDateFormat format1 = new SimpleDateFormat(format);
		return format1.format(date);
	}
	
	/**
	 * 解析字符串日期为日期对象
	 * @param date
	 * @param format
	 * @return
	 * @throws ParseException
	 */
	public static Date formatDate(String date, String format) throws ParseException {
		if(StringUtils.isNotBlank(date)){
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			Date d = sdf.parse(date);
			return d;
		}else{
			return null;
		}
		
	}
	
	/**
	 * 将月份的字符串表示格式化为日期
	 * @param date 格式为yyyy-MM
	 * @return
	 */
	public static Date parseMonthToDate(String date) {
		try {
			return monthFormat.parse(date);
		} catch (ParseException e) {
			return null;
		}

	}
	
	/**
	 * 将日期的字符串表示格式化为日期
	 * @param date 格式为yyyy-MM-dd
	 * @return
	 */
	public static Date parseDayToDate(String date) {
		try {
			return dayFormat.parse(date);
		} catch (ParseException e) {
			return null;
		}

	}

	/**
	 * 前一天
	 * 
	 * @return
	 */
	public static Date getPreDate() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.DAY_OF_MONTH, -1);
		return cal.getTime();
	}

	/**
	 * 上个月
	 * 
	 * @return
	 */
	public static Date getPreMonth() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.MONTH, -1);
		return cal.getTime();
	}

	/**
	 * 上个月的一号
	 * 
	 * @return
	 */
	public static Date getPreMonthFirstDay() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.add(Calendar.MONTH, -1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);

		return cal.getTime();
	}

	/**
	 * 选择月的下个月的一号
	 * 
	 * @return
	 */
	public static Date getNextMonthFirstDay(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		cal.add(Calendar.MONTH, 1);
		cal.set(Calendar.DAY_OF_MONTH, 1);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);

		return cal.getTime();
	}
	/**
	 * 这个月的一号
	 * 
	 * @return
	 */
	public static Date getCurrentMonthFirstDay() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.set(Calendar.DAY_OF_MONTH, 1);
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);

		return cal.getTime();
	}

	/**
	 * 当前时间
	 * 
	 * @return
	 */
	public static Date getCurrentDate() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		cal.set(Calendar.HOUR_OF_DAY, 0);
		cal.set(Calendar.MINUTE, 0);
		cal.set(Calendar.SECOND, 0);
		cal.set(Calendar.MILLISECOND, 0);
		return cal.getTime();
	}
	
	/**
	 * 计算两个日期间隔的小时数
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public static double calculateIntervalOfHour(Date beginDate, Date endDate){
		long t1 = beginDate.getTime();
		long t2 = endDate.getTime();
		return Arith.round(Math.abs(t2 - t1)/1000/3600d, 2);
	}
	
	/**
	 * 计算两个日期间隔的天数，[]，两头都包括
	 * @param beginDate
	 * @param endDate
	 * @return
	 */
	public static int calculateIntervalOfDay(Date beginDate, Date endDate){
		Calendar beginCal = Calendar.getInstance();
		beginCal.setTime(beginDate);
		beginCal.set(Calendar.HOUR_OF_DAY, 0);
		beginCal.set(Calendar.MINUTE, 0);
		beginCal.set(Calendar.SECOND, 0);
		beginCal.set(Calendar.MILLISECOND, 0);
		
		Calendar endCal = Calendar.getInstance();
		endCal.setTime(endDate);
		endCal.set(Calendar.HOUR_OF_DAY, 0);
		endCal.set(Calendar.MINUTE, 0);
		endCal.set(Calendar.SECOND, 0);
		endCal.set(Calendar.MILLISECOND, 0);
		
		long t1 = beginCal.getTimeInMillis();
		long t2 = endCal.getTimeInMillis();
		return (int)(Math.abs(t2 - t1)/1000/3600/24) + 1;
	}
}
