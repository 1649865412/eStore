package com.cartmatic.estoresf.cmbehome.action.help;

import java.nio.charset.Charset;

/**
 * 
 * @author IVAN
 *
 */
public class HttpResult {
	public int contentLength;
	public int httpStatusCode;
	public String statusDescription;
	public byte[] result;

	public int getContentLength() {
		return contentLength;
	}

	public void setContentLength(int contentLength) {
		this.contentLength = contentLength;
	}

	public int getHttpStatusCode() {
		return httpStatusCode;
	}

	public void setHttpStatusCode(int httpStatusCode) {
		this.httpStatusCode = httpStatusCode;
	}

	public String getStatusDescription() {
		return statusDescription;
	}

	public void setStatusDescription(String statusDescription) {
		this.statusDescription = statusDescription;
	}

	public byte[] getResult() {
		return result;
	}

	public void setResult(byte[] result) {
		this.result = result;
	}

	public String getResultString() {
		return new String(result, Charset.forName("UTF-8"));
	}
}
