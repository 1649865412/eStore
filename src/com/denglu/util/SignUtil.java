package com.denglu.util;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;

public class SignUtil {

	
	/**
	 * 功能:sign签名
	 * <p>作者 杨荣忠 2015-6-4 下午03:09:42
	 * @param parmMap
	 * @param apiSecret
	 * @return
	 */
	public static String signMD5(Map parmMap, String apiSecret){
		if (parmMap == null || parmMap.isEmpty()) {
			return "";
		}
		StringBuffer parm = new StringBuffer("");
		Set<Entry> entrySet = parmMap.entrySet();
		for(Entry entry:entrySet){
			parm.append(entry.getKey());
			parm.append("=");
			parm.append(entry.getValue());
		}
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		byte[] digest = md.digest((parm.toString() + apiSecret).getBytes());
		return SignUtil.toHex(digest);
	}

	public static String toHex(byte[] buffer) {
		if(buffer != null){
			StringBuffer sb = new StringBuffer(buffer.length * 2);
			for (int i = 0; i < buffer.length; i++) {
				sb.append(Character.forDigit((buffer[i] & 0xf0) >> 4, 16));
				sb.append(Character.forDigit(buffer[i] & 0x0f, 16));
			}
			return sb.toString();
		}
		return "";
	}

	
	/**
	 * 功能: 获取用户信息接口url
	 * <p>作者 杨荣忠 2015-6-4 下午03:08:21
	 * @param path
	 * @return
	 * @throws Exception
	 */
	public static String connect(String path) throws Exception {
		URL url = new URL(path);
		HttpURLConnection httpUrl = (HttpURLConnection) url.openConnection();
		InputStream is = httpUrl.getInputStream();
		BufferedReader in = new BufferedReader(new InputStreamReader(is, "utf-8"));
		StringBuffer buffer = new StringBuffer();
		String line;
		while ((line = in.readLine()) != null) {
			buffer.append(line);
		}
		is.close();
		String result = buffer.toString();
		httpUrl.disconnect();
		return result;
	}
}
