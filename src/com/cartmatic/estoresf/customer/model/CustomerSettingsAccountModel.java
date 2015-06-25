package com.cartmatic.estoresf.customer.model;

import java.io.Serializable;

public class CustomerSettingsAccountModel implements Serializable {
	private String password;
	private String email;
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
}
