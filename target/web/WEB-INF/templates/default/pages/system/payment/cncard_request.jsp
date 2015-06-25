<%@ page import="java.util.*,java.text.*,
				com.cartmatic.estore.common.model.order.SalesOrder"
				errorPage="/error.jsp"
 %>
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<META http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	DecimalFormat df=new java.text.DecimalFormat("0.00");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
	//c_signstr=MD5(c_mid & c_order & c_orderamount & c_ymd & c_moneytype & c_retflag & c_returl & c_paygate & c_memo1 & c_memo2 &notifytype & c_language & c_pass)
	String originalText=paymentMethod.getConfigData().get("c_mid").toString();
	originalText+=salesOrder.getOrderNo();
	originalText+=df.format(salesOrder.getShouldPay());
	originalText+=sdf.format(salesOrder.getCreateTime());
	originalText+=paymentMethod.getConfigData().get("c_moneytype").toString();
	originalText+="1" + paymentMethod.getConfigData().get("c_returl");
	originalText+="0" + paymentMethod.getPaymentMethodId()+ salesOrder.getOrderNo();
	originalText+="1" + paymentMethod.getConfigData().get("c_language").toString();
	originalText+=paymentMethod.getConfigData().get("c_pass").toString();

	String c_signstr=com.cartmatic.estore.system.util.TranslateService.md5Translate(originalText);
	//
	String requestUrl="";
	if(paymentMethod.getConfigData().get("testModel").equals("Y")){
		requestUrl="https://www.cncard.net/testport/port_test11.asp";		
	}else{
		//requestUrl="https://www.cncard.net/purchase/getorder.asp";		
		requestUrl="https://www.cncard.net/cnpayment/pay/getorder.aspx";
	}
	
%>
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
		<form name="paymentGatewayForm" method="post" action="<%=requestUrl%>">
			<input type="hidden" name="c_mid" value="${paymentMethod.configData.c_mid}">   
			<input type="hidden" name="c_order" value="<%=salesOrder.getOrderNo() %>">	   
			<input type="hidden" name="c_name" value="<%=salesOrder.getCustomerFirstName()+" " + salesOrder.getCustomerLastname()%>">   
			<input type="hidden" name="c_address" value="<%=salesOrder.getCustomerAddress()%>">   
			<input type="hidden" name="c_tel" value="<%=salesOrder.getCustomerTelephone() %>">   
			<input type="hidden" name="c_post" value="<%=salesOrder.getCustomerZip() %>">   
			<input type="hidden" name="c_email" value="<%=salesOrder.getCustomerEmail() %>">
			<input type="hidden" name="c_orderamount" value="<%=df.format(salesOrder.getShouldPay())%>">   
			<input type="hidden" name="c_ymd" value="<%=sdf.format(salesOrder.getCreateTime()) %>">   
			<input type="hidden" name="c_moneytype" value="${paymentMethod.configData.c_moneytype}">   
			<input type="hidden" name="c_retflag" value="1">  
			<input type="hidden" name="c_returl" value="${paymentMethod.configData.c_returl}">
			<input type="hidden" name="c_paygate" value="0">
			<input type="hidden" name="c_memo1" value="<%=paymentMethod.getPaymentMethodId() %>">
			<input type="hidden" name="c_memo2" value="<%=salesOrder.getOrderNo() %>">
			<input type="hidden" name="c_language" value="${paymentMethod.configData.c_language}">
			<input type="hidden" name="notifytype" value="1">
			<input type="hidden" name="c_signstr" value="<%=c_signstr %>">
	    </form> 
	<%@ include file="./include/payOrderTips.jspf" %></body>
</html>
