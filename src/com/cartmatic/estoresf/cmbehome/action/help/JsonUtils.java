package com.cartmatic.estoresf.cmbehome.action.help;

import java.lang.reflect.Type;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.google.gson.Gson;

/**
 * 
 * @author IVAN
 *
 */
public class JsonUtils {

	@SuppressWarnings("unchecked")
	public static <T> T jsonToObject(String json, Type type) {
		Gson gson = new Gson();
		return (T) gson.fromJson(json, type);
	}

	public static String objectToJson(Object o, Type type) {
		Gson gson = new Gson();
		return gson.toJson(o, type);
	}

	public static int getIntProperty(String key, String source) {
		Pattern pattern = Pattern.compile("\"" + key + "\":(-?\\d+)");
		Matcher matcher = pattern.matcher(source);

		String value = null;

		if (matcher.find()) {
			value = matcher.group(1);
		}

		if (value != null) {
			try {
				return Integer.parseInt(value);
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}

		return Integer.parseInt(null);
	}

	public static String getStringProperty(String key, String source) {
		Pattern pattern = Pattern.compile("\"" + key + "\":\"(.+?)\"");
		Matcher matcher = pattern.matcher(source);
		if (matcher.find()) {
			return matcher.group(1);
		}
		return null;
	}

	public static String convertToCSharpDateTime(String source) {
		Pattern pattern = Pattern
				.compile("\"\\d{4}-\\d{2}-\\d{2}\\s\\d{2}:\\d{2}:\\d{2}\\.\\d{3}\"");
		Matcher matcher = pattern.matcher(source);
		StringBuffer sb = new StringBuffer();
		while (matcher.find()) {
			try {
				String value = matcher.group();
				long date = DateUtils.getTimestamp(value);
				String format = "\"\\/Date(" + date + ")\\/\"";
				matcher.appendReplacement(sb, format);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		matcher.appendTail(sb);

		return sb.toString();
	}

	public static String convertToJavaDateTime(String source) {
		Pattern pattern = Pattern.compile("\"\\\\/Date\\((\\d+)\\)\\\\/\"");
		Matcher matcher = pattern.matcher(source);
		StringBuffer sb = new StringBuffer();
		while (matcher.find()) {
			try {
				long value = Long.parseLong(matcher.group(1));
				String date = DateUtils.getDateTime(value);

				String format = "\"" + date + "\"";
				matcher.appendReplacement(sb, format);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		matcher.appendTail(sb);

		return sb.toString();
	}
}