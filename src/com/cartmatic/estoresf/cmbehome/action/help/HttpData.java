package com.cartmatic.estoresf.cmbehome.action.help;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * 
 * @author IVAN
 *
 */
public class HttpData {
	Map<String, String> dataMap = new HashMap<String, String>();

	public void put(String key, String value) {
		if (!dataMap.containsKey(key)) {
			dataMap.put(key, value);
		}
	}

	public String getPostData() throws UnsupportedEncodingException {
		StringBuffer sb = new StringBuffer();

		@SuppressWarnings("rawtypes")
		Iterator iterator = dataMap.entrySet().iterator();
		while (iterator.hasNext()) {
			@SuppressWarnings("rawtypes")
			Map.Entry entry = (Map.Entry) iterator.next();

			sb.append("&");
			sb.append(entry.getKey());
			sb.append("=");
			sb.append(URLEncoder.encode(entry.getValue().toString(), "UTF-8"));

		}
		String result = sb.toString().substring(1);

		return result;
	}
}
