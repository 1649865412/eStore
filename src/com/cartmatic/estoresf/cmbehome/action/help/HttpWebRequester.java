package com.cartmatic.estoresf.cmbehome.action.help;

/**
 * 
 * @author IVAN
 *
 */
public abstract interface HttpWebRequester {
	public abstract HttpResult doPost(String url, HttpData httpData)
			throws Exception;

	public abstract HttpResult doGet(String url) throws Exception;
}
