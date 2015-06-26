package com.cartmatic.estoresf.cmbehome.action.security;

import java.io.FileInputStream;
import java.security.KeyStore;
import java.security.PrivateKey;
import java.util.Enumeration;

/**
 * 
 * @author IVAN
 *
 */
public class SecurityUtils {

	public static PrivateKey getPrivateKeyFromPfx(String fileName,
			String password) throws Exception {
		KeyStore store = KeyStore.getInstance("PKCS12");

		FileInputStream stream = new FileInputStream(fileName);
		store.load(stream, password.toCharArray());
		stream.close();

		@SuppressWarnings({ "rawtypes" })
		Enumeration aliases = store.aliases();

		String alias = (String) aliases.nextElement();

		return ((PrivateKey) store.getKey(alias, password.toCharArray()));
	}

}
