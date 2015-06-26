
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%><%
	//Worldpay request form page
	//create time:2006-07-24
%>
<%@ page import="java.util.*,java.text.*,
				com.cartmatic.estore.common.model.order.SalesOrder"
				errorPage="/error.jsp"
 %>
<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	HashMap paramMap=paymentMethod.getConfigData();
	DecimalFormat df=new java.text.DecimalFormat("0.00");
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
		<form action="https://select.worldpay.com/wcc/purchase" method="POST" name="paymentGatewayForm">
			<input type="hidden" name="instId" value="${paymentMethod.configData.instId}">
			<input type="hidden" name="cartId" value="101">
			<input type="hidden" name="amount" value="<%=df.format(salesOrder.getTotal()) %>">
			<input type="hidden" name="testMode" value="${paymentMethod.configData.testMode}">
			<input type="hidden" name="currency" value="${paymentMethod.configData.currency}">
			<input type="hidden" name="desc" value="Order No:<%=salesOrder.getOrderNo() %>">	
			<input type="hidden" name="name" value="<%=salesOrder.getCustomerFirstName()+ " " + salesOrder.getCustomerLastname() %>">
			<input type="hidden" name="tel" value="<%=salesOrder.getCustomerTelephone() %>">
			<input type="hidden" name="email" value="<%=salesOrder.getCustomerEmail() %>">
			<input type="hidden" name="address" value="<%=salesOrder.getCustomerAddress() %>">
			<input type="hidden" name="postcode" value="<%=salesOrder.getCustomerZip() %>">
			<input type="hidden" name="country" value="<%=salesOrder.getCustomerCountry() %>">
		</form>	
	<%@ include file="./include/payOrderTips.jspf" %></body>
</html>