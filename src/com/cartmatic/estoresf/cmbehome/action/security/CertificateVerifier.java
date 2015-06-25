package com.cartmatic.estoresf.cmbehome.action.security;

import java.io.FileInputStream;
import java.security.PublicKey;
import java.security.Signature;
import java.security.cert.CertificateFactory;

import com.cartmatic.estoresf.cmbehome.action.help.Base64Utils;

/**
 * X509֤����ǩʵ����
 */
public class CertificateVerifier implements Verifier {
	private PublicKey publicKey;
	private String algorithm = "SHA1withRSA";

	public CertificateVerifier(String fileName) throws Exception {
		FileInputStream stream = new FileInputStream(fileName);
		CertificateFactory factory = CertificateFactory.getInstance("X.509");
		this.publicKey = factory.generateCertificate(stream).getPublicKey();
	}

	public boolean verify(String source, String signature) throws Exception {
		byte[] signatureByte = Base64Utils.decode(signature);
		Signature instance = Signature.getInstance(algorithm);
		instance.initVerify(publicKey);
		instance.update(source.getBytes("UTF-8"));
		return instance.verify(signatureByte);
	}

	public boolean verify(byte[] source, byte[] signature) throws Exception {
		Signature instance = Signature.getInstance(algorithm);
		instance.initVerify(publicKey);
		instance.update(source);
		return instance.verify(signature);
	}
}
