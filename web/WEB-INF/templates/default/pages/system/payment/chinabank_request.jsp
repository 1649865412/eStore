
<%@page import="com.cartmatic.estore.common.model.order.SalesOrder"%>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="java.text.DecimalFormat"%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	DecimalFormat df=new java.text.DecimalFormat("0.00");
	
	//v_amount+v_moneytype+v_oid+v_mid+v_url+key

	String originalText=df.format(salesOrder.getShouldPay())+paymentMethod.getConfigData().get("v_moneytype");
		originalText+=salesOrder.getOrderNo();
		originalText+=paymentMethod.getConfigData().get("v_mid");
		originalText+=paymentMethod.getConfigData().get("v_url");
		originalText+=paymentMethod.getConfigData().get("key");
		System.out.println("test:" + originalText);
		String v_md5info=com.cartmatic.estore.system.util.TranslateService.md5Translate(originalText);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<script type="text/javascript">
			window.onload=function(){
				document.forms["paymentGatewayForm"].submit();
			}
		</script>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
	</head>
	<body>
		<form name="paymentGatewayForm" method="post" action="https://pay3.chinabank.com.cn/PayGate">
			<input name="v_mid" type="hidden" value="${paymentMethod.configData.v_mid}">
			<input name="v_oid" type="hidden" value="<%=salesOrder.getOrderNo()%>" >
			<input name="v_amount" type="hidden" value="<%=df.format(salesOrder.getShouldPay())%>">
			<input name="v_moneytype" type="hidden" value="${paymentMethod.configData.v_moneytype}">
			<input name="v_url" type="hidden" value="${paymentMethod.configData.v_url}" >
		    <input name="v_md5info" type="hidden" value="<%=v_md5info.toUpperCase() %>">
			<input name="remark1" type="hidden" value="<%=paymentMethod.getPaymentMethodId()%>">
			<input name="remark2" type="hidden" value="<%=paymentMethod.getPaymentMethodId()%>">
			<input name="v_rcvname" type="hidden" value="<%=salesOrder.getShippingFirstname() + " " + salesOrder.getShippingLastname()%>">
			<input name="v_rcvaddr" type="hidden" value="<%=salesOrder.getShippingAddress()%>">
			<input name="v_rcvtel" type="hidden" value="<%=salesOrder.getShippingTelephone()%>">
			<input name="v_rcvpost" type="hidden" value="<%=salesOrder.getShippingZip()%>">	
			<input name="v_ordername" type="hidden" value="<%=salesOrder.getCustomerFirstName()%>" >
			<input name="v_orderemail" type="hidden" value="<%=salesOrder.getCustomerEmail()%>">
	    </form> 
	<%@ include file="./include/payOrderTips.jspf" %></body>
</html>