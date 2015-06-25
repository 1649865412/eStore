package com.cartmatic.estoresf.cmbehome.action;

import com.cartmatic.estoresf.cmbehome.action.help.Base64Utils;
import com.cartmatic.estoresf.cmbehome.action.help.JsonUtils;
import com.cartmatic.estoresf.cmbehome.action.security.SignatureFactory;
import com.google.gson.annotations.Expose;

/**
 * 
 * @author IVAN
 * 
 */
public abstract class BaseResponse {

	@Expose
	protected int Code;
	@Expose
	protected String Message;

	public int getCode() {
		return Code;
	}

	public void setCode(int code) {
		Code = code;
	}

	public String getMessage() {
		return Message;
	}

	public void setMessage(String message) {
		Message = message;
	}

	public String getResponsePlainText() {
		return responsePlainText;
	}

	public void setResponsePlainText(String responsePlainText) {
		this.responsePlainText = responsePlainText;
	}

	public String getResponseData() {
		return responseData;
	}

	public void setResponseData(String responseData) {
		this.responseData = responseData;
	}

	public String getResponseSigndata() {
		return responseSigndata;
	}

	public void setResponseSigndata(String responseSigndata) {
		this.responseSigndata = responseSigndata;
	}

	protected String responsePlainText;
	protected String responseData;
	protected String responseSigndata;

	public BaseResponse(String responseData, String responseSigndata)
			throws Exception {
		this.responseData = responseData;
		this.responseSigndata = responseSigndata;

		byte[] source = Base64Utils.decode(responseData);

		this.responsePlainText = new String(source, "UTF-8");

		byte[] signature = Base64Utils.decode(responseSigndata);

		if (!SignatureFactory.getVerifier().verify(source, signature)) {
			throw new Exception("��ǩʧ��");
		}
		try {
			this.Code = JsonUtils.getIntProperty("Code", this.responsePlainText);
			this.Message = JsonUtils.getStringProperty("Message",
					this.responsePlainText);
		} catch (Exception ex) {

		}
		String plainText = JsonUtils
				.convertToJavaDateTime(this.responsePlainText);
		Deserialize(plainText);
	}

	protected abstract void Deserialize(String plainText);
}
