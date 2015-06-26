package com.cartmatic.estoresf.cmbehome.action.help;

import javax.net.ssl.HostnameVerifier;
import javax.net.ssl.SSLSession;

/**
 * 
 * @author IVAN
 *
 */
public class IgnoreHostnameVerifier implements HostnameVerifier {
	@Override
	public boolean verify(String s, SSLSession sslSession) {
		return true;
	}
}
