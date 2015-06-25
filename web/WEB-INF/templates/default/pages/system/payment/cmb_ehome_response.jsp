<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder,
com.cartmatic.estore.common.model.system.Store,
com.cartmatic.estore.common.helper.ConfigUtil,
com.cartmatic.estore.common.model.system.PaymentMethod,
java.text.DecimalFormat,
java.text.SimpleDateFormat,
com.bocnet.common.security.PKCS7Tool"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	<%@page
	import="com.cartmatic.estore.common.model.order.SalesOrder,
	com.cartmatic.estore.common.model.system.Store,
	com.cartmatic.estore.common.helper.ConfigUtil,
	com.cartmatic.estore.webapp.util.RequestContext,
	com.cartmatic.estore.common.model.system.PaymentMethod,
	java.text.DecimalFormat,java.text.SimpleDateFormat,
	com.cartmatic.estoresf.cmbehome.action.Response1001,
	com.cartmatic.estoresf.cmbehome.action.help.*"%>
<%
String succeed ="";
String billNo ="";  
String amount ="";
String date = "";
String succFlag="0";
Store store = ConfigUtil.getInstance().getStore();
WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("cmbehome");
try{
	 String data = request.getParameter("data");
	 String signdata = request.getParameter("signdata");
	 Response1001 resp = new Response1001(data, signdata);
	 succeed =resp.getCState();
	 billNo = resp.getOrderNo();  
	 amount = (resp.getAmount()/100)+"";
	 date = resp.getPayTime();
	/*
	0 = 支付异常 ; 1 = 已支付  ; -1 = 处理中
	successFlag 1=success,0=fail,-1=wait; 
	*/
	if ("1".equals(succeed))
	{
		succFlag="1";
	}
	else if("2".equals(succeed)){
		//此处可在联调的时候 ，改为-1，正处理中，1可处理成功，由招商那边继续调用！
		succFlag="-1";
	}
	else
	{
		succFlag="0";
	}
	
}catch(Exception e){
	
}
	//StringBuffer originalText = new  StringBuffer(paymentMethod.getConfigData().get("merchantNo"));
	//originalText.append("|");
	StringBuffer originalText = new StringBuffer();
	originalText.append(billNo);
	originalText.append("|");
	originalText.append(date);
	originalText.append("|");
	originalText.append(succeed);
	originalText.append("|");
	originalText.append(amount);
	
	request.setAttribute("orderNo",billNo);
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	request.setAttribute("amount",amount);
	request.setAttribute("errorMessage", originalText.toString());
		
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>

