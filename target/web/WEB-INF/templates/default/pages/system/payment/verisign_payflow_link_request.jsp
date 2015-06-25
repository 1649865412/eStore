
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%>
<%@page import="java.text.DecimalFormat"%><%
	/***********************************************************************
		verisign payment gateway request form 
	***********************************************************************/
%>
<%@ page contentType="text/html; charset=UTF-8" 
		import="com.cartmatic.estore.common.model.order.SalesOrder,java.util.HashMap" 
		errorPage="/error.jsp"
%>

<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	HashMap paramMap=paymentMethod.getConfigData();
	
	String host="";
	if(paramMap.get("server").equals("USA")){
		host="https://payments.verisign.com/payflowlink";
	}else {
		host="https://payments.verisign.com.au/payflowlink";
	}
	DecimalFormat df=new java.text.DecimalFormat("0.00");
/**
	[TODO] billing information is present the cardholder's information,which can get from our system
*/
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
  <form action="<%=host%>" method="POST" name="paymentGatewayForm">
		<input type="hidden" name="USER1" value="<%=salesOrder.getOrderNo()%>">
		<input type="hidden" name="login" value="<%=paramMap.get("login") %>">
		<input type="hidden" name="partner" value="<%=paramMap.get("partner") %>">
		<input type="hidden" name="amount" value="<%=df.format(salesOrder.getShouldPay())%>">
		<input type="hidden" name="description" value="Order No:<%=salesOrder.getOrderNo()%>">
		<input type="hidden" name="type" value="S">
		<input type="hidden" name="orderform" value="true">
		<input type="hidden" name="method" value="cc">
	  	<input type="hidden" name="name" value="<%=salesOrder.getCustomerFirstName() + salesOrder.getCustomerLastname()%>">
	  	<input type="hidden" name="nametoship" value="<%=salesOrder.getShippingFirstname()+salesOrder.getShippingLastname() %>">
		<input type="hidden" name="email" value="<%=salesOrder.getCustomerEmail() %>">
		<input type="hidden" name="emailtoship" value="<%=salesOrder.getCustomerEmail() %>">
		<input type="hidden" name="phone" value="<%=salesOrder.getCustomerTelephone() %>">
		<input type="hidden" name="phonetoship" value="<%=salesOrder.getShippingTelephone() %>">
		<input type="hidden" name="invoice" value="<%=salesOrder.getOrderNo() %>">
		<input type="hidden" name="address" value="<%=salesOrder.getBillingAddress()%>">
		<input type="hidden" name="addresstoship" value="<%=salesOrder.getShippingAddress() %>">
		<input type="hidden" name="city" value="<%=salesOrder.getBillingCity() %>">
		<input type="hidden" name="citytoship" value="<%=salesOrder.getShippingCity() %>">
		<input type="hidden" name="country" value="<%=salesOrder.getBillingCountry() %>">
		<input type="hidden" name="countrytoship" value="<%=salesOrder.getShippingCountry() %>">
		<input type="hidden" name="state" value="<%=salesOrder.getBillingState() %>">
		<input type="hidden" name="statetoship" value="<%=salesOrder.getShippingState() %>">
		<input type="hidden" name="zip" value="<%=salesOrder.getBillingZip() %>">
		<input type="hidden" name="ziptoship" value="<%=salesOrder.getShippingZip() %>">
		<input type="hidden" name="echodata" value="true">
		<input type="hidden" name="showconfirm" value="true">
	</form>
 <%@ include file="./include/payOrderTips.jspf" %></body>
</html>