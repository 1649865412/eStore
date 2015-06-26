package com.cartmatic.estoresf.cmbehome.action.help;

import javax.net.ssl.*;
import java.io.DataOutputStream;
import java.net.URL;
import java.security.SecureRandom;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

/**
 * 
 * @author IVAN
 *
 */
public class HttpsRequester implements HttpWebRequester {

	private static class X509TrustManagerImpl implements X509TrustManager {

		public void checkClientTrusted(X509Certificate[] chain, String authType)
				throws CertificateException {
		}

		public void checkServerTrusted(X509Certificate[] chain, String authType)
				throws CertificateException {
		}

		public X509Certificate[] getAcceptedIssuers() {
			return new X509Certificate[] {};
		}
	}

	private static class HostnameVerifierImpl implements HostnameVerifier {
		public boolean verify(String hostname, SSLSession session) {
			return true;
		}
	}

	private HttpsURLConnection createHttpUrlConnection(String url)
			throws Exception {

		System.setProperty("jsse.enableSNIExtension", "false");

		URL uri = new URL(url);
		HttpsURLConnection httpsUrlConnection = (HttpsURLConnection) uri
				.openConnection();

		SSLContext sslContext = SSLContext.getInstance("SSL");
		sslContext.init(null,
				new TrustManager[] { new X509TrustManagerImpl() },
				new SecureRandom());

		httpsUrlConnection.setSSLSocketFactory(sslContext.getSocketFactory());
		httpsUrlConnection.setHostnameVerifier(new HostnameVerifierImpl());

		httpsUrlConnection
				.setConnectTimeout(HttpWebRequesterConfig.CONNECTION_TIMEOUT);
		httpsUrlConnection.setReadTimeout(HttpWebRequesterConfig.READ_TIMEOUT);
		httpsUrlConnection.setDoOutput(true);
		httpsUrlConnection.setDoInput(true);
		httpsUrlConnection.setUseCaches(false);
		httpsUrlConnection.setRequestProperty("Charset",
				HttpWebRequesterConfig.CHARSET);
		httpsUrlConnection.setRequestProperty("User-Agent",
				HttpWebRequesterConfig.USER_AGENT);

		HttpsURLConnection.setFollowRedirects(true);

		return httpsUrlConnection;
	}

	@Override
	public HttpResult doPost(String url, HttpData httpData) {

		HttpResult httpResult = new HttpResult();
		try {

			byte[] postData = httpData.getPostData().getBytes(
					HttpWebRequesterConfig.CHARSET);

			HttpsURLConnection httpsUrlConnection = createHttpUrlConnection(url);

			httpsUrlConnection.setRequestMethod("POST");
			httpsUrlConnection.setRequestProperty("Content-Type",
					"application/x-www-form-urlencoded");
			httpsUrlConnection.setRequestProperty("Content-Length",
					String.valueOf(postData.length));

			httpsUrlConnection.connect();

			DataOutputStream dos = new DataOutputStream(
					httpsUrlConnection.getOutputStream());
			dos.write(postData);
			dos.flush();
			dos.close();

			httpResult.setHttpStatusCode(httpsUrlConnection.getResponseCode());
			httpResult.setStatusDescription(httpsUrlConnection
					.getResponseMessage());
			httpResult.setContentLength(httpsUrlConnection.getContentLength());
			httpResult.setResult(HttpUtils.stream2Byte(
					httpsUrlConnection.getInputStream(),
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
			HttpsURLConnection httpsUrlConnection = createHttpUrlConnection(url);
			httpsUrlConnection.setRequestMethod("GET");
			httpsUrlConnection.setRequestProperty("Content-Type",
					"text/xml; charset=UTF-8");

			httpsUrlConnection.connect();

			httpResult.setHttpStatusCode(httpsUrlConnection.getResponseCode());
			httpResult.setStatusDescription(httpsUrlConnection
					.getResponseMessage());
			httpResult.setContentLength(httpsUrlConnection.getContentLength());
			httpResult.setResult(HttpUtils.stream2Byte(
					httpsUrlConnection.getInputStream(),
					HttpWebRequesterConfig.BUFFER_SIZE));
		} catch (Exception e) {
			httpResult.setHttpStatusCode(-200);
			httpResult.setStatusDescription(e.getMessage());

			e.printStackTrace();
		}
		return httpResult;
	}
}
