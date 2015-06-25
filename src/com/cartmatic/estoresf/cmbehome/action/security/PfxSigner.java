package com.cartmatic.estoresf.cmbehome.action.security;

import java.security.PrivateKey;
import java.security.Signature;

import com.cartmatic.estoresf.cmbehome.action.help.Base64Utils;

/**
 * 
 * @author IVAN
 *
 */
public class PfxSigner implements Signer {

	private PrivateKey privateKey;
	private String algorithm = "SHA1withRSA";

	public PfxSigner(String fileName, String password) throws Exception {
		privateKey = SecurityUtils.getPrivateKeyFromPfx(fileName, password);
	}

	public String getAlgorithm() {
		return algorithm;
	}

	public void setAlgorithm(String algorithm) {
		this.algorithm = algorithm;
	}

	public String signature(String data) throws Exception {
		Signature signature = Signature.getInstance(algorithm);
		signature.initSign(privateKey);
		signature.update(data.getBytes("UTF-8"));
		return Base64Utils.encode(signature.sign());
	}

	public byte[] signature(byte[] data) throws Exception {
		Signature signature = Signature.getInstance(algorithm);
		signature.initSign(privateKey);
		signature.update(data);
		return signature.sign();
	}
}
