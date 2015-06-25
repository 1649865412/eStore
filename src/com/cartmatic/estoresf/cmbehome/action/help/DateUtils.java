package com.cartmatic.estoresf.cmbehome.action.help;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 
 * @author IVAN
 *
 */
public class DateUtils {

	public static final String DEFAULT_DATE_PATTERN = "yyyy-MM-dd HH:mm:ss";

	public static Date convertToDate(String date) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat(DEFAULT_DATE_PATTERN);

		return format.parse(date);
	}

	public static long getTimestamp(String date) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat(DEFAULT_DATE_PATTERN);

		Date dateTime = format.parse(date);

		return dateTime.getTime();
	}

	public static String getDateTime(long timestamp) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat(DEFAULT_DATE_PATTERN);

		Long time = new Long(timestamp);

		return format.format(time);

	}

	public static String formatDate(Date date, String pattern) {

		if (pattern == null || "".equals(pattern)) {
			pattern = DEFAULT_DATE_PATTERN;
		}

		SimpleDateFormat format = new SimpleDateFormat(pattern);

		return format.format(date);
	}
}