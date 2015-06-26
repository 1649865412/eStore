package com.cartmatic.estoresf.cmbehome.action;

import com.google.gson.annotations.Expose;

public class Response1007 extends BaseResponse {

	@Expose
	private String Token;

	public String getToken() {
		return Token;
	}

	public void setToken(String token) {
		Token = token;
	}

	public Response1007(String responseData, String responseSigndata)
			throws Exception {
		super(responseData, responseSigndata);
	}

	@Override
	protected void Deserialize(String plainText) {
		if (this.Code == 100) {
			Response1007 obj = (Response1007) CommonJson.dataFromJson(plainText,Response1007.class);
			if(obj != null){
				this.Token = obj.getToken();
			}
		}
	}

}
