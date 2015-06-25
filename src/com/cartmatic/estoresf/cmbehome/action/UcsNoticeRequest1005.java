package com.cartmatic.estoresf.cmbehome.action;

import com.cartmatic.estoresf.cmbehome.action.help.GsonUtils;
import com.google.gson.annotations.Expose;

public class UcsNoticeRequest1005 {
    @Expose
	private String Source;
    @Expose
	private String OptType;
    @Expose
	private String OrderNo;
    @Expose
	private String RefundNo;
    @Expose
	private String Amount;
    @Expose
	private String CState;
    @Expose
	private String CMsg;
    @Expose
	private String RefundTime;
    
    public UcsNoticeRequest1005(String plainText) {
    	UcsNoticeRequest1005 noticeRequest= GsonUtils.fromJson(plainText,this.getClass());

        if(noticeRequest!=null)
        {
        	this.Source = noticeRequest.getSource();
        	this.OptType = noticeRequest.getOptType();
        	this.OrderNo = noticeRequest.getOrderNo();
        	this.RefundNo = noticeRequest.getRefundNo();
        	this.Amount = noticeRequest.getAmount();
        	this.CState = noticeRequest.getCState();
        	this.CMsg = noticeRequest.getCMsg();
        	this.RefundTime = noticeRequest.getRefundTime();
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
	public String getRefundNo() {
		return RefundNo;
	}
	public void setRefundNo(String refundNo) {
		RefundNo = refundNo;
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
	public String getRefundTime() {
		return RefundTime;
	}
	public void setRefundTime(String refundTime) {
		RefundTime = refundTime;
	}
    
    
}
