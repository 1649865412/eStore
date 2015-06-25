package com.cartmatic.estoresf.cmbehome.action.security;

public abstract interface Signer {

	public abstract String signature(String data) throws Exception;

	public abstract byte[] signature(byte[] data) throws Exception;
}
