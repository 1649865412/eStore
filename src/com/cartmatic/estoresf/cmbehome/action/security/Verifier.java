package com.cartmatic.estoresf.cmbehome.action.security;

/**
 * ������ǩ�ӿ�
 */
public abstract interface Verifier {
	public abstract boolean verify(String source, String signature)
			throws Exception;

	public abstract boolean verify(byte[] source, byte[] signature)
			throws Exception;
}