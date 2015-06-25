
<%@page import="com.cartmatic.estore.common.model.system.PaymentMethod"%><%
	//Description: money booker payment gateway configuration
	//Author:chenshangxuan
	//CreateTime:2006-07-31
%>
<%@ page import="java.util.*,java.text.*,
				com.cartmatic.estore.common.model.order.SalesOrder"
				errorPage="/error.jsp"
 %>
<%
	SalesOrder salesOrder=(SalesOrder)request.getAttribute("salesOrder");
	PaymentMethod paymentMethod=(PaymentMethod)request.getAttribute("paymentMethod");
	DecimalFormat df=new java.text.DecimalFormat("0.00");
%>
<html>
	<head>
		<title></title>
			<script type="text/javascript">
			window.onload=function(){
				document.forms["paymentGatewayForm"].submit();
			}
		</script>
 		<%@ include file="./include/inc_common_request_js.jspf" %>
	</head>
	<body>
		<form action="https://www.moneybookers.com/app/payment.pl" name="paymentGatewayForm" method="post">
			<input type="hidden" name="pay_to_email" value="${paymentMethod.configData.payToEmail}">
			<input type="hidden" name="transaction_id" value="<%=salesOrder.getOrderNo() %>">
			<input type="hidden" name="return_url" value="http://61.144.61.134/payment/getDataFromGateway.jsp">
			<input type="hidden" name="cancel_url" value="http://61.144.61.134/payment/getDataFromGateway.jsp">
			<input type="hidden" name="status_url" value="<%=salesOrder.getCustomerEmail() %>"> 
			<input type="hidden" name="language" value="${paymentMethod.configData.language}">
			<input type="hidden" name="amount" value="<%=df.format(salesOrder.getTotal()) %>">
			<input type="hidden" name="currency" value="${paymentMethod.configData.currency}">

			<input type="hidden" name="firstname" value="<%=salesOrder.getCustomerFirstName() %>">
			<input type="hidden" name="lastname" value="<%=salesOrder.getCustomerLastname() %>">
			<input type="hidden" name="address" value="<%%>">
			<input type="hidden" name="postal_code" value="<%=salesOrder.getCustomerZip() %>">
			<input type="hidden" name="city" value="">
			<input type="hidden" name="state" value="">
			<input type="hidden" name="country" value="">

			<input type="hidden" name="detail1_description" value="(Cart)Order:">
			<input type="hidden" name="detail1_text" value="<%=salesOrder.getOrderNo() %>">
			
		</form> 
	<%@ include file="./include/payOrderTips.jspf" %></body>
</html>
