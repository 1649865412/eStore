package com.cartmatic.estoresf.cmbehome.action;

import java.nio.charset.Charset;

import com.cartmatic.estoresf.cmbehome.action.help.Base64Utils;
import com.cartmatic.estoresf.cmbehome.action.help.GsonUtils;
import com.cartmatic.estoresf.cmbehome.action.help.UcsApiMessage;
import com.cartmatic.estoresf.cmbehome.action.security.SignatureFactory;
import com.google.gson.annotations.Expose;

/**
 * 
 * @author IVAN
 *
 */
public class UcsNoticeResponse {
	@Expose
	public int Code;
	@Expose
	public String Message;

	protected String responsePlainText;
	protected String responseMessage;
	protected String responseSignature;

	protected String jsonResult;

	public UcsNoticeResponse(int code, String message) throws Exception {

		this.Code = code;
		this.Message = message;

		String jsonResult = GsonUtils.toJson(this);

		this.responsePlainText = jsonResult;
		this.responseMessage = Base64Utils.encode(jsonResult.getBytes(Charset
				.forName("UTF-8")));
		
		this.responseSignature = SignatureFactory.getSigner().signature(
				jsonResult);

	/*	UcsApiMessage apiMessage = new UcsApiMessage(responseMessage,
				responseSignature);
		this.jsonResult = GsonUtils.toJson(apiMessage);*/
		this.jsonResult = "data=" + responseMessage + "&signdata=" + responseSignature;
	}

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

	public String getResponseMessage() {
		return responseMessage;
	}

	public void setResponseMessage(String responseMessage) {
		this.responseMessage = responseMessage;
	}

	public String getResponseSignature() {
		return responseSignature;
	}

	public void setResponseSignature(String responseSignature) {
		this.responseSignature = responseSignature;
	}

	public String getJsonResult() {
		return jsonResult;
	}

	public void setJsonResult(String jsonResult) {
		this.jsonResult = jsonResult;
	}

}
