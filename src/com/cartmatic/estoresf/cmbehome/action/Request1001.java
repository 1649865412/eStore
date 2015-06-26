package com.cartmatic.estoresf.cmbehome.action;

import com.google.gson.annotations.Expose;

public class Request1001 extends BaseRequest{
	@Expose
    public String SellerName;

	@Expose
    public String OrderNo;

	@Expose
    public String PaymentNo;

	@Expose
    public String ItemName;

	@Expose
    public int Amount;

	@Expose
    public String OrderDate;

	@Expose
    public String USRNBR;

	@Expose
    public String Token;

	@Expose
    public String Usage;

	@Expose
    public String Remark;
	
	@Expose
    public String FontURL;

	public String getSellerName() {
		return SellerName;
	}

	public void setSellerName(String sellerName) {
		SellerName = sellerName;
	}

	public String getOrderNo() {
		return OrderNo;
	}

	public void setOrderNo(String orderNo) {
		OrderNo = orderNo;
	}

	public String getPaymentNo() {
		return PaymentNo;
	}

	public void setPaymentNo(String paymentNo) {
		PaymentNo = paymentNo;
	}

	public String getItemName() {
		return ItemName;
	}

	public void setItemName(String itemName) {
		ItemName = itemName;
	}

	public int getAmount() {
		return Amount;
	}

	public void setAmount(int amount) {
		Amount = amount;
	}

	public String getOrderDate() {
		return OrderDate;
	}

	public void setOrderDate(String orderDate) {
		OrderDate = orderDate;
	}

	public String getUSRNBR() {
		return USRNBR;
	}

	public void setUSRNBR(String uSRNBR) {
		USRNBR = uSRNBR;
	}

	public String getToken() {
		return Token;
	}

	public void setToken(String token) {
		Token = token;
	}

	public String getUsage() {
		return Usage;
	}

	public void setUsage(String usage) {
		Usage = usage;
	}

	public String getRemark() {
		return Remark;
	}

	public void setRemark(String remark) {
		Remark = remark;
	}
	
	public Request1001(){
		this.OptType = 1001;
	}

	public String getFontURL() {
		return FontURL;
	}

	public void setFontURL(String fontURL) {
		FontURL = fontURL;
	}
    
    
}
