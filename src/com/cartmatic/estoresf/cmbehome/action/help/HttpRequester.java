package com.cartmatic.estoresf.cmbehome.action.help;

import java.io.DataOutputStream;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;

/**
 * 
 * @author IVAN
 *
 */
public class HttpRequester implements HttpWebRequester {

	private HttpURLConnection createHttpUrlConnection(String url)
			throws IOException {
		URL uri = new URL(url);
		HttpURLConnection httpUrlConnection = (HttpURLConnection) uri
				.openConnection();

		httpUrlConnection
				.setConnectTimeout(HttpWebRequesterConfig.CONNECTION_TIMEOUT);
		httpUrlConnection.setReadTimeout(HttpWebRequesterConfig.READ_TIMEOUT);
		httpUrlConnection.setDoOutput(true);
		httpUrlConnection.setDoInput(true);
		httpUrlConnection.setUseCaches(false);
		httpUrlConnection.setRequestProperty("Charset",
				HttpWebRequesterConfig.CHARSET);
		httpUrlConnection.setRequestProperty("User-Agent",
				HttpWebRequesterConfig.USER_AGENT);

		HttpURLConnection.setFollowRedirects(true);

		return httpUrlConnection;
	}

	@Override
	public HttpResult doPost(String url, HttpData httpData) {

		HttpResult httpResult = new HttpResult();
		try {

			byte[] postData = httpData.getPostData().getBytes(
					HttpWebRequesterConfig.CHARSET);

			HttpURLConnection httpUrlConnection = createHttpUrlConnection(url);

			httpUrlConnection.setRequestMethod("POST");
			httpUrlConnection.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			httpUrlConnection.setRequestProperty("Content-Length",
					String.valueOf(postData.length));

			httpUrlConnection.connect();

			DataOutputStream dos = new DataOutputStream(
					httpUrlConnection.getOutputStream());
			dos.write(postData);
			dos.flush();
			dos.close();

			httpResult.setHttpStatusCode(httpUrlConnection.getResponseCode());
			httpResult.setStatusDescription(httpUrlConnection
					.getResponseMessage());
			httpResult.setContentLength(httpUrlConnection.getContentLength());
			httpResult.setResult(HttpUtils.stream2Byte(
					httpUrlConnection.getInputStream(),
					HttpWebRequesterConfig.BUFFER_SIZE));
		} catch (Exception e) {
			httpResult.setHttpStatusCode(-200);
			httpResult.setStatusDescription(e.getMessage());

			e.printStackTrace();
		}

		return httpResult;
	}

	@Override
	public HttpResult doGet(String url) throws Exception {
		HttpResult httpResult = new HttpResult();
		try {
			HttpURLConnection httpUrlConnection = createHttpUrlConnection(url);
			httpUrlConnection.setRequestMethod("GET");
			httpUrlConnection.setRequestProperty("Content-Type",
					"text/xml; charset=UTF-8");

			httpUrlConnection.connect();

			httpResult.setHttpStatusCode(httpUrlConnection.getResponseCode());
			httpResult.setStatusDescription(httpUrlConnection
					.getResponseMessage());
			httpResult.setContentLength(httpUrlConnection.getContentLength());
			httpResult.setResult(HttpUtils.stream2Byte(
					httpUrlConnection.getInputStream(),
					HttpWebRequesterConfig.BUFFER_SIZE));
		} catch (Exception e) {
			httpResult.setHttpStatusCode(-200);
			httpResult.setStatusDescription(e.getMessage());

			e.printStackTrace();
		}
		return httpResult;
	}
}
