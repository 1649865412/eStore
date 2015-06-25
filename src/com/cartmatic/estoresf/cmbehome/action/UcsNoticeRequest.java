package com.cartmatic.estoresf.cmbehome.action;

import java.nio.charset.Charset;

import com.cartmatic.estoresf.cmbehome.action.help.Base64Utils;
import com.cartmatic.estoresf.cmbehome.action.help.JsonUtils;
import com.cartmatic.estoresf.cmbehome.action.security.SignatureFactory;
import com.google.gson.annotations.Expose;

/**
 * 
 * @author IVAN
 *
 */
public class UcsNoticeRequest {

	@Expose
	public int OptType = 1002;
	public String jsonResult;

	private String request_data;
	private String request_signdata;
	private String requestPlainText;

	public UcsNoticeRequest(String data, String signdata) throws Exception {
		this.request_data = data;
		this.request_signdata = signdata;
		this.requestPlainText = new String(Base64Utils.decode(data),
				Charset.forName("UTF-8"));

		if ((!(SignatureFactory.getVerifier().verify(data, signdata)))
				&& (!(SignatureFactory.getVerifier().verify(
						this.requestPlainText, signdata)))) {
			throw new Exception("��֤ǩ��ʧ�ܡ�");
		}

		this.jsonResult = JsonUtils
				.convertToJavaDateTime(this.requestPlainText);
		this.OptType = 1002;
		//System.out.println("optype:"+JsonUtils.getIntProperty("OptType", this.jsonResult));
		//this.OptType = JsonUtils.getIntProperty("OptType", this.jsonResult);
	}

	public int getOptType() {
		return OptType;
	}

	public void setOptType(int optType) {
		OptType = optType;
	}

	public String getJsonResult() {
		return jsonResult;
	}

	public void setJsonResult(String jsonResult) {
		this.jsonResult = jsonResult;
	}

	public String getRequest_data() {
		return request_data;
	}

	public void setRequest_data(String request_data) {
		this.request_data = request_data;
	}

	public String getRequest_signdata() {
		return request_signdata;
	}

	public void setRequest_signdata(String request_signdata) {
		this.request_signdata = request_signdata;
	}

	public String getRequestPlainText() {
		return requestPlainText;
	}

	public void setRequestPlainText(String requestPlainText) {
		this.requestPlainText = requestPlainText;
	}

}
