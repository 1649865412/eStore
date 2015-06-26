package com.cartmatic.estoresf.cmbehome.action;

import com.google.gson.annotations.Expose;

public class Request1007 extends BaseRequest{

	@Expose
	protected String USRNBR;

	public String getUSRNBR() {
		return USRNBR;
	}

	public void setUSRNBR(String uSRNBR) {
		USRNBR = uSRNBR;
	}
	
	public Request1007(){
		this.OptType = 1007;
	}
	
}
