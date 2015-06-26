package com.cartmatic.estoresf.cmbehome.action.help;


/**
 * 
 * @author IVAN
 *
 */
public class HttpServices {

	public UcsApiMessage doPost(String url, String data, String signdata)
			throws Exception {
		HttpData httpData = new HttpData();
		httpData.put("data", data);
		httpData.put("signdata", signdata);

		try {
			HttpWebRequester webRequester = null;

			if (url.toLowerCase().startsWith("https://")) {
				webRequester = new HttpsRequester();
			} else {
				webRequester = new HttpRequester();
			}
			HttpResult result = webRequester.doPost(url, httpData);

			if (result.getHttpStatusCode() == 200) {
				try {
					String respStr = result.getResultString();
					respStr = respStr.replace("&signdata=", "\",\"signdata\":\"");
					respStr = respStr.replace("data=", "{\"data\":\"");
					respStr = respStr + "\"}";
					UcsApiMessage responseMessage = GsonUtils.fromJson(
							respStr, UcsApiMessage.class);
					if (responseMessage.getSigndata() == null
							|| "".equals(responseMessage.getSigndata().trim())) {
						throw new Exception(responseMessage.getData());
					}
					return responseMessage;
				} catch (Exception e) {
					throw new Exception(result.getResultString());
				}
			} else {
				throw new Exception("无法获取远程数据");
			}

		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e.getMessage());
		}

	}
}
