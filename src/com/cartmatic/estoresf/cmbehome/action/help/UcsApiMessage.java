package com.cartmatic.estoresf.cmbehome.action.help;

import com.google.gson.annotations.Expose;

/**
 * 
 * @author IVAN
 *
 */
public class UcsApiMessage {
	@Expose
	public String data;
	@Expose
	public String signdata;

	public UcsApiMessage() {
	}

	public UcsApiMessage(String data, String signdata) {
		this.data = data;
		this.signdata = signdata;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getSigndata() {
		return signdata;
	}

	public void setSigndata(String signdata) {
		this.signdata = signdata;
	}

}
