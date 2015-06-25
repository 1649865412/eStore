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
<%
	Store store = ConfigUtil.getInstance().getStore();
	WebApplicationContext webAppContext=WebApplicationContextUtils.getWebApplicationContext(pageContext.getServletContext());
	PaymentMethodManager paymentMethodManager=(PaymentMethodManager)webAppContext.getBean("paymentMethodManager");
	PaymentMethod paymentMethod=paymentMethodManager.getPaymentMethodByCode("cmb");
	
	//订单状态：Y成功，N失败。
	String succeed = request.getParameter("Succeed");
	String billNo = request.getParameter("BillNo");
	String amount = request.getParameter("Amount");
	String date = request.getParameter("Date");
	String msg = request.getParameter("Msg");
	String signature = request.getParameter("signature");
	
	String succFlag="0";
	if ("Y".equals(succeed))
	{
		succFlag="1";
	}
	else
	{
		succFlag="-1";
	}
	
	StringBuffer originalText = new  StringBuffer(paymentMethod.getConfigData().get("merchantNo"));
	originalText.append("|");
	originalText.append(billNo);
	originalText.append("|");
	originalText.append(date);
	originalText.append("|");
	originalText.append(succeed);
	originalText.append("|");
	originalText.append(amount);
	
	request.setAttribute("orderNo",request.getParameter("BillNo"));
	request.setAttribute("successFlag",succFlag);
	request.setAttribute("paymentMethodId",paymentMethod.getPaymentMethodId());
	request.setAttribute("amount",amount);
	request.setAttribute("errorMessage", originalText.toString());
	
%>
<%@include file="./include/finishPayResult.jspf"%>
<%@include file="./include/inc_common_response.jspf"%>
