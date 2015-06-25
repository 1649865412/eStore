package com.cartmatic.estoresf.cmbehome.action;

import com.cartmatic.estoresf.cmbehome.action.help.GsonUtils;
import com.google.gson.annotations.Expose;

public class Response1001 extends BaseResponse {

	@Expose
	private String Source;
	@Expose
	private String OptType;
	@Expose
	private String OrderNo;
	@Expose
	private String PaymentNo;
	@Expose
	private int Amount;
	@Expose
	private String CState;
	@Expose
	private String CMsg;
	@Expose
	private String PayTime;
	
	public String getSource() {
		return Source;
	}

	public void setSource(String source) {
		Source = source;
	}

	public String getOptType() {
		return OptType;
	}

	public void setOptType(String optType) {
		OptType = optType;
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

	public int getAmount() {
		return Amount;
	}

	public void setAmount(int amount) {
		Amount = amount;
	}

	public String getCState() {
		return CState;
	}

	public void setCState(String cState) {
		CState = cState;
	}

	public String getCMsg() {
		return CMsg;
	}

	public void setCMsg(String cMsg) {
		CMsg = cMsg;
	}

	public String getPayTime() {
		return PayTime;
	}

	public void setPayTime(String payTime) {
		PayTime = payTime;
	}

	public Response1001(String responseData, String responseSigndata)
			throws Exception {
		super(responseData, responseSigndata);
	}

	@Override
	protected void Deserialize(String plainText) {
		Response1001 response = GsonUtils.fromJson(plainText, Response1001.class);
		if(response != null){
		    this.Source = response.getSource();
		    this.OptType = response.getOptType();
		    this.OrderNo = response.getOrderNo();
		    this.PaymentNo = response.getPaymentNo();
		    this.Amount = response.getAmount();
		    this.CState = response.getCState();
		    this.CMsg = response.getCMsg();
		    this.PayTime = response.getPayTime();
		}
	}

}
