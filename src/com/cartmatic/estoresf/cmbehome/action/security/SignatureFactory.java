package com.cartmatic.estoresf.cmbehome.action.security;

import java.util.HashMap;

/**
 * 
 * @author IVAN
 *
 */
public class SignatureFactory {
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private static HashMap<String, Signer> signaturerMap = new HashMap();
	@SuppressWarnings({ "unchecked", "rawtypes" })
	private static HashMap<String, Verifier> verifierMap = new HashMap();
	private static String defaultSigner;
	private static String defaultVerifier;

	public static void addSigner(String key, Signer value) {
		signaturerMap.put(key, value);
		defaultSigner = key;
	}

	public static void addVerifier(String key, Verifier value) {
		verifierMap.put(key, value);
		defaultVerifier = key;
	}
	
	
	public static Signer getSigner() {
		return (Signer) signaturerMap.get("signer");
	}

	public static Signer getSigner(String paramString) {
		return (Signer) signaturerMap.get(paramString);
	}

	public static Verifier getVerifier() {
		return (Verifier) verifierMap.get(defaultVerifier);
	}

	public static Verifier getVerifier(String paramString) {
		return (Verifier) verifierMap.get(paramString);
	}

	public static void clearVerifier() {
		verifierMap.clear();
	}
}
