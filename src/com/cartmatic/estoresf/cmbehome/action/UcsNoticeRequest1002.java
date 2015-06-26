package com.cartmatic.estoresf.cmbehome.action;

import com.cartmatic.estoresf.cmbehome.action.help.GsonUtils;
import com.google.gson.annotations.Expose;

/**
 * 
 * @author IVAN
 *
 */
public class UcsNoticeRequest1002 {

    @Expose
	private String Source;
    @Expose
	private String OptType;
    @Expose
	private String OrderNo;
    @Expose
	private String PaymentNo;
    @Expose
	private String Amount;
    @Expose
	private String CState;
    @Expose
	private String CMsg;
    @Expose
	private String PayTime;
    
    
    public UcsNoticeRequest1002(String plainText) {
    	UcsNoticeRequest1002 noticeRequest= GsonUtils.fromJson(plainText,this.getClass());

        if(noticeRequest!=null)
        {
        	this.Source = noticeRequest.getSource();
        	this.OptType = noticeRequest.getOptType();
        	this.OrderNo = noticeRequest.getOrderNo();
        	this.PaymentNo = noticeRequest.getPaymentNo();
        	this.Amount = noticeRequest.getAmount();
        	this.CState = noticeRequest.getCState();
        	this.CMsg = noticeRequest.getCMsg();
        	this.PayTime = noticeRequest.getPayTime();
        }
    }


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


	public String getAmount() {
		return Amount;
	}


	public void setAmount(String amount) {
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
    
}
