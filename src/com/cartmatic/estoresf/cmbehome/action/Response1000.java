package com.cartmatic.estoresf.cmbehome.action;

import com.google.gson.annotations.Expose;

/**
 * 
 * @author IVAN
 * 
 */
public class Response1000 extends BaseResponse {
	@Expose
	protected String Source;
	@Expose
	protected String OptType;
	@Expose
	protected String USRNBR;
	@Expose
	protected String USRName;
	@Expose
	protected String Token;

	public String getSource() {
		return Source;
	}

	public void setSource(String source) {
		Source = source;
	}

	public String getOptType() {
		return OptType;
	}

	public void setOptType(String optType) {
		OptType = optType;
	}

	public String getUSRNBR() {
		return USRNBR;
	}

	public void setUSRNBR(String uSRNBR) {
		USRNBR = uSRNBR;
	}

	public String getUSRName() {
		return USRName;
	}

	public void setUSRName(String uSRName) {
		USRName = uSRName;
	}

	public String getToken() {
		return Token;
	}

	public void setToken(String token) {
		Token = token;
	}

	public Response1000(String responseData, String responseSigndata)
			throws Exception {
		super(responseData, responseSigndata);
	}

	@Override
	protected void Deserialize(String plainText) {
		if (this.Code == 100) {
			Response1000 obj = (Response1000) CommonJson.dataFromJson(plainText,Response1000.class);
			if(obj != null){
				this.Source= obj.getSource();
				this.OptType = obj.getOptType();
				this.USRNBR = obj.getUSRNBR();
				this.USRName = obj.getUSRName();
				this.Token = obj.getToken();
			}
		}
	}
}
