<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.text.*,
	com.cartmatic.estore.common.model.order.SalesOrder"
	errorPage="/error.jsp"
%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%
		SalesOrder salesOrder = (SalesOrder) request.getAttribute("salesOrder");
		PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
		DecimalFormat df=new DecimalFormat("0.00");
		
		String baseURL=request.getScheme()+"://" + request.getHeader("host")+request.getContextPath();
		
		double amount=salesOrder.getShouldPay().doubleValue();
		
		if("Y".equals(paymentMethod.getConfigData().get("testModel").toString())){
			amount=0.00;
		}
%>
<html>
<head>
	<title>Connect the e-gold payment...</title>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
</head>
<body onload="document.paymentGatewayForm.submit();">
	<form name="paymentGatewayForm" action="https://www.e-gold.com/sci_asp/payments.asp" method="POST">
			<input type="hidden" name="PAYEE_ACCOUNT" value="${paymentMethod.configData.account}">
			<input type="hidden" name="PAYEE_NAME" value="${paymentMethod.configData.payee_name}">
			<input type="hidden" name="PAYMENT_AMOUNT" value="<%=df.format(amount)%>">
			<input type="hidden" name="PAYMENT_UNITS" value="${paymentMethod.configData.payment_units}">
			<input type="hidden" name="PAYMENT_METAL_ID" value="${paymentMethod.configData.payment_metal_id}">
			<input type="hidden" name="STATUS_URL"	value="mailto:${paymentMethod.configData.status_url}">
			<input type="hidden" name="NOPAYMENT_URL" value="<%=baseURL%>/cart/shoppingcart.html">
			<input type="hidden" name="NOPAYMENT_URL_METHOD" value="LINK">
			<input type="hidden" name="PAYMENT_URL"	value="<%=baseURL%>/system/payment/egold_response.html">
			<input type="hidden" name="PAYMENT_URL_METHOD" value="POST">
			<input type="hidden" name="BAGGAGE_FIELDS" value="ORDER_NO">
			<input type="hidden" name="ORDER_NO" value="<%=salesOrder.getOrderNo()%>">
	</form>
<%@ include file="./include/payOrderTips.jspf" %></body>
