package com.cartmatic.estoresf.cmbehome.action;

import java.nio.charset.Charset;

import com.cartmatic.estoresf.cmbehome.action.help.Base64Utils;
import com.cartmatic.estoresf.cmbehome.action.help.GsonUtils;
import com.cartmatic.estoresf.cmbehome.action.security.SignatureFactory;
import com.google.gson.annotations.Expose;

/**
 * 
 * @author IVAN
 * 
 */
public class BaseRequest {

	@Expose
	protected String MallId;
	@Expose
	protected int OptType;

	protected String requestPlainText;
	protected String requestData;
	protected String requestSigndata;

	public String getMallId() {
		return MallId;
	}

	public void setMallId(String MallId) {
		this.MallId = MallId;
	}

	public int getOptType() {
		return OptType;
	}

	public void setOptType(int OptType) {
		this.OptType = OptType;
	}

	public String getRequestPlainText() {
		return requestPlainText;
	}

	public void setRequestPlainText(String requestPlainText) {
		this.requestPlainText = requestPlainText;
	}
	
	public String getRequestData() {
		return requestData;
	}

	public void setRequestData(String requestData) {
		this.requestData = requestData;
	}

	public String getRequestSigndata() {
		return requestSigndata;
	}

	public void setRequestSigndata(String requestSigndata) {
		this.requestSigndata = requestSigndata;
	}

	
	public void serialize() throws Exception {
		String jsonResult = GsonUtils.toJson(this);
		System.out.println("jsonResult"+jsonResult);
		//System.out.println("new SignatureFactory"+new SignatureFactory());
		//System.out.println("SignatureFactory"+ SignatureFactory.getSigner());
	    //System.out.println("new SignatureFactory.getSigner()"+new SignatureFactory().getSigner());
		this.requestPlainText = jsonResult;
		this.requestData = Base64Utils.encode(jsonResult.getBytes(Charset.forName("UTF-8")));
		this.requestSigndata = SignatureFactory.getSigner().signature(jsonResult);
	}

}
